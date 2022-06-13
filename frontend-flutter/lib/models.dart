import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

part 'models.g.dart';

enum HotspotTypes {
  scene,
  info,
  unknown
}

class TourDetail {
  final String tourId;
  final String title;
  final List<SceneDetail>? scenes;
  DefaultDetail? defaultDetail;

  TourDetail(this.tourId, this.title, this.scenes, this.defaultDetail);

  SceneDetail get defaultScene {
    return findSceneById(defaultDetail!.firstScene)!;
  }

  factory TourDetail.fromJson(Map<String, dynamic> json) {
    return TourDetail(
      json['_id'],
      json['title'],
      json['scenes']?.map((scene) => SceneDetail.fromJson(scene)).toList().cast<SceneDetail>(), 
      json.containsKey('default') ? DefaultDetail.fromJson(json['default']) : null
    );
  }

  SceneDetail? findSceneById(String sceneId) {
    if (scenes!.any((scene) => scene.sceneId == sceneId)) {
      return scenes!.firstWhere((scene) => scene.sceneId == sceneId);
    } else {
      return null;
    }
  }
}

class DefaultDetail {
  final String firstScene;

  DefaultDetail(this.firstScene);

  factory DefaultDetail.fromJson(Map<String, dynamic> json) {
    return DefaultDetail(json['firstScene']);
  }
}

class SceneDetail {
  final String sceneId;
  final String? title;
  final String panorama;
  final String? thumbnail;
  final List<HotspotDetail> hotspots;

  SceneDetail(this.sceneId, this.title, this.panorama, this.thumbnail, this.hotspots);

  factory SceneDetail.fromJson(Map<String, dynamic> json) {
    return SceneDetail(
      json['sceneId'], 
      json.containsKey('title') ? json['title'] : null, 
      json['panorama'], 
      json.containsKey('thumbnail') ? json['thumbnail'] : null,
      json['hotSpots'].map(
        (hotspot) {
          final String type = hotspot['type'].toString();
          if (type == 'navigation') {
            return HotspotNavigationDetail.fromJson(hotspot);  
          } else if (type == 'info') {
            return HotspotInfoDetail.fromJson(hotspot);
          }
        }
      ).toList().cast<HotspotDetail>()
    );
  }

  deleteHotspot(HotspotDetail hotspotDetail) {
    hotspots.removeWhere((hotspot) => hotspot.latitude == hotspotDetail.latitude && hotspot.longtitude == hotspot.longtitude);
  }

  updateHotspotPosition(HotspotDetail hotspot, double newLatitude, double newLongtitude) {
    final matchedHotspot = hotspots.firstWhere((hotspotItem) => hotspotItem == hotspot);
    matchedHotspot.latitude = newLatitude;
    matchedHotspot.longtitude = newLongtitude;
  }
}

abstract class HotspotDetail {
  final String type;
  double latitude;
  double longtitude;

  @JsonKey(name: 'color')
  int? colorCode;

  Color get color {
    if (colorCode != null) {
      return Color(colorCode!);
    } else {
      return Colors.black;
    }
  }

  HotspotDetail({
    required this.type, 
    required this.latitude, 
    required this.longtitude, 
    this.colorCode
  });

  @override
  bool operator ==(Object other) {
    return other is HotspotDetail && latitude == other.latitude && longtitude == other.longtitude;
  }

  Map<String, dynamic> toJson();
}


@JsonSerializable()
class HotspotNavigationDetail extends HotspotDetail {
  final String sceneId;

  HotspotNavigationDetail({
    required double latitude, 
    required double longtitude, 
    required this.sceneId, 
    int? colorCode, 
    String type = 'navigation'
  }): super(
        type: type, 
        latitude: latitude, 
        longtitude: longtitude, 
        colorCode: colorCode
      );

  factory HotspotNavigationDetail.fromJson(Map<String, dynamic> json) => _$HotspotNavigationDetailFromJson(json);
  
  @override
  Map<String, dynamic> toJson() => _$HotspotNavigationDetailToJson(this);
}

@JsonSerializable()
class HotspotInfoDetail extends HotspotDetail {
  final String description;

  HotspotInfoDetail({
    required double latitude, 
    required double longtitude, 
    required this.description, 
    int? colorCode,
    String type = 'info'
  }): super(
        type: type, 
        latitude: latitude, 
        longtitude: longtitude, 
        colorCode: colorCode
      );

  factory HotspotInfoDetail.fromJson(Map<String, dynamic> json) => _$HotspotInfoDetailFromJson(json);
  
  @override
  Map<String, dynamic> toJson() => _$HotspotInfoDetailToJson(this);
}

class UpdateResult {
  final bool acknowledged;
  final int matchedCount;
  final int modifiedCount;
  final int upsertedCount;
  final String? upsertedId;

  UpdateResult(this.acknowledged, this.matchedCount, this.modifiedCount, this.upsertedCount, this.upsertedId);

  factory UpdateResult.fromJson(Map<String, dynamic> json) {
    return UpdateResult(
      json['acknowledged'], 
      json['matchedCount'], 
      json['modifiedCount'], 
      json['upsertedCount'], 
      json.containsKey('upsertedId') ? json['upsertedId'] : null
    );
  }
}
