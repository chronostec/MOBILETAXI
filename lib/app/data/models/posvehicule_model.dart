class Posvehicule {
  int? id;
  int? commandeId;
  String? gpsLon;
  String? gpsLat;
  String? distanceRestante;
  int? dureeRestante;
  String? commentaire;
  String? date;

  Posvehicule(
      {this.id,
      this.commandeId,
      this.gpsLon,
      this.gpsLat,
      this.distanceRestante,
      this.dureeRestante,
      this.commentaire,
      this.date});

  Posvehicule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commandeId = json['commande_id'];
    gpsLon = json['gps_lon'];
    gpsLat = json['gps_lat'];
    distanceRestante = json['distance_restante'];
    dureeRestante = json['duree_restante'];
    commentaire = json['commentaire'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['commande_id'] = commandeId;
    data['gps_lon'] = gpsLon;
    data['gps_lat'] = gpsLat;
    data['distance_restante'] = distanceRestante;
    data['duree_restante'] = dureeRestante;
    data['commentaire'] = commentaire;
    data['date'] = date;
    return data;
  }
}
