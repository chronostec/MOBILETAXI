class Commande {
  int? id;
  var duree;
  var distance;
  var montantReel;
  var montantPercu;
  var destLibelle;
  var destLatitude;
  var destLongitude;
  var clientLibelle;
  var clientLatitude;
  var clientLongitude;
  int? clientId;
  var clientTelephone;
  int? status;

  Commande(
      {this.id,
      this.duree,
      this.distance,
      this.montantReel,
      this.montantPercu,
      this.destLibelle,
      this.destLatitude,
      this.destLongitude,
      this.clientLibelle,
      this.clientLatitude,
      this.clientLongitude,
      this.clientId,
      this.clientTelephone,
      this.status});

  Commande.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    duree = json['duree'];
    distance = json['distance'];
    montantReel = json['montant_reel'].toString();
    montantPercu = json['montant_percu'].toString();
    destLibelle = json['dest_libelle'];
    destLatitude = json['dest_latitude'];
    destLongitude = json['dest_longitude'];
    clientLibelle = json['client_libelle'];
    clientLatitude = json['client_latitude'];
    clientLongitude = json['client_longitude'];
    clientId = json['client_id'];
    clientTelephone = json['client_telephone'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['duree'] = duree;
    data['distance'] = distance;
    data['montant_reel'] = montantReel;
    data['montant_percu'] = montantPercu;
    data['dest_libelle'] = destLibelle;
    data['dest_latitude'] = destLatitude;
    data['dest_longitude'] = destLongitude;
    data['client_libelle'] = clientLibelle;
    data['client_latitude'] = clientLatitude;
    data['client_longitude'] = clientLongitude;
    data['client_id'] = clientId;
    data['client_telephone'] = clientTelephone;
    data['status'] = status;
    return data;
  }
}
