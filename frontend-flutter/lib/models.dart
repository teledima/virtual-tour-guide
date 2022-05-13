enum HotspotTypes {
  scene,
  info,
  unknown
}

class TourDetail {
  final String tourId;
  final TourMetadata metadata;
  final List<SceneDetail>? scenes;
  final DefaultDetail? defaultDetail;

  TourDetail(this.tourId, this.metadata, this.scenes, this.defaultDetail);

  SceneDetail get defaultScene {
    return findSceneById(defaultDetail!.firstScene)!;
  }

  factory TourDetail.fromJson(Map<String, dynamic> json) {
    return TourDetail(
      json['tourId'],
      TourMetadata.fromJson(json['metadata']),
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

class TourMetadata { 
  final String title;
  final String? thumbnail;

  TourMetadata(this.title, this.thumbnail);

  factory TourMetadata.fromJson(Map<String, dynamic> json) {
    return TourMetadata(json['title'], json.containsKey('thumbnail') ? json['thumbnail'] : null);
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
  final List<HotspotDetail> hotspots;

  SceneDetail(this.sceneId, this.title, this.panorama, this.hotspots);

  factory SceneDetail.fromJson(Map<String, dynamic> json) {
    return SceneDetail(
      json['sceneId'], 
      json.containsKey('title') ? json['title'] : null, 
      json['panorama'], 
      json['hotSpots'].map((hotspot) => HotspotDetail.fromJson(hotspot)).toList().cast<HotspotDetail>()
    );
  }

  deleteHotspot(HotspotDetail hotspotDetail) {
    hotspots.removeWhere((hotspot) => hotspot.sceneId == hotspotDetail.sceneId);
  }

  updateHotspotPosition(HotspotDetail hotspot, double newLatitude, double newLongtitude) {
    final matchedHotspot = hotspots.firstWhere((hotspotItem) => hotspotItem.sceneId == hotspot.sceneId);
    matchedHotspot.latitude = newLatitude;
    matchedHotspot.longtitude = newLongtitude;
  }
}

class HotspotDetail {
  final HotspotTypes hotspotType;
  late double latitude;
  late double longtitude;
  final String sceneId;

  HotspotDetail(this.hotspotType, this.latitude, this.longtitude, this.sceneId);

  static getHotspotType(String hotspotType) {
    if (hotspotType == 'scene') {
      return HotspotTypes.scene;
    }
    else if (hotspotType == 'info') {
      return HotspotTypes.info;
    }
    else {
      return HotspotTypes.unknown;
    }
  }

  factory HotspotDetail.fromJson(Map<String, dynamic> json) {
    return HotspotDetail(
      HotspotDetail.getHotspotType(json['type']), 
      double.parse(json['latitude'].toString()), 
      double.parse(json['longtitude'].toString()), 
      json['sceneId']
    );
  }
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
