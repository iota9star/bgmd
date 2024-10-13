import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../bgmd.dart';

class HiveBoxes {
  const HiveBoxes._();

  static late final Box settings;
  static late final Box<BangumiData> data;
  static late final Box<Bangumi> collections;

  static Future<void> init() async {
    await Hive.initFlutter('hive');
    Hive.registerAdapter(SiteMetaAdapter());
    Hive.registerAdapter(SiteAdapter());
    Hive.registerAdapter(ItemAdapter());
    Hive.registerAdapter(SiteTypeAdapter());
    Hive.registerAdapter(LanguageAdapter());
    Hive.registerAdapter(ItemTypeAdapter());
    Hive.registerAdapter(BangumiDataAdapter());
    Hive.registerAdapter(SeasonAdapter());
    Hive.registerAdapter(SeasonTypeAdapter());
    Hive.registerAdapter(WeekdayAdapter());
    Hive.registerAdapter(WeekAdapter());
    Hive.registerAdapter(BangumiAdapter());
    settings = await Hive.openBox('settings-v1');
    data = await Hive.openBox('data-v1');
    collections = await Hive.openBox('collections-v1');
    if (!kIsWeb) {
      final directory = await getTemporaryDirectory();
      await settings.put('cache_dir', directory.path);
    }
  }
}

class HiveTypeIds {
  const HiveTypeIds._();

  static const int SiteMeta = 1;
  static const int Site = 2;
  static const int Item = 3;
  static const int SiteType = 4;
  static const int Language = 5;
  static const int ItemType = 6;
  static const int BangumiData = 7;
  static const int Season = 8;
  static const int SeasonType = 9;
  static const int Weekday = 10;
  static const int Week = 11;
  static const int Bangumi = 12;
}
