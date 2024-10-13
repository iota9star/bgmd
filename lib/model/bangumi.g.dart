// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bangumi.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SiteMetaAdapter extends TypeAdapter<SiteMeta> {
  @override
  final int typeId = 1;

  @override
  SiteMeta read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SiteMeta(
      title: fields[0] as String,
      urlTemplate: fields[1] as String,
      regions: (fields[2] as List?)?.cast<String>(),
      type: fields[3] as SiteType,
    );
  }

  @override
  void write(BinaryWriter writer, SiteMeta obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.urlTemplate)
      ..writeByte(2)
      ..write(obj.regions)
      ..writeByte(3)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SiteMetaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SiteAdapter extends TypeAdapter<Site> {
  @override
  final int typeId = 2;

  @override
  Site read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Site(
      site: fields[0] as String,
      id: fields[1] as String?,
      url: fields[2] as String?,
      begin: fields[3] as String?,
      broadcast: fields[4] as String?,
      end: fields[5] as String?,
      comment: fields[6] as String?,
      regions: (fields[7] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Site obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.site)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.begin)
      ..writeByte(4)
      ..write(obj.broadcast)
      ..writeByte(5)
      ..write(obj.end)
      ..writeByte(6)
      ..write(obj.comment)
      ..writeByte(7)
      ..write(obj.regions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SiteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ItemAdapter extends TypeAdapter<Item> {
  @override
  final int typeId = 3;

  @override
  Item read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Item(
      title: fields[0] as String,
      titleTranslate: (fields[1] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as Language, (v as List).cast<String>())),
      type: fields[2] as ItemType,
      lang: fields[3] as Language,
      officialSite: fields[4] as String?,
      begin: fields[5] as String,
      broadcast: fields[6] as String?,
      end: fields[7] as String?,
      comment: fields[8] as String?,
      sites: (fields[9] as List?)?.cast<Site>(),
    );
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.titleTranslate)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.lang)
      ..writeByte(4)
      ..write(obj.officialSite)
      ..writeByte(5)
      ..write(obj.begin)
      ..writeByte(6)
      ..write(obj.broadcast)
      ..writeByte(7)
      ..write(obj.end)
      ..writeByte(8)
      ..write(obj.comment)
      ..writeByte(9)
      ..write(obj.sites);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BangumiDataAdapter extends TypeAdapter<BangumiData> {
  @override
  final int typeId = 7;

  @override
  BangumiData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BangumiData(
      siteMeta: (fields[0] as Map).cast<String, SiteMeta>(),
      seasons: (fields[1] as List).cast<Season>(),
    );
  }

  @override
  void write(BinaryWriter writer, BangumiData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.siteMeta)
      ..writeByte(1)
      ..write(obj.seasons);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BangumiDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SeasonAdapter extends TypeAdapter<Season> {
  @override
  final int typeId = 8;

  @override
  Season read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Season(
      year: fields[0] as int,
      season: fields[1] as SeasonType,
      week: (fields[2] as List).cast<Week>(),
      num: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Season obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.year)
      ..writeByte(1)
      ..write(obj.season)
      ..writeByte(2)
      ..write(obj.week)
      ..writeByte(3)
      ..write(obj.num);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeasonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WeekAdapter extends TypeAdapter<Week> {
  @override
  final int typeId = 11;

  @override
  Week read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Week(
      weekday: fields[0] as Weekday,
      items: (fields[1] as List).cast<Item>(),
    );
  }

  @override
  void write(BinaryWriter writer, Week obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.weekday)
      ..writeByte(1)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeekAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BangumiAdapter extends TypeAdapter<Bangumi> {
  @override
  final int typeId = 12;

  @override
  Bangumi read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bangumi(
      year: fields[0] as int,
      season: fields[1] as SeasonType,
      week: fields[2] as Weekday,
      item: fields[3] as Item,
      score: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Bangumi obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.year)
      ..writeByte(1)
      ..write(obj.season)
      ..writeByte(2)
      ..write(obj.week)
      ..writeByte(3)
      ..write(obj.item)
      ..writeByte(4)
      ..write(obj.score);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BangumiAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SiteTypeAdapter extends TypeAdapter<SiteType> {
  @override
  final int typeId = 4;

  @override
  SiteType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SiteType.info;
      case 1:
        return SiteType.onair;
      case 2:
        return SiteType.resource;
      default:
        return SiteType.info;
    }
  }

  @override
  void write(BinaryWriter writer, SiteType obj) {
    switch (obj) {
      case SiteType.info:
        writer.writeByte(0);
        break;
      case SiteType.onair:
        writer.writeByte(1);
        break;
      case SiteType.resource:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SiteTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LanguageAdapter extends TypeAdapter<Language> {
  @override
  final int typeId = 5;

  @override
  Language read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Language.ja;
      case 1:
        return Language.en;
      case 2:
        return Language.zhHans;
      case 3:
        return Language.zhHant;
      default:
        return Language.ja;
    }
  }

  @override
  void write(BinaryWriter writer, Language obj) {
    switch (obj) {
      case Language.ja:
        writer.writeByte(0);
        break;
      case Language.en:
        writer.writeByte(1);
        break;
      case Language.zhHans:
        writer.writeByte(2);
        break;
      case Language.zhHant:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ItemTypeAdapter extends TypeAdapter<ItemType> {
  @override
  final int typeId = 6;

  @override
  ItemType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ItemType.tv;
      case 1:
        return ItemType.web;
      case 2:
        return ItemType.movie;
      case 3:
        return ItemType.ova;
      default:
        return ItemType.tv;
    }
  }

  @override
  void write(BinaryWriter writer, ItemType obj) {
    switch (obj) {
      case ItemType.tv:
        writer.writeByte(0);
        break;
      case ItemType.web:
        writer.writeByte(1);
        break;
      case ItemType.movie:
        writer.writeByte(2);
        break;
      case ItemType.ova:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SeasonTypeAdapter extends TypeAdapter<SeasonType> {
  @override
  final int typeId = 9;

  @override
  SeasonType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SeasonType.spring;
      case 1:
        return SeasonType.summer;
      case 2:
        return SeasonType.autumn;
      case 3:
        return SeasonType.winter;
      default:
        return SeasonType.spring;
    }
  }

  @override
  void write(BinaryWriter writer, SeasonType obj) {
    switch (obj) {
      case SeasonType.spring:
        writer.writeByte(0);
        break;
      case SeasonType.summer:
        writer.writeByte(1);
        break;
      case SeasonType.autumn:
        writer.writeByte(2);
        break;
      case SeasonType.winter:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeasonTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WeekdayAdapter extends TypeAdapter<Weekday> {
  @override
  final int typeId = 10;

  @override
  Weekday read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Weekday.monday;
      case 1:
        return Weekday.tuesday;
      case 2:
        return Weekday.wednesday;
      case 3:
        return Weekday.thursday;
      case 4:
        return Weekday.friday;
      case 5:
        return Weekday.saturday;
      case 6:
        return Weekday.sunday;
      default:
        return Weekday.monday;
    }
  }

  @override
  void write(BinaryWriter writer, Weekday obj) {
    switch (obj) {
      case Weekday.monday:
        writer.writeByte(0);
        break;
      case Weekday.tuesday:
        writer.writeByte(1);
        break;
      case Weekday.wednesday:
        writer.writeByte(2);
        break;
      case Weekday.thursday:
        writer.writeByte(3);
        break;
      case Weekday.friday:
        writer.writeByte(4);
        break;
      case Weekday.saturday:
        writer.writeByte(5);
        break;
      case Weekday.sunday:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeekdayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SiteMeta _$SiteMetaFromJson(Map json) => SiteMeta(
      title: json['title'] as String,
      urlTemplate: json['urlTemplate'] as String,
      regions:
          (json['regions'] as List<dynamic>?)?.map((e) => e as String).toList(),
      type: $enumDecode(_$SiteTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$SiteMetaToJson(SiteMeta instance) => <String, dynamic>{
      'title': instance.title,
      'urlTemplate': instance.urlTemplate,
      'regions': instance.regions,
      'type': _$SiteTypeEnumMap[instance.type]!,
    };

const _$SiteTypeEnumMap = {
  SiteType.info: 'info',
  SiteType.onair: 'onair',
  SiteType.resource: 'resource',
};

Site _$SiteFromJson(Map json) => Site(
      site: json['site'] as String,
      id: json['id'] as String?,
      url: json['url'] as String?,
      begin: json['begin'] as String?,
      broadcast: json['broadcast'] as String?,
      end: json['end'] as String?,
      comment: json['comment'] as String?,
      regions:
          (json['regions'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SiteToJson(Site instance) => <String, dynamic>{
      'site': instance.site,
      'id': instance.id,
      'url': instance.url,
      'begin': instance.begin,
      'broadcast': instance.broadcast,
      'end': instance.end,
      'comment': instance.comment,
      'regions': instance.regions,
    };

Item _$ItemFromJson(Map json) => Item(
      title: json['title'] as String,
      titleTranslate: const TitleTranslateConverter()
          .fromJson(json['titleTranslate'] as Map<String, dynamic>),
      type: $enumDecode(_$ItemTypeEnumMap, json['type']),
      lang: const LanguageConverter().fromJson(json['lang'] as String),
      officialSite: json['officialSite'] as String?,
      begin: json['begin'] as String,
      broadcast: json['broadcast'] as String?,
      end: json['end'] as String?,
      comment: json['comment'] as String?,
      sites: (json['sites'] as List<dynamic>?)
          ?.map((e) => Site.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'title': instance.title,
      'titleTranslate':
          const TitleTranslateConverter().toJson(instance.titleTranslate),
      'type': _$ItemTypeEnumMap[instance.type]!,
      'lang': const LanguageConverter().toJson(instance.lang),
      'officialSite': instance.officialSite,
      'begin': instance.begin,
      'broadcast': instance.broadcast,
      'end': instance.end,
      'comment': instance.comment,
      'sites': instance.sites?.map((e) => e.toJson()).toList(),
    };

const _$ItemTypeEnumMap = {
  ItemType.tv: 'tv',
  ItemType.web: 'web',
  ItemType.movie: 'movie',
  ItemType.ova: 'ova',
};

BangumiData _$BangumiDataFromJson(Map json) => BangumiData(
      siteMeta: (json['siteMeta'] as Map).map(
        (k, e) => MapEntry(k as String,
            SiteMeta.fromJson(Map<String, dynamic>.from(e as Map))),
      ),
      seasons: (json['seasons'] as List<dynamic>)
          .map((e) => Season.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$BangumiDataToJson(BangumiData instance) =>
    <String, dynamic>{
      'siteMeta': instance.siteMeta.map((k, e) => MapEntry(k, e.toJson())),
      'seasons': instance.seasons.map((e) => e.toJson()).toList(),
    };

Season _$SeasonFromJson(Map json) => Season(
      year: (json['year'] as num).toInt(),
      season: $enumDecode(_$SeasonTypeEnumMap, json['season']),
      week: (json['week'] as List<dynamic>)
          .map((e) => Week.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      num: (json['num'] as num).toInt(),
    );

Map<String, dynamic> _$SeasonToJson(Season instance) => <String, dynamic>{
      'year': instance.year,
      'season': _$SeasonTypeEnumMap[instance.season]!,
      'week': instance.week.map((e) => e.toJson()).toList(),
      'num': instance.num,
    };

const _$SeasonTypeEnumMap = {
  SeasonType.spring: 'spring',
  SeasonType.summer: 'summer',
  SeasonType.autumn: 'autumn',
  SeasonType.winter: 'winter',
};

Week _$WeekFromJson(Map json) => Week(
      weekday: $enumDecode(_$WeekdayEnumMap, json['weekday']),
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$WeekToJson(Week instance) => <String, dynamic>{
      'weekday': _$WeekdayEnumMap[instance.weekday]!,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

const _$WeekdayEnumMap = {
  Weekday.monday: 'monday',
  Weekday.tuesday: 'tuesday',
  Weekday.wednesday: 'wednesday',
  Weekday.thursday: 'thursday',
  Weekday.friday: 'friday',
  Weekday.saturday: 'saturday',
  Weekday.sunday: 'sunday',
};

Bangumi _$BangumiFromJson(Map json) => Bangumi(
      year: (json['year'] as num).toInt(),
      season: $enumDecode(_$SeasonTypeEnumMap, json['season']),
      week: $enumDecode(_$WeekdayEnumMap, json['week']),
      item: Item.fromJson(Map<String, dynamic>.from(json['item'] as Map)),
      score: (json['score'] as num).toInt(),
    );

Map<String, dynamic> _$BangumiToJson(Bangumi instance) => <String, dynamic>{
      'year': instance.year,
      'season': _$SeasonTypeEnumMap[instance.season]!,
      'week': _$WeekdayEnumMap[instance.week]!,
      'item': instance.item.toJson(),
      'score': instance.score,
    };
