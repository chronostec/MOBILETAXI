class User {
  int? id;
  String? telephone;
  double? gpsLatitude;
  double? gpsLongitude;
  String? noted;
  bool? status;
  String? materiel;
  String? language;
  String? theme;

  User(
      {this.id,
      this.telephone,
      this.gpsLatitude,
      this.gpsLongitude,
      this.noted,
      this.status,
      this.materiel,
      this.language,
      this.theme});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    telephone = json['telephone'];
    gpsLatitude = json['gps_latitude'];
    gpsLongitude = json['gps_longitude'];
    noted = json['noted'];
    status = json['status'];
    materiel = json['materiel'];
    language = json['language'];
    theme = json['theme'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['telephone'] = telephone;
    data['gps_latitude'] = gpsLatitude;
    data['gps_longitude'] = gpsLongitude;
    data['noted'] = noted;
    data['status'] = status;
    data['materiel'] = materiel;
    data['language'] = language;
    data['theme'] = theme;
    return data;
  }
}
