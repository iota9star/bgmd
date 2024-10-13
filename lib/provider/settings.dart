import 'package:jiffy/jiffy.dart';
import 'package:path/path.dart' as path;

import '../bgmd.dart';

class AppSettings extends ChangeNotifier {
  ThemeMode get themeMode {
    final mode = HiveBoxes.settings.get('theme_mode', defaultValue: ThemeMode.system.name);
    return ThemeMode.values.firstWhere((e) => e.name == mode);
  }

  set themeMode(ThemeMode value) {
    HiveBoxes.settings.put('theme_mode', value.name).then((_) {
      notifyListeners();
    });
  }

  Locale get locale {
    final locale = HiveBoxes.settings.get('locale') as String;
    final split = locale.split('_');
    final matched = AppLocalizations.supportedLocales.firstWhereOrNull(
      (e) => e.languageCode == split[0] && e.scriptCode == split.getOrNull(1),
    );
    return matched ?? AppLocalizations.supportedLocales.first;
  }

  set locale(Locale value) {
    final code = value.scriptCode != null ? '${value.languageCode}_${value.scriptCode}' : value.languageCode;
    HiveBoxes.settings.put('locale', code).then((_) {
      return setJiffyLocale(value);
    }).then((_) {
      notifyListeners();
    });
  }

  Color get seedColor {
    final color = HiveBoxes.settings.get(
      'seed_color',
      defaultValue: Colors.lightGreenAccent.shade400.value,
    );
    return Color(color);
  }

  set seedColor(Color value) {
    HiveBoxes.settings.put('seed_color', value.value).then((_) {
      notifyListeners();
    });
  }

  DisplayMode get displayMode {
    final mode = HiveBoxes.settings.get('display_mode', defaultValue: DisplayMode.grid.name);
    return DisplayMode.values.firstWhere((e) => e.name == mode);
  }

  set displayMode(DisplayMode value) {
    HiveBoxes.settings.put('display_mode', value.name).then((_) {
      notifyListeners();
    });
  }

  bool get dynamicColorEnabled {
    return HiveBoxes.settings.get('dynamic_color', defaultValue: false);
  }

  set dynamicColorEnabled(bool value) {
    HiveBoxes.settings.put('dynamic_color', value).then((_) {
      notifyListeners();
    });
  }

  TabletMode get tabletMode {
    final mode = HiveBoxes.settings.get('tablet_mode', defaultValue: TabletMode.auto.name);
    return TabletMode.values.firstWhere((e) => e.name == mode);
  }

  set tabletMode(TabletMode value) {
    HiveBoxes.settings.put('tablet_mode', value.name).then((_) {
      notifyListeners();
    });
  }

  String get cacheDir {
    return HiveBoxes.settings.get('cache_dir');
  }

  set cacheDir(String value) {
    HiveBoxes.settings.put('cache_dir', value).then((_) {
      notifyListeners();
    });
  }

  String get imageCacheDir {
    return path.join(cacheDir, 'images');
  }
}

enum DisplayMode {
  grid,
  land,
}

final settingsProvider = ChangeNotifierProvider((ref) => AppSettings());

Future<void> setJiffyLocale(Locale locale) {
  if (locale.scriptCode == 'Hant') {
    return Jiffy.setLocale('zh_tw');
  }
  if (locale.languageCode == 'zh') {
    return Jiffy.setLocale('zh_cn');
  }
  return Jiffy.setLocale(locale.languageCode);
}
