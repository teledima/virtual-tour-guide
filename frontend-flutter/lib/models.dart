enum HotspotTypes {
  scene,
  info,
  unknown
}

class TourDetail {
  final String tourId;
  final TourMetadata metadata;
  final List<SceneDetail>? scenes;
  final DefaultDetail? defaultScene;

  TourDetail(this.tourId, this.metadata, this.scenes, this.defaultScene);

  factory TourDetail.fromJson(Map<String, dynamic> json) {
    return TourDetail(
      json['tourId'],
      TourMetadata.fromJson(json['metadata']),
      json['scenes']?.map((scene) => SceneDetail.fromJson(scene)).toList().cast<SceneDetail>(), 
      json.containsKey('default') ? DefaultDetail.fromJson(json['default']) : null
    );
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
}

class HotspotDetail {
  final HotspotTypes hotspotType;
  final double latitude;
  final double longtitude;
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
