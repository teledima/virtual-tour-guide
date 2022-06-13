// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TourDetail _$TourDetailFromJson(Map<String, dynamic> json) => TourDetail(
      json['_id'] as String,
      json['title'] as String,
      (json['scenes'] as List<dynamic>?)
          ?.map((e) => SceneDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['default'] == null
          ? null
          : DefaultDetail.fromJson(json['default'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TourDetailToJson(TourDetail instance) {
  final val = <String, dynamic>{
    '_id': instance.tourId,
    'title': instance.title,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('scenes', instance.scenes);
  writeNotNull('default', instance.defaultDetail);
  return val;
}

DefaultDetail _$DefaultDetailFromJson(Map<String, dynamic> json) =>
    DefaultDetail(
      json['firstScene'] as String,
    );

Map<String, dynamic> _$DefaultDetailToJson(DefaultDetail instance) =>
    <String, dynamic>{
      'firstScene': instance.firstScene,
    };

Map<String, dynamic> _$SceneDetailToJson(SceneDetail instance) =>
    <String, dynamic>{
      'sceneId': instance.sceneId,
      'title': instance.title,
      'panorama': instance.panorama,
      'thumbnail': instance.thumbnail,
      'hotspots': instance.hotspots,
    };

HotspotNavigationDetail _$HotspotNavigationDetailFromJson(
        Map<String, dynamic> json) =>
    HotspotNavigationDetail(
      latitude: (json['latitude'] as num).toDouble(),
      longtitude: (json['longtitude'] as num).toDouble(),
      sceneId: json['sceneId'] as String,
      colorCode: json['color'] as int?,
      type: json['type'] as String? ?? 'navigation',
    );

Map<String, dynamic> _$HotspotNavigationDetailToJson(
        HotspotNavigationDetail instance) =>
    <String, dynamic>{
      'type': instance.type,
      'latitude': instance.latitude,
      'longtitude': instance.longtitude,
      'color': instance.colorCode,
      'sceneId': instance.sceneId,
    };

HotspotInfoDetail _$HotspotInfoDetailFromJson(Map<String, dynamic> json) =>
    HotspotInfoDetail(
      latitude: (json['latitude'] as num).toDouble(),
      longtitude: (json['longtitude'] as num).toDouble(),
      description: json['description'] as String,
      colorCode: json['color'] as int?,
      type: json['type'] as String? ?? 'info',
    );

Map<String, dynamic> _$HotspotInfoDetailToJson(HotspotInfoDetail instance) =>
    <String, dynamic>{
      'type': instance.type,
      'latitude': instance.latitude,
      'longtitude': instance.longtitude,
      'color': instance.colorCode,
      'description': instance.description,
    };

UpdateResult _$UpdateResultFromJson(Map<String, dynamic> json) => UpdateResult(
      json['acknowledged'] as bool,
      json['matchedCount'] as int,
      json['modifiedCount'] as int,
      json['upsertedCount'] as int,
      json['upsertedId'] as String?,
    );

InsertOneResult _$InsertOneResultFromJson(Map<String, dynamic> json) =>
    InsertOneResult(
      json['acknowledged'] as bool,
      json['insertedId'] as String,
    );
