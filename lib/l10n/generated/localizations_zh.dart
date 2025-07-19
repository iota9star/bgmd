// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => 'BangumiD';

  @override
  String get bangumi => '番组';

  @override
  String get archive => '归档';

  @override
  String get newest => '最新';

  @override
  String get collection => '收藏';

  @override
  String collectionNum(Object num) {
    return '当前共收藏 $num 部番剧';
  }

  @override
  String get noDataFound => '什么都没有发现';

  @override
  String get officialSite => '官网';

  @override
  String get exitText => '是否退出应用？';

  @override
  String get exitAction => '退出';

  @override
  String seasonSpringWithNum(Object num, Object year) {
    return '$year 年春季番组 ($num)';
  }

  @override
  String seasonSummerWithNum(Object num, Object year) {
    return '$year 年夏季番组 ($num)';
  }

  @override
  String seasonAutumnWithNum(Object num, Object year) {
    return '$year 年秋季番组 ($num)';
  }

  @override
  String seasonWinterWithNum(Object num, Object year) {
    return '$year 年冬季番组 ($num)';
  }

  @override
  String seasonSpring(Object year) {
    return '$year 年春季';
  }

  @override
  String seasonSummer(Object year) {
    return '$year 年夏季';
  }

  @override
  String seasonAutumn(Object year) {
    return '$year 年秋季';
  }

  @override
  String seasonWinter(Object year) {
    return '$year 年冬季';
  }

  @override
  String total(Object num) {
    return '共 $num 部番剧';
  }

  @override
  String get spring => '春';

  @override
  String get summer => '夏';

  @override
  String get autumn => '秋';

  @override
  String get winter => '冬';

  @override
  String mondayWithNum(Object num) {
    return '星期一 ($num)';
  }

  @override
  String tuesdayWithNum(Object num) {
    return '星期二 ($num)';
  }

  @override
  String wednesdayWithNum(Object num) {
    return '星期三 ($num)';
  }

  @override
  String thursdayWithNum(Object num) {
    return '星期四 ($num)';
  }

  @override
  String fridayWithNum(Object num) {
    return '星期五 ($num)';
  }

  @override
  String saturdayWithNum(Object num) {
    return '星期六 ($num)';
  }

  @override
  String sundayWithNum(Object num) {
    return '星期日 ($num)';
  }

  @override
  String get monday => '周一';

  @override
  String get tuesday => '周二';

  @override
  String get wednesday => '周三';

  @override
  String get thursday => '周四';

  @override
  String get friday => '周五';

  @override
  String get saturday => '周六';

  @override
  String get sunday => '周日';

  @override
  String get copied => '已复制到剪切板。';

  @override
  String get settings => '设置';

  @override
  String get themeMode => '主题模式';

  @override
  String get seedColor => '主题色';

  @override
  String get primaryColor => '主色';

  @override
  String get custom => '自定义';

  @override
  String get ui => '界面';

  @override
  String get selectColor => '选择主题色';

  @override
  String get tabletMode => '平板模式';

  @override
  String get auto => '自动';

  @override
  String get off => '关闭';

  @override
  String get on => '开启';

  @override
  String get about => '关于';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get license => '开源许可';

  @override
  String get cleanCache => '清除缓存';

  @override
  String get language => '多语言';

  @override
  String get zh => '简体中文';

  @override
  String get zhHant => '繁体中文';

  @override
  String get en => 'English';

  @override
  String get ja => '日本語';

  @override
  String get checkUpdate => '检查更新';

  @override
  String get version => '版本';

  @override
  String get share => '分享';

  @override
  String get more => '更多';

  @override
  String get followSystem => '跟随系统';

  @override
  String saveSuccess(Object path) {
    return '保存成功：$path';
  }

  @override
  String get saveFailed => '保存失败';

  @override
  String get search => '搜索';

  @override
  String get searchHint => '请输入搜索内容';

  @override
  String searchResult(Object keywords, Object num) {
    return '搜索关键字「$keywords」，共找到 $num 部番剧';
  }

  @override
  String get copyUrl => '复制链接';

  @override
  String get openUrl => '在浏览器中打开';

  @override
  String get supportMe => '支持一下';

  @override
  String get alipay => '支付宝';

  @override
  String get alipayDesc => '按照提示，点击打开支付宝即可';

  @override
  String get wechat => '微信';

  @override
  String get wechatDesc => '微信扫码或者下载图片在微信内识别';

  @override
  String get bootError => '应用启动失败，请重新启动应用';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get appName => 'BangumiD';

  @override
  String get bangumi => '番組';

  @override
  String get archive => '歸檔';

  @override
  String get newest => '最新';

  @override
  String get collection => '收藏';

  @override
  String collectionNum(Object num) {
    return '當前共收藏 $num 部番劇';
  }

  @override
  String get noDataFound => '什麼都沒有發現';

  @override
  String get officialSite => '官網';

  @override
  String get exitText => '是否退出應用？';

  @override
  String get exitAction => '退出';

  @override
  String seasonSpringWithNum(Object num, Object year) {
    return '$year 年春季番組 ($num)';
  }

  @override
  String seasonSummerWithNum(Object num, Object year) {
    return '$year 年夏季番組 ($num)';
  }

  @override
  String seasonAutumnWithNum(Object num, Object year) {
    return '$year 年秋季番組 ($num)';
  }

  @override
  String seasonWinterWithNum(Object num, Object year) {
    return '$year 年冬季番組 ($num)';
  }

  @override
  String seasonSpring(Object year) {
    return '$year 年春季';
  }

  @override
  String seasonSummer(Object year) {
    return '$year 年夏季';
  }

  @override
  String seasonAutumn(Object year) {
    return '$year 年秋季';
  }

  @override
  String seasonWinter(Object year) {
    return '$year 年冬季';
  }

  @override
  String total(Object num) {
    return '共 $num 部番劇';
  }

  @override
  String get spring => '春';

  @override
  String get summer => '夏';

  @override
  String get autumn => '秋';

  @override
  String get winter => '冬';

  @override
  String mondayWithNum(Object num) {
    return '星期一 ($num)';
  }

  @override
  String tuesdayWithNum(Object num) {
    return '星期二 ($num)';
  }

  @override
  String wednesdayWithNum(Object num) {
    return '星期三 ($num)';
  }

  @override
  String thursdayWithNum(Object num) {
    return '星期四 ($num)';
  }

  @override
  String fridayWithNum(Object num) {
    return '星期五 ($num)';
  }

  @override
  String saturdayWithNum(Object num) {
    return '星期六 ($num)';
  }

  @override
  String sundayWithNum(Object num) {
    return '星期日 ($num)';
  }

  @override
  String get monday => '週一';

  @override
  String get tuesday => '週二';

  @override
  String get wednesday => '週三';

  @override
  String get thursday => '週四';

  @override
  String get friday => '週五';

  @override
  String get saturday => '週六';

  @override
  String get sunday => '週日';

  @override
  String get copied => '已複製到剪切板。';

  @override
  String get settings => '設置';

  @override
  String get themeMode => '主題模式';

  @override
  String get seedColor => '主題色';

  @override
  String get primaryColor => '主色';

  @override
  String get custom => '自定義';

  @override
  String get ui => '界面';

  @override
  String get selectColor => '選擇主題色';

  @override
  String get tabletMode => '平板模式';

  @override
  String get auto => '自動';

  @override
  String get off => '關閉';

  @override
  String get on => '開啟';

  @override
  String get about => '關於';

  @override
  String get privacyPolicy => '隱私政策';

  @override
  String get license => '開源許可';

  @override
  String get cleanCache => '清除緩存';

  @override
  String get language => '多語言';

  @override
  String get zh => '简体中文';

  @override
  String get zhHant => '繁体中文';

  @override
  String get en => 'English';

  @override
  String get ja => '日本語';

  @override
  String get checkUpdate => '檢查更新';

  @override
  String get version => '版本';

  @override
  String get share => '分享';

  @override
  String get more => '更多';

  @override
  String get followSystem => '跟隨系統';

  @override
  String saveSuccess(Object path) {
    return '保存成功：$path';
  }

  @override
  String get saveFailed => '保存失敗';

  @override
  String get search => '搜索';

  @override
  String get searchHint => '請輸入搜索內容';

  @override
  String searchResult(Object keywords, Object num) {
    return '搜索關鍵字「$keywords」，共找到 $num 部番劇';
  }

  @override
  String get copyUrl => '複製鏈接';

  @override
  String get openUrl => '在瀏覽器中打開';

  @override
  String get supportMe => '支持一下';

  @override
  String get alipay => '支付寶';

  @override
  String get alipayDesc => '按照提示，點擊打開支付寶即可';

  @override
  String get wechat => '微信';

  @override
  String get wechatDesc => '微信掃碼或者下載圖片在微信內識別';

  @override
  String get bootError => '應用啟動失敗，請重新啟動應用';
}
