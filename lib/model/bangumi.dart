import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../bgmd.dart';

part 'bangumi.g.dart';

/// 站点元数据
@HiveType(typeId: HiveTypeIds.SiteMeta)
@JsonSerializable()
class SiteMeta {
  SiteMeta({
    required this.title,
    required this.urlTemplate,
    this.regions,
    required this.type,
  });

  factory SiteMeta.fromJson(Map<String, dynamic> json) => _$SiteMetaFromJson(json);

  /// 站点名称
  @HiveField(0)
  final String title;

  /// 站点 URL 模板
  @HiveField(1)
  final String urlTemplate;

  /// 站点区域限制，主要针对 onAir 类型的放送站点。如无该字段，表明该站点无区域限制
  @HiveField(2)
  final List<String>? regions;

  /// 站点类型: info, onair, resource
  @HiveField(3)
  final SiteType type;

  Map<String, dynamic> toJson() => _$SiteMetaToJson(this);
}

/// 放送站点
@HiveType(typeId: HiveTypeIds.Site)
@JsonSerializable()
class Site {
  Site({
    required this.site,
    this.id,
    this.url,
    this.begin,
    this.broadcast,
    this.end,
    this.comment,
    this.regions,
  });

  factory Site.fromJson(Map<String, dynamic> json) => _$SiteFromJson(json);

  /// 站点 name，请和最外层 sites 字段中的元数据对应
  @HiveField(0)
  final String site;

  /// 站点 id，可用于替换模板中相应的字段
  @HiveField(1)
  final String? id;

  /// URL，如果当前 URL 不符合 urlTemplate 中的规则时使用，优先级高于 id
  @HiveField(2)
  final String? url;

  /// 放送开始时间
  @HiveField(3)
  final String? begin;

  /// 放送周期
  @HiveField(4)
  final String? broadcast;

  /// tv/web: 番组完结时间; movie: 无意义; ova: 则为最终话发售时间（未确定则置空）
  @HiveField(5)
  final String? end;

  /// 备注
  @HiveField(6)
  final String? comment;

  /// 番剧放送站点区域限制，用于覆盖站点本身的区域限制
  @HiveField(7)
  final List<String>? regions;

  Map<String, dynamic> toJson() => _$SiteToJson(this);

  Widget toSiteWidget(BuildContext context, Map<String, SiteMeta> siteMeta) {
    final v = siteMeta[site];
    if (v == null) {
      return ScalableCard(
        child: Row(
          children: [
            Text(site),
          ],
        ),
      );
    }

    final logo = switch (site) {
      'bangumi' => DecoratedBox(
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(999.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Assets.bangumi.image(height: 16.0, fit: BoxFit.contain),
          ),
        ),
      'acfun' => Assets.acfun.image(width: 20.0, height: 20.0, fit: BoxFit.contain),
      'youku' => Assets.youku.svg(width: 20.0, height: 20.0, fit: BoxFit.contain),
      'qq' => Assets.qq.svg(width: 20.0, height: 20.0, fit: BoxFit.contain),
      'iqiyi' => Assets.iqiyi.image(width: 20.0, height: 20.0, fit: BoxFit.contain),
      'letv' => Assets.letv.image(width: 20.0, height: 20.0, fit: BoxFit.contain),
      'mgtv' => Assets.mgtv.image(width: 20.0, height: 20.0, fit: BoxFit.contain),
      'nicovideo' => Assets.nicovideo.image(width: 20.0, height: 20.0, fit: BoxFit.contain),
      'netflix' => DecoratedBox(
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(999.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Assets.netflix.image(height: 16.0, fit: BoxFit.contain),
          ),
        ),
      'viu' => Assets.viu.image(width: 20.0, height: 20.0, fit: BoxFit.contain),
      'mytv' => Assets.mytv.image(width: 20.0, height: 20.0, fit: BoxFit.contain),
      'disneyplus' => Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: Assets.disneyplus.image(width: 20.0, height: 20.0, fit: BoxFit.contain),
        ),
      'abema' => Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: Assets.abema.image(width: 20.0, height: 20.0, fit: BoxFit.contain),
        ),
      'unext' => DecoratedBox(
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(999.0)),
          ),
          child: Assets.unext.svg(width: 20.0, height: 20.0, fit: BoxFit.contain),
        ),
      'dmhy' => Material(
          clipBehavior: Clip.antiAlias,
          shape: const CircleBorder(),
          child: Assets.dmhy.image(width: 20.0, height: 20.0, fit: BoxFit.contain),
        ),
      'mikan' => DecoratedBox(
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(999.0)),
          ),
          child: Assets.mikan.image(width: 20.0, height: 20.0, fit: BoxFit.contain),
        ),
      'gamer' || 'gamer_hk' => Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: Assets.gamer.svg(width: 20.0, height: 20.0, fit: BoxFit.contain),
        ),
      'muse_hk' || 'ani_one' || 'ani_one_asia' => Padding(
          padding: const EdgeInsets.all(3.0),
          child: Assets.youtube.svg(height: 14.0),
        ),
      'bilibili' || 'bilibili_hk_mo_tw' || 'bilibili_hk_mo' || 'bilibili_tw' => Padding(
          padding: const EdgeInsets.all(2.0),
          child: Assets.bilibili.image(height: 16.0, fit: BoxFit.contain),
        ),
      _ => SizedBox(
          width: 20.0,
          height: 20.0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: const BorderRadius.all(Radius.circular(999.0)),
            ),
            child: Center(
              child: Text(
                site.characters.first.toUpperCase(),
                style: const TextStyle(height: 1.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
    };
    return RippleTap(
      onTap: () {
        final url = this.url ?? v.urlTemplate.replaceAll('{{id}}', id ?? '');
        launchUrlString(url);
      },
      color: context.colors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(999.0))),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 2.0,
          end: 8.0,
          top: 2.0,
          bottom: 2.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            logo,
            const Gap(2.0),
            Text(
              v.title,
              style: context.textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// 番组数据
@HiveType(typeId: HiveTypeIds.Item)
@JsonSerializable()
class Item {
  Item({
    required this.title,
    required this.titleTranslate,
    required this.type,
    required this.lang,
    this.officialSite,
    required this.begin,
    this.broadcast,
    this.end,
    this.comment,
    this.sites,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  /// 番组原始标题
  @HiveField(0)
  final String title;

  /// 番组标题翻译
  @TitleTranslateConverter()
  @HiveField(1)
  final Map<Language, List<String>> titleTranslate;

  /// 番组类型
  @HiveField(2)
  final ItemType type;

  /// 番组语言
  @LanguageConverter()
  @HiveField(3)
  final Language lang;

  /// 官网
  @HiveField(4)
  final String? officialSite;

  /// tv/web: 番组开始时间; movie: 上映日期; ova: 首话发售时间
  @HiveField(5)
  final String begin;

  /// 放送周期
  @HiveField(6)
  final String? broadcast;

  /// tv/web: 番组完结时间; movie: 无意义; ova: 则为最终话发售时间（未确定则置空）
  @HiveField(7)
  final String? end;

  /// 备注
  @HiveField(8)
  final String? comment;

  /// 站点
  @HiveField(9)
  final List<Site>? sites;

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  String? _cover;

  String get cover {
    if (_cover == null) {
      final site = sites?.firstWhereOrNull((e) => e.site == 'bangumi');
      if (site != null) {
        _cover = 'https://api.bgm.tv/v0/subjects/${site.id}/image?type=large';
      } else {
        _cover = '';
      }
    }
    return _cover!;
  }

  String cardTitle(Locale locale) {
    if (locale.languageCode == 'zh') {
      if (locale.scriptCode == 'Hant') {
        return titleTranslate[Language.zhHant]?.firstOrNull ?? titleTranslate[Language.zhHans]?.firstOrNull ?? title;
      }
      return titleTranslate[Language.zhHans]?.firstOrNull ?? titleTranslate[Language.zhHant]?.firstOrNull ?? title;
    } else if (locale.languageCode == 'en') {
      return titleTranslate[Language.en]?.firstOrNull ?? title;
    } else if (locale.languageCode == 'ja') {
      return titleTranslate[Language.ja]?.firstOrNull ?? title;
    }
    return title;
  }

  Bangumi toBangumi() {
    final v = DateTime.parse(begin);
    return Bangumi(
      year: v.year,
      season: SeasonType.fromMonth(v.month),
      week: Weekday.fromInt(v.weekday),
      item: this,
      score: DateTime.now().millisecondsSinceEpoch,
    );
  }
}

/// 站点类型
@HiveType(typeId: HiveTypeIds.SiteType)
enum SiteType {
  @HiveField(0)
  info,
  @HiveField(1)
  onair,
  @HiveField(2)
  resource,
}

/// 语言类型
@HiveType(typeId: HiveTypeIds.Language)
enum Language {
  @HiveField(0)
  ja,
  @HiveField(1)
  en,
  @HiveField(2)
  zhHans,
  @HiveField(3)
  zhHant,
}

/// 番组类型
@HiveType(typeId: HiveTypeIds.ItemType)
enum ItemType {
  @HiveField(0)
  tv,
  @HiveField(1)
  web,
  @HiveField(2)
  movie,
  @HiveField(3)
  ova,
}

@JsonSerializable()
@HiveType(typeId: HiveTypeIds.BangumiData)
class BangumiData {
  BangumiData({
    required this.siteMeta,
    required this.seasons,
  });

  factory BangumiData.fromJson(Map<String, dynamic> json) => _$BangumiDataFromJson(json);

  @HiveField(0)
  final Map<String, SiteMeta> siteMeta;
  @HiveField(1)
  final List<Season> seasons;

  Map<String, dynamic> toJson() => _$BangumiDataToJson(this);
}

@HiveType(typeId: HiveTypeIds.SeasonType)
enum SeasonType {
  @HiveField(0)
  spring,
  @HiveField(1)
  summer,
  @HiveField(2)
  autumn,
  @HiveField(3)
  winter,
  ;

  factory SeasonType.fromMonth(int month) {
    switch (month) {
      case 1:
      case 2:
      case 3:
        return SeasonType.winter;
      case 4:
      case 5:
      case 6:
        return SeasonType.spring;
      case 7:
      case 8:
      case 9:
        return SeasonType.summer;
      case 10:
      case 11:
      case 12:
        return SeasonType.autumn;
      default:
        throw ArgumentError.value(month);
    }
  }

  String labelWithNum(BuildContext context, int year, int num) {
    switch (this) {
      case SeasonType.spring:
        return context.l10n.seasonSpringWithNum(num, year);
      case SeasonType.summer:
        return context.l10n.seasonSummerWithNum(num, year);
      case SeasonType.autumn:
        return context.l10n.seasonAutumnWithNum(num, year);
      case SeasonType.winter:
        return context.l10n.seasonWinterWithNum(num, year);
    }
  }

  String labelShort(BuildContext context) {
    switch (this) {
      case SeasonType.spring:
        return context.l10n.spring;
      case SeasonType.summer:
        return context.l10n.summer;
      case SeasonType.autumn:
        return context.l10n.autumn;
      case SeasonType.winter:
        return context.l10n.winter;
    }
  }

  String label(BuildContext context, int year) {
    switch (this) {
      case SeasonType.spring:
        return context.l10n.seasonSpring(year);
      case SeasonType.summer:
        return context.l10n.seasonSummer(year);
      case SeasonType.autumn:
        return context.l10n.seasonAutumn(year);
      case SeasonType.winter:
        return context.l10n.seasonWinter(year);
    }
  }
}

@HiveType(typeId: HiveTypeIds.Season)
@JsonSerializable()
class Season {
  Season({
    required this.year,
    required this.season,
    required this.week,
    required this.num,
  });

  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);
  @HiveField(0)
  final int year;
  @HiveField(1)
  final SeasonType season;
  @HiveField(2)
  final List<Week> week;
  @HiveField(3)
  int num;

  Map<String, dynamic> toJson() => _$SeasonToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Season && runtimeType == other.runtimeType && year == other.year && season == other.season;

  @override
  int get hashCode => year.hashCode ^ season.hashCode;
}

@HiveType(typeId: HiveTypeIds.Week)
@JsonSerializable()
class Week {
  Week({required this.weekday, required this.items});

  factory Week.fromJson(Map<String, dynamic> json) => _$WeekFromJson(json);
  @HiveField(0)
  final Weekday weekday;
  @HiveField(1)
  final List<Item> items;

  Map<String, dynamic> toJson() => _$WeekToJson(this);
}

@HiveType(typeId: HiveTypeIds.Weekday)
enum Weekday {
  @HiveField(0)
  monday,
  @HiveField(1)
  tuesday,
  @HiveField(2)
  wednesday,
  @HiveField(3)
  thursday,
  @HiveField(4)
  friday,
  @HiveField(5)
  saturday,
  @HiveField(6)
  sunday,
  ;

  factory Weekday.fromInt(int value) {
    switch (value) {
      case 1:
        return Weekday.monday;
      case 2:
        return Weekday.tuesday;
      case 3:
        return Weekday.wednesday;
      case 4:
        return Weekday.thursday;
      case 5:
        return Weekday.friday;
      case 6:
        return Weekday.saturday;
      case 7:
        return Weekday.sunday;
      default:
        throw ArgumentError.value(value);
    }
  }

  String label(BuildContext context, int num) {
    switch (this) {
      case Weekday.monday:
        return context.l10n.mondayWithNum(num);
      case Weekday.tuesday:
        return context.l10n.tuesdayWithNum(num);
      case Weekday.wednesday:
        return context.l10n.wednesdayWithNum(num);
      case Weekday.thursday:
        return context.l10n.thursdayWithNum(num);
      case Weekday.friday:
        return context.l10n.fridayWithNum(num);
      case Weekday.saturday:
        return context.l10n.saturdayWithNum(num);
      case Weekday.sunday:
        return context.l10n.sundayWithNum(num);
    }
  }

  String labelShort(BuildContext context) {
    switch (this) {
      case Weekday.monday:
        return context.l10n.monday;
      case Weekday.tuesday:
        return context.l10n.tuesday;
      case Weekday.wednesday:
        return context.l10n.wednesday;
      case Weekday.thursday:
        return context.l10n.thursday;
      case Weekday.friday:
        return context.l10n.friday;
      case Weekday.saturday:
        return context.l10n.saturday;
      case Weekday.sunday:
        return context.l10n.sunday;
    }
  }
}

class LanguageConverter implements JsonConverter<Language, String> {
  const LanguageConverter();

  @override
  Language fromJson(String json) {
    switch (json) {
      case 'ja':
        return Language.ja;
      case 'en':
        return Language.en;
      case 'zh-Hans':
        return Language.zhHans;
      case 'zh-Hant':
        return Language.zhHant;
      default:
        throw ArgumentError.value(json);
    }
  }

  @override
  String toJson(Language object) {
    switch (object) {
      case Language.ja:
        return 'ja';
      case Language.en:
        return 'en';
      case Language.zhHans:
        return 'zh-Hans';
      case Language.zhHant:
        return 'zh-Hant';
    }
  }
}

class TitleTranslateConverter implements JsonConverter<Map<Language, List<String>>, Map<String, dynamic>> {
  const TitleTranslateConverter();

  @override
  Map<Language, List<String>> fromJson(Map<String, dynamic> json) {
    return json.map((key, value) => MapEntry(const LanguageConverter().fromJson(key), (value as List).cast()));
  }

  @override
  Map<String, List<String>> toJson(Map<Language, List<String>> object) {
    return object.map((key, value) => MapEntry(const LanguageConverter().toJson(key), value));
  }
}

@HiveType(typeId: HiveTypeIds.Bangumi)
@JsonSerializable()
class Bangumi {
  Bangumi({
    required this.year,
    required this.season,
    required this.week,
    required this.item,
    required this.score,
  });

  factory Bangumi.fromJson(Map<String, dynamic> json) => _$BangumiFromJson(json);

  @HiveField(0)
  final int year;
  @HiveField(1)
  final SeasonType season;
  @HiveField(2)
  final Weekday week;
  @HiveField(3)
  final Item item;
  @HiveField(4)
  final int score;

  Map<String, dynamic> toJson() => _$BangumiToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Bangumi && runtimeType == other.runtimeType && week == other.week && item.title == other.item.title;

  @override
  int get hashCode => week.hashCode ^ item.title.hashCode;
}
