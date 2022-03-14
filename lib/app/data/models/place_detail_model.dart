class PlaceDetail {
  String? name;
  String? placeId;
  Geometry? geometry;

  PlaceDetail({this.name, this.placeId, this.geometry});

  PlaceDetail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    placeId = json['place_id'];
    geometry =
        json['geometry'] != null ? Geometry?.fromJson(json['geometry']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['place_id'] = placeId;
    if (geometry != null) {
      data['geometry'] = geometry?.toJson();
    }
    return data;
  }
}

class Geometry {
  var location;
  var viewport;

  Geometry({this.location, this.viewport});

  Geometry.fromJson(Map<String, dynamic> json) {
    location =
        json['location'] != null ? Location?.fromJson(json['location']) : null;
    viewport =
        json['viewport'] != null ? Viewport?.fromJson(json['viewport']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location?.toJson();
    }
    if (viewport != null) {
      data['viewport'] = viewport?.toJson();
    }
    return data;
  }
}

class Location {
  var lat;
  var lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class Viewport {
  Location? northeast;
  Location? southwest;

  Viewport({this.northeast, this.southwest});

  Viewport.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ? Location?.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ? Location?.fromJson(json['southwest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (northeast != null) {
      data['northeast'] = northeast?.toJson();
    }
    if (southwest != null) {
      data['southwest'] = southwest?.toJson();
    }
    return data;
  }
}
