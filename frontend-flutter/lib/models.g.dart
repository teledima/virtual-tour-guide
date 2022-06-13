// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
