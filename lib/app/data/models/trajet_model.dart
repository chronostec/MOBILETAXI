class Trajet {
  String? id;
  String? origLibelle;
  String? origLataitude;
  String? origLongitude;
  String? destLibelle;
  String? destLataitude;
  String? destLongitude;
  String? duration;
  String? distance;
  String? info;

  Trajet(
      {this.id,
      this.origLibelle,
      this.origLataitude,
      this.origLongitude,
      this.destLibelle,
      this.destLataitude,
      this.destLongitude,
      this.duration,
      this.distance,
      this.info});

  Trajet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    origLibelle = json['orig_libelle'];
    origLataitude = json['orig_lataitude'];
    origLongitude = json['orig_longitude'];
    destLibelle = json['dest_libelle'];
    destLataitude = json['dest_lataitude'];
    destLongitude = json['dest_longitude'];
    duration = json['duration'];
    distance = json['distance'];
    info = json['info'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['orig_libelle'] = origLibelle;
    data['orig_lataitude'] = origLataitude;
    data['orig_longitude'] = origLongitude;
    data['dest_libelle'] = destLibelle;
    data['dest_lataitude'] = destLataitude;
    data['dest_longitude'] = destLongitude;
    data['duration'] = duration;
    data['distance'] = distance;
    data['info'] = info;
    return data;
  }
}
