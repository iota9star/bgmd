import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

import '../model/bangumi.dart';

export 'fetch_data.io.dart' if (dart.library.html) 'fetch_data.web.dart';

Future<BangumiData> innerFetch(String url) async {
  final response = await http.get(Uri.parse(url));
  final json = jsonDecode(response.body);
  final siteMeta = json['siteMeta'] as Map<String, dynamic>;
  final items = (json['items'] as List).map((e) => Item.fromJson(e)).sorted((a, b) {
    return DateTime.parse(b.begin).millisecondsSinceEpoch - DateTime.parse(a.begin).millisecondsSinceEpoch;
  });
  final last = items.last;
  int startYear = DateTime.parse(last.begin).year;
  final endYear = DateTime.now().year;
  final seasons = <Season>[];
  while (startYear <= endYear) {
    seasons.add(Season(year: startYear, season: SeasonType.winter, week: [], num: 0));
    seasons.add(Season(year: startYear, season: SeasonType.spring, week: [], num: 0));
    seasons.add(Season(year: startYear, season: SeasonType.summer, week: [], num: 0));
    seasons.add(Season(year: startYear, season: SeasonType.autumn, week: [], num: 0));
    startYear++;
  }
  for (final item in items) {
    final begin = DateTime.parse(item.begin);
    final season = SeasonType.fromMonth(begin.month);
    final seasonIndex = seasons.indexWhere((e) => e.year == begin.year && e.season == season);
    if (item.end == null || item.end!.isEmpty) {
      for (var i = seasonIndex; i < seasons.length; i++) {
        final week = seasons[i].week;
        final weekday = Weekday.fromInt(begin.weekday);
        final find = week.firstWhereOrNull((e) => e.weekday == weekday);
        if (find == null) {
          week.add(Week(weekday: weekday, items: [item]));
        } else {
          find.items.add(item);
        }
      }
    } else {
      final end = DateTime.parse(item.end!);
      final endSeason = SeasonType.fromMonth(end.month);
      final endSeasonIndex = seasons.indexWhere((e) => e.year == end.year && e.season == endSeason);
      for (var i = seasonIndex; i <= endSeasonIndex; i++) {
        final week = seasons[i].week;
        final weekday = Weekday.fromInt(begin.weekday);
        final find = week.firstWhereOrNull((e) => e.weekday == weekday);
        if (find == null) {
          week.add(Week(weekday: weekday, items: [item]));
        } else {
          find.items.add(item);
        }
      }
    }
  }
  return BangumiData(
    siteMeta: Map.fromEntries(
      siteMeta.entries.map((e) {
        return MapEntry(e.key, SiteMeta.fromJson(e.value));
      }),
    ),
    seasons: seasons
        .where((e) => e.week.isNotEmpty)
        .map((e) {
          e.week.sort((a, b) => a.weekday.index - b.weekday.index);
          e.num = e.week.map((e) => e.items.length).reduce((value, element) => value + element);
          return e;
        })
        .toList()
        .reversed
        .toList(),
  );
}
