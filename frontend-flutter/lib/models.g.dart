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

DefaultDetail _$DefaultDetailFromJson(Map<String, dynamic> json) =>
    DefaultDetail(
      json['firstScene'] as String,
    );

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
