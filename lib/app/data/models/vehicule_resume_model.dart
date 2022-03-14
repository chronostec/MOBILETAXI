class VehiculeResume {
  int? id;
  String? immatriculation;
  String? marque;
  String? modele;
  String? couleur;
  String? annee;
  int? categorieId;
  int? status;
  int? driverId;
  String? driverNom;
  String? driverPrenom;
  String? driverTelephone;
  int? distanceJour;
  int? dureeJour;
  String? montantJour;

  VehiculeResume(
      {this.id,
      this.immatriculation,
      this.marque,
      this.modele,
      this.couleur,
      this.annee,
      this.categorieId,
      this.status,
      this.driverId,
      this.driverNom,
      this.driverPrenom,
      this.driverTelephone,
      this.distanceJour,
      this.dureeJour,
      this.montantJour});

  VehiculeResume.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    immatriculation = json['immatriculation'];
    marque = json['marque'];
    modele = json['modele'];
    couleur = json['couleur'];
    annee = json['annee'];
    categorieId = json['categorie_id'];
    status = json['status'];
    driverId = json['driver_id'];
    driverNom = json['driver_nom'];
    driverPrenom = json['driver_prenom'];
    driverTelephone = json['driver_telephone'];
    distanceJour = json['distance_jour'];
    dureeJour = json['duree_jour'];
    montantJour = json['montant_jour'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['immatriculation'] = immatriculation;
    data['marque'] = marque;
    data['modele'] = modele;
    data['couleur'] = couleur;
    data['annee'] = annee;
    data['categorie_id'] = categorieId;
    data['status'] = status;
    data['driver_id'] = driverId;
    data['driver_nom'] = driverNom;
    data['driver_prenom'] = driverPrenom;
    data['driver_telephone'] = driverTelephone;
    data['distance_jour'] = distanceJour;
    data['duree_jour'] = dureeJour;
    data['montant_jour'] = montantJour;
    return data;
  }
}
