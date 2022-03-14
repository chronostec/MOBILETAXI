class DistanceDuree {
  var libelle;
  var distance;
  var duree;

  DistanceDuree({this.distance, this.duree, this.libelle});

  DistanceDuree.fromJson(Map<String, dynamic> json) {
    libelle = json['libelle'];
    distance = json['distance'];
    duree = json['duree'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['libelle'] = libelle;
    data['distance'] = distance;
    data['duree'] = duree;
    return data;
  }
}
