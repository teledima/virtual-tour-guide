// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotspotNavigationDetail _$HotspotNavigationDetailFromJson(
        Map<String, dynamic> json) =>
    HotspotNavigationDetail(
      (json['latitude'] as num).toDouble(),
      (json['longtitude'] as num).toDouble(),
      json['sceneId'] as String,
    );

Map<String, dynamic> _$HotspotNavigationDetailToJson(
        HotspotNavigationDetail instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longtitude': instance.longtitude,
      'sceneId': instance.sceneId,
    };

HotspotInfoDetail _$HotspotInfoDetailFromJson(Map<String, dynamic> json) =>
    HotspotInfoDetail(
      (json['latitude'] as num).toDouble(),
      (json['longtitude'] as num).toDouble(),
      json['description'] as String,
    );

Map<String, dynamic> _$HotspotInfoDetailToJson(HotspotInfoDetail instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longtitude': instance.longtitude,
      'description': instance.description,
    };
