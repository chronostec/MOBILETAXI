class Point {
  String? id;
  String? libelle;
  double? latitude;
  double? longitude;
  String? info;

  Point({this.id, this.libelle, this.latitude, this.longitude, this.info});

  Point.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    libelle = json['libelle'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    info = json['info'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['libelle'] = libelle;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['info'] = info;
    return data;
  }
}
