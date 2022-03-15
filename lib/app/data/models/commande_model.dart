class Commande {
  int? id;
  int? dureeEffective;
  int? status;
  int? montantClient;
  String? immatriculation;
  String? marque;
  String? modele;
  String? couleur;
  int? driverId;
  String? driverNom;
  String? driverPrenom;
  String? numeroPermis;
  String? telephone;
  double? driverLong;
  double? driverLat;
  double? rdvLong;
  double? rdvLat;
  String? rdvLibelle;
  double? destLong;
  double? destLat;
  String? destLibelle;
  var gpsLon;
  var gpsLat;
  int? dureeRestante;

  Commande(
      {this.id,
      this.dureeEffective,
      this.status,
      this.montantClient,
      this.immatriculation,
      this.marque,
      this.modele,
      this.couleur,
      this.driverId,
      this.driverNom,
      this.driverPrenom,
      this.numeroPermis,
      this.telephone,
      this.driverLong,
      this.driverLat,
      this.rdvLong,
      this.rdvLat,
      this.rdvLibelle,
      this.destLong,
      this.destLat,
      this.destLibelle,
      this.gpsLon,
      this.gpsLat,
      this.dureeRestante});

  Commande.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dureeEffective = json['duree_effective'];
    status = json['status'];
    montantClient = json['montant_client'];
    immatriculation = json['immatriculation'];
    marque = json['marque'];
    modele = json['modele'];
    couleur = json['couleur'];
    driverId = json['driver_id'];
    driverNom = json['driver_nom'];
    driverPrenom = json['driver_prenom'];
    numeroPermis = json['numero_permis'];
    telephone = json['telephone'];
    driverLong = double.parse(json['driver_long'].toString());
    driverLat = double.parse(json['driver_lat'].toString());
    rdvLong = json['rdv_long'];
    rdvLat = json['rdv_lat'];
    rdvLibelle = json['rdv_libelle'];
    destLong = json['dest_long'];
    destLat = json['dest_lat'];
    destLibelle = json['dest_libelle'];
    gpsLon = json['gps_lon'];
    gpsLat = json['gps_lat'];
    dureeRestante = json['duree_restante'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['duree_effective'] = dureeEffective;
    data['status'] = status;
    data['montant_client'] = montantClient;
    data['immatriculation'] = immatriculation;
    data['marque'] = marque;
    data['modele'] = modele;
    data['couleur'] = couleur;
    data['driver_id'] = driverId;
    data['driver_nom'] = driverNom;
    data['driver_prenom'] = driverPrenom;
    data['numero_permis'] = numeroPermis;
    data['telephone'] = telephone;
    data['driver_long'] = driverLong;
    data['driver_lat'] = driverLat;
    data['rdv_long'] = rdvLong;
    data['rdv_lat'] = rdvLat;
    data['rdv_libelle'] = rdvLibelle;
    data['dest_long'] = destLong;
    data['dest_lat'] = destLat;
    data['dest_libelle'] = destLibelle;
    data['gps_lon'] = gpsLon;
    data['gps_lat'] = gpsLat;
    data['duree_restante'] = dureeRestante;
    return data;
  }
}
