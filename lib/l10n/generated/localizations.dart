import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations_en.dart';
import 'localizations_ja.dart';
import 'localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
  ];

  /// No description provided for @appName.
  ///
  /// In zh, this message translates to:
  /// **'BangumiD'**
  String get appName;

  /// No description provided for @bangumi.
  ///
  /// In zh, this message translates to:
  /// **'番组'**
  String get bangumi;

  /// No description provided for @archive.
  ///
  /// In zh, this message translates to:
  /// **'归档'**
  String get archive;

  /// No description provided for @newest.
  ///
  /// In zh, this message translates to:
  /// **'最新'**
  String get newest;

  /// No description provided for @collection.
  ///
  /// In zh, this message translates to:
  /// **'收藏'**
  String get collection;

  /// No description provided for @collectionNum.
  ///
  /// In zh, this message translates to:
  /// **'当前共收藏 {num} 部番剧'**
  String collectionNum(Object num);

  /// No description provided for @noDataFound.
  ///
  /// In zh, this message translates to:
  /// **'什么都没有发现'**
  String get noDataFound;

  /// No description provided for @officialSite.
  ///
  /// In zh, this message translates to:
  /// **'官网'**
  String get officialSite;

  /// No description provided for @exitText.
  ///
  /// In zh, this message translates to:
  /// **'是否退出应用？'**
  String get exitText;

  /// No description provided for @exitAction.
  ///
  /// In zh, this message translates to:
  /// **'退出'**
  String get exitAction;

  /// No description provided for @seasonSpringWithNum.
  ///
  /// In zh, this message translates to:
  /// **'{year} 年春季番组 ({num})'**
  String seasonSpringWithNum(Object num, Object year);

  /// No description provided for @seasonSummerWithNum.
  ///
  /// In zh, this message translates to:
  /// **'{year} 年夏季番组 ({num})'**
  String seasonSummerWithNum(Object num, Object year);

  /// No description provided for @seasonAutumnWithNum.
  ///
  /// In zh, this message translates to:
  /// **'{year} 年秋季番组 ({num})'**
  String seasonAutumnWithNum(Object num, Object year);

  /// No description provided for @seasonWinterWithNum.
  ///
  /// In zh, this message translates to:
  /// **'{year} 年冬季番组 ({num})'**
  String seasonWinterWithNum(Object num, Object year);

  /// No description provided for @seasonSpring.
  ///
  /// In zh, this message translates to:
  /// **'{year} 年春季'**
  String seasonSpring(Object year);

  /// No description provided for @seasonSummer.
  ///
  /// In zh, this message translates to:
  /// **'{year} 年夏季'**
  String seasonSummer(Object year);

  /// No description provided for @seasonAutumn.
  ///
  /// In zh, this message translates to:
  /// **'{year} 年秋季'**
  String seasonAutumn(Object year);

  /// No description provided for @seasonWinter.
  ///
  /// In zh, this message translates to:
  /// **'{year} 年冬季'**
  String seasonWinter(Object year);

  /// No description provided for @total.
  ///
  /// In zh, this message translates to:
  /// **'共 {num} 部番剧'**
  String total(Object num);

  /// No description provided for @spring.
  ///
  /// In zh, this message translates to:
  /// **'春'**
  String get spring;

  /// No description provided for @summer.
  ///
  /// In zh, this message translates to:
  /// **'夏'**
  String get summer;

  /// No description provided for @autumn.
  ///
  /// In zh, this message translates to:
  /// **'秋'**
  String get autumn;

  /// No description provided for @winter.
  ///
  /// In zh, this message translates to:
  /// **'冬'**
  String get winter;

  /// No description provided for @mondayWithNum.
  ///
  /// In zh, this message translates to:
  /// **'星期一 ({num})'**
  String mondayWithNum(Object num);

  /// No description provided for @tuesdayWithNum.
  ///
  /// In zh, this message translates to:
  /// **'星期二 ({num})'**
  String tuesdayWithNum(Object num);

  /// No description provided for @wednesdayWithNum.
  ///
  /// In zh, this message translates to:
  /// **'星期三 ({num})'**
  String wednesdayWithNum(Object num);

  /// No description provided for @thursdayWithNum.
  ///
  /// In zh, this message translates to:
  /// **'星期四 ({num})'**
  String thursdayWithNum(Object num);

  /// No description provided for @fridayWithNum.
  ///
  /// In zh, this message translates to:
  /// **'星期五 ({num})'**
  String fridayWithNum(Object num);

  /// No description provided for @saturdayWithNum.
  ///
  /// In zh, this message translates to:
  /// **'星期六 ({num})'**
  String saturdayWithNum(Object num);

  /// No description provided for @sundayWithNum.
  ///
  /// In zh, this message translates to:
  /// **'星期日 ({num})'**
  String sundayWithNum(Object num);

  /// No description provided for @monday.
  ///
  /// In zh, this message translates to:
  /// **'周一'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In zh, this message translates to:
  /// **'周二'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In zh, this message translates to:
  /// **'周三'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In zh, this message translates to:
  /// **'周四'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In zh, this message translates to:
  /// **'周五'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In zh, this message translates to:
  /// **'周六'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In zh, this message translates to:
  /// **'周日'**
  String get sunday;

  /// No description provided for @copied.
  ///
  /// In zh, this message translates to:
  /// **'已复制到剪切板。'**
  String get copied;

  /// No description provided for @settings.
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get settings;

  /// No description provided for @themeMode.
  ///
  /// In zh, this message translates to:
  /// **'主题模式'**
  String get themeMode;

  /// No description provided for @seedColor.
  ///
  /// In zh, this message translates to:
  /// **'主题色'**
  String get seedColor;

  /// No description provided for @primaryColor.
  ///
  /// In zh, this message translates to:
  /// **'主色'**
  String get primaryColor;

  /// No description provided for @custom.
  ///
  /// In zh, this message translates to:
  /// **'自定义'**
  String get custom;

  /// No description provided for @ui.
  ///
  /// In zh, this message translates to:
  /// **'界面'**
  String get ui;

  /// No description provided for @selectColor.
  ///
  /// In zh, this message translates to:
  /// **'选择主题色'**
  String get selectColor;

  /// No description provided for @tabletMode.
  ///
  /// In zh, this message translates to:
  /// **'平板模式'**
  String get tabletMode;

  /// No description provided for @auto.
  ///
  /// In zh, this message translates to:
  /// **'自动'**
  String get auto;

  /// No description provided for @off.
  ///
  /// In zh, this message translates to:
  /// **'关闭'**
  String get off;

  /// No description provided for @on.
  ///
  /// In zh, this message translates to:
  /// **'开启'**
  String get on;

  /// No description provided for @about.
  ///
  /// In zh, this message translates to:
  /// **'关于'**
  String get about;

  /// No description provided for @privacyPolicy.
  ///
  /// In zh, this message translates to:
  /// **'隐私政策'**
  String get privacyPolicy;

  /// No description provided for @license.
  ///
  /// In zh, this message translates to:
  /// **'开源许可'**
  String get license;

  /// No description provided for @cleanCache.
  ///
  /// In zh, this message translates to:
  /// **'清除缓存'**
  String get cleanCache;

  /// No description provided for @language.
  ///
  /// In zh, this message translates to:
  /// **'多语言'**
  String get language;

  /// No description provided for @zh.
  ///
  /// In zh, this message translates to:
  /// **'简体中文'**
  String get zh;

  /// No description provided for @zhHant.
  ///
  /// In zh, this message translates to:
  /// **'繁体中文'**
  String get zhHant;

  /// No description provided for @en.
  ///
  /// In zh, this message translates to:
  /// **'English'**
  String get en;

  /// No description provided for @ja.
  ///
  /// In zh, this message translates to:
  /// **'日本語'**
  String get ja;

  /// No description provided for @checkUpdate.
  ///
  /// In zh, this message translates to:
  /// **'检查更新'**
  String get checkUpdate;

  /// No description provided for @version.
  ///
  /// In zh, this message translates to:
  /// **'版本'**
  String get version;

  /// No description provided for @share.
  ///
  /// In zh, this message translates to:
  /// **'分享'**
  String get share;

  /// No description provided for @more.
  ///
  /// In zh, this message translates to:
  /// **'更多'**
  String get more;

  /// No description provided for @followSystem.
  ///
  /// In zh, this message translates to:
  /// **'跟随系统'**
  String get followSystem;

  /// No description provided for @saveSuccess.
  ///
  /// In zh, this message translates to:
  /// **'保存成功：{path}'**
  String saveSuccess(Object path);

  /// No description provided for @saveFailed.
  ///
  /// In zh, this message translates to:
  /// **'保存失败'**
  String get saveFailed;

  /// No description provided for @search.
  ///
  /// In zh, this message translates to:
  /// **'搜索'**
  String get search;

  /// No description provided for @searchHint.
  ///
  /// In zh, this message translates to:
  /// **'请输入搜索内容'**
  String get searchHint;

  /// No description provided for @searchResult.
  ///
  /// In zh, this message translates to:
  /// **'搜索关键字「{keywords}」，共找到 {num} 部番剧'**
  String searchResult(Object keywords, Object num);

  /// No description provided for @copyUrl.
  ///
  /// In zh, this message translates to:
  /// **'复制链接'**
  String get copyUrl;

  /// No description provided for @openUrl.
  ///
  /// In zh, this message translates to:
  /// **'在浏览器中打开'**
  String get openUrl;

  /// No description provided for @supportMe.
  ///
  /// In zh, this message translates to:
  /// **'支持一下'**
  String get supportMe;

  /// No description provided for @alipay.
  ///
  /// In zh, this message translates to:
  /// **'支付宝'**
  String get alipay;

  /// No description provided for @alipayDesc.
  ///
  /// In zh, this message translates to:
  /// **'按照提示，点击打开支付宝即可'**
  String get alipayDesc;

  /// No description provided for @wechat.
  ///
  /// In zh, this message translates to:
  /// **'微信'**
  String get wechat;

  /// No description provided for @wechatDesc.
  ///
  /// In zh, this message translates to:
  /// **'微信扫码或者下载图片在微信内识别'**
  String get wechatDesc;

  /// No description provided for @bootError.
  ///
  /// In zh, this message translates to:
  /// **'应用启动失败，请重新启动应用'**
  String get bootError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.scriptCode) {
          case 'Hant':
            return AppLocalizationsZhHant();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
