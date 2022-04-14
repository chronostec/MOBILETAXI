class Driver {
  int? id;
  String? nom;
  String? prenom;
  String? telephone;
  String? password;
  int? status;
  int? licence;
  String? gpsLatitude;
  String? gpsLongitude;
  int? proprioId;
  int? vehiculeId;
  String? immatriculation;
  String? language;
  String? theme;
  String? bChangementPass;
  int? idUser;
  String? cleConnexion;

  Driver(
      {this.id,
      this.nom,
      this.prenom,
      this.telephone,
      this.password,
      this.status,
      this.licence,
      this.gpsLatitude,
      this.gpsLongitude,
      this.proprioId,
      this.vehiculeId,
      this.immatriculation,
      this.language,
      this.theme,
      this.bChangementPass,
      this.idUser,
      this.cleConnexion});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    prenom = json['prenom'];
    telephone = json['telephone'];
    password = json['password'];
    status = json['status'];
    licence = json['licence'];
    gpsLatitude = json['gps_latitude'];
    gpsLongitude = json['gps_longitude'];
    proprioId = json['proprio_id'];
    vehiculeId = json['vehicule_id'];
    immatriculation = json['immatriculation'];
    language = json['language'];
    theme = json['theme'];
    bChangementPass = json['b_changement_pass'];
    idUser = json['id_user'];
    cleConnexion = json['cle_connexion'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nom'] = nom;
    data['prenom'] = prenom;
    data['telephone'] = telephone;
    data['password'] = password;
    data['status'] = status;
    data['licence'] = licence;
    data['gps_latitude'] = gpsLatitude;
    data['gps_longitude'] = gpsLongitude;
    data['proprio_id'] = proprioId;
    data['vehicule_id'] = vehiculeId;
    data['immatriculation'] = immatriculation;
    data['language'] = language;
    data['theme'] = theme;
    data['b_changement_pass'] = bChangementPass;
    data['id_user'] = idUser;
    data['cle_connexion'] = cleConnexion;
    return data;
  }
}
