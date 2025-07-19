// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'BangumiD';

  @override
  String get bangumi => 'Bangumi';

  @override
  String get archive => 'Archive';

  @override
  String get newest => 'Newest';

  @override
  String get collection => 'Collection';

  @override
  String collectionNum(Object num) {
    return 'Currently collected $num anime';
  }

  @override
  String get noDataFound => 'Nothing found';

  @override
  String get officialSite => 'Official Site';

  @override
  String get exitText => 'Do you want to exit the app?';

  @override
  String get exitAction => 'Exit';

  @override
  String seasonSpringWithNum(Object num, Object year) {
    return '$year Spring Anime ($num)';
  }

  @override
  String seasonSummerWithNum(Object num, Object year) {
    return '$year Summer Anime ($num)';
  }

  @override
  String seasonAutumnWithNum(Object num, Object year) {
    return '$year Autumn Anime ($num)';
  }

  @override
  String seasonWinterWithNum(Object num, Object year) {
    return '$year Winter Anime ($num)';
  }

  @override
  String seasonSpring(Object year) {
    return '$year Spring';
  }

  @override
  String seasonSummer(Object year) {
    return '$year Summer';
  }

  @override
  String seasonAutumn(Object year) {
    return '$year Autumn';
  }

  @override
  String seasonWinter(Object year) {
    return '$year Winter';
  }

  @override
  String total(Object num) {
    return 'Total $num anime';
  }

  @override
  String get spring => 'Spring';

  @override
  String get summer => 'Summer';

  @override
  String get autumn => 'Autumn';

  @override
  String get winter => 'Winter';

  @override
  String mondayWithNum(Object num) {
    return 'Monday ($num)';
  }

  @override
  String tuesdayWithNum(Object num) {
    return 'Tuesday ($num)';
  }

  @override
  String wednesdayWithNum(Object num) {
    return 'Wednesday ($num)';
  }

  @override
  String thursdayWithNum(Object num) {
    return 'Thursday ($num)';
  }

  @override
  String fridayWithNum(Object num) {
    return 'Friday ($num)';
  }

  @override
  String saturdayWithNum(Object num) {
    return 'Saturday ($num)';
  }

  @override
  String sundayWithNum(Object num) {
    return 'Sunday ($num)';
  }

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get copied => 'Copied to clipboard.';

  @override
  String get settings => 'Settings';

  @override
  String get themeMode => 'Theme Mode';

  @override
  String get seedColor => 'Theme Color';

  @override
  String get primaryColor => 'Primary Color';

  @override
  String get custom => 'Custom';

  @override
  String get ui => 'UI';

  @override
  String get selectColor => 'Select Theme Color';

  @override
  String get tabletMode => 'Tablet Mode';

  @override
  String get auto => 'Auto';

  @override
  String get off => 'Off';

  @override
  String get on => 'On';

  @override
  String get about => 'About';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get license => 'Open Source License';

  @override
  String get cleanCache => 'Clear Cache';

  @override
  String get language => 'Language';

  @override
  String get zh => '简体中文';

  @override
  String get zhHant => '繁体中文';

  @override
  String get en => 'English';

  @override
  String get ja => '日本語';

  @override
  String get checkUpdate => 'Check for Updates';

  @override
  String get version => 'Version';

  @override
  String get share => 'Share';

  @override
  String get more => 'More';

  @override
  String get followSystem => 'Follow System';

  @override
  String saveSuccess(Object path) {
    return 'Save successful: $path';
  }

  @override
  String get saveFailed => 'Save failed';

  @override
  String get search => 'Search';

  @override
  String get searchHint => 'Please enter search content';

  @override
  String searchResult(Object keywords, Object num) {
    return 'Search keyword \"$keywords\", found $num anime';
  }

  @override
  String get copyUrl => 'Copy URL';

  @override
  String get openUrl => 'Open in Browser';

  @override
  String get supportMe => 'Support Me';

  @override
  String get alipay => 'Alipay';

  @override
  String get alipayDesc => 'Follow the instructions, click to open Alipay';

  @override
  String get wechat => 'WeChat';

  @override
  String get wechatDesc =>
      'Scan with WeChat or download the image to recognize in WeChat';

  @override
  String get bootError => 'App failed to start, please restart the app';
}
