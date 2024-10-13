import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appName => 'BangumiD';

  @override
  String get bangumi => '番組';

  @override
  String get archive => 'アーカイブ';

  @override
  String get newest => '最新';

  @override
  String get collection => 'コレクション';

  @override
  String collectionNum(Object num) {
    return '現在 $num 本のアニメをコレクションしています';
  }

  @override
  String get noDataFound => '何も見つかりませんでした';

  @override
  String get officialSite => '公式サイト';

  @override
  String get exitText => 'アプリを終了しますか？';

  @override
  String get exitAction => '終了';

  @override
  String seasonSpringWithNum(Object num, Object year) {
    return '$year 年春アニメ ($num)';
  }

  @override
  String seasonSummerWithNum(Object num, Object year) {
    return '$year 年夏アニメ ($num)';
  }

  @override
  String seasonAutumnWithNum(Object num, Object year) {
    return '$year 年秋アニメ ($num)';
  }

  @override
  String seasonWinterWithNum(Object num, Object year) {
    return '$year 年冬アニメ ($num)';
  }

  @override
  String seasonSpring(Object year) {
    return '$year 年春';
  }

  @override
  String seasonSummer(Object year) {
    return '$year 年夏';
  }

  @override
  String seasonAutumn(Object year) {
    return '$year 年秋';
  }

  @override
  String seasonWinter(Object year) {
    return '$year 年冬';
  }

  @override
  String total(Object num) {
    return '合計 $num 本のアニメ';
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
    return '月曜日 ($num)';
  }

  @override
  String tuesdayWithNum(Object num) {
    return '火曜日 ($num)';
  }

  @override
  String wednesdayWithNum(Object num) {
    return '水曜日 ($num)';
  }

  @override
  String thursdayWithNum(Object num) {
    return '木曜日 ($num)';
  }

  @override
  String fridayWithNum(Object num) {
    return '金曜日 ($num)';
  }

  @override
  String saturdayWithNum(Object num) {
    return '土曜日 ($num)';
  }

  @override
  String sundayWithNum(Object num) {
    return '日曜日 ($num)';
  }

  @override
  String get monday => '月曜日';

  @override
  String get tuesday => '火曜日';

  @override
  String get wednesday => '水曜日';

  @override
  String get thursday => '木曜日';

  @override
  String get friday => '金曜日';

  @override
  String get saturday => '土曜日';

  @override
  String get sunday => '日曜日';

  @override
  String get copied => 'クリップボードにコピーしました。';

  @override
  String get settings => '設定';

  @override
  String get themeMode => 'テーマモード';

  @override
  String get seedColor => 'テーマカラー';

  @override
  String get primaryColor => 'メインカラー';

  @override
  String get custom => 'カスタム';

  @override
  String get ui => 'UI';

  @override
  String get selectColor => 'テーマカラーを選択';

  @override
  String get tabletMode => 'タブレットモード';

  @override
  String get auto => '自動';

  @override
  String get off => 'オフ';

  @override
  String get on => 'オン';

  @override
  String get about => 'アバウト';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get license => 'オープンソースライセンス';

  @override
  String get cleanCache => 'キャッシュをクリア';

  @override
  String get language => '言語';

  @override
  String get zh => '简体中文';

  @override
  String get zhHant => '繁体中文';

  @override
  String get en => 'English';

  @override
  String get ja => '日本語';

  @override
  String get checkUpdate => '更新を確認';

  @override
  String get version => 'バージョン';

  @override
  String get share => '共有';

  @override
  String get more => 'もっと';

  @override
  String get followSystem => 'システムに従う';

  @override
  String saveSuccess(Object path) {
    return '保存成功：$path';
  }

  @override
  String get saveFailed => '保存失敗';

  @override
  String get search => '検索';

  @override
  String get searchHint => '検索内容を入力してください';

  @override
  String searchResult(Object keywords, Object num) {
    return '検索キーワード「$keywords」、$num 本のアニメが見つかりました';
  }

  @override
  String get copyUrl => 'URLをコピー';

  @override
  String get openUrl => 'ブラウザで開く';

  @override
  String get supportMe => 'サポート';

  @override
  String get alipay => 'アリペイ';

  @override
  String get alipayDesc => '指示に従って、アリペイを開いてください';

  @override
  String get wechat => 'WeChat';

  @override
  String get wechatDesc => 'WeChatでスキャンするか、画像をダウンロードしてWeChatで認識してください';

  @override
  String get bootError => 'アプリの起動に失敗しました。アプリを再起動してください';
}
