import 'dart:async';

import 'package:fuzzywuzzy/fuzzywuzzy.dart';

import '../bgmd.dart';

final bangumiDataProvider = StateProvider.autoDispose<BangumiData>((ref) {
  return HiveBoxes.data.get('data')!;
});

final bangumiSeasonProvider = Provider.autoDispose((ref) {
  final bangumiData = ref.watch(bangumiDataProvider);
  return bangumiData.seasons;
});

final bangumiYearProvider = Provider.autoDispose((ref) {
  final bangumiData = ref.watch(bangumiDataProvider);
  final grouped = bangumiData.seasons.groupListsBy((it) => it.year);
  return grouped.entries.sorted((a, b) => b.key.compareTo(a.key));
});

final latestSeasonProvider = Provider.autoDispose((ref) {
  final bangumiData = ref.watch(bangumiDataProvider);
  final season = bangumiData.seasons.first;
  final currentDay = DateTime.now().weekday;
  season.week.sort((a, b) {
    final aIndex = (a.weekday.index - currentDay + 7) % 7;
    final bIndex = (a.weekday.index - currentDay + 7) % 7;
    return aIndex.compareTo(bIndex);
  });
  return season;
});

final siteMetaProvider = Provider.autoDispose<Map<String, SiteMeta>>((ref) {
  final bangumiData = ref.watch(bangumiDataProvider);
  return bangumiData.siteMeta;
});

final itemProvider = Provider.autoDispose<Item>((ref) => throw UnimplementedError());
final seasonProvider = Provider.autoDispose<Season>((ref) => throw UnimplementedError());
final itemsProvider = Provider.autoDispose<List<Item>>((ref) => throw UnimplementedError());

final searchProvider = FutureProvider.autoDispose.family<(String, List<Bangumi>), String>((ref, keywords) {
  final bangumiData = ref.watch(bangumiDataProvider);
  final completer = Completer<(String, List<Bangumi>)>();
  final timer = Timer(const Duration(milliseconds: 500), () {
    if (keywords.isEmpty) {
      completer.complete((keywords, <Bangumi>[]));
      return;
    }
    final seasons = bangumiData.seasons;
    final find = <Bangumi>{};
    for (final season in seasons) {
      final weeks = season.week;
      for (final week in weeks) {
        for (final item in week.items) {
          int score = 0;
          if (item.titleTranslate.values.any((v) {
            for (final value in v) {
              final s = partialRatio(value, keywords);
              score = s > score ? s : score;
            }
            return score >= 90;
          })) {
            final value =
                Bangumi(season: season.season, week: week.weekday, item: item, year: season.year, score: score);
            find.add(value);
          }
        }
      }
    }
    completer.complete((keywords, find.sorted((a, b) => b.score.compareTo(a.score))));
  });
  ref.onDispose(() {
    timer.cancel();
    if (!completer.isCompleted) {
      completer.completeError('cancel');
    }
  });
  return completer.future;
});

final bangumiProvider = Provider.autoDispose<Bangumi>((ref) => throw UnimplementedError());
