class Driver {
  int? id;
  String? nom;
  String? prenom;
  String? telephone;
  String? numeroPermis;
  String? imagePermis;
  int? vehiculeId;

  Driver(
      {this.id,
      this.nom,
      this.prenom,
      this.telephone,
      this.numeroPermis,
      this.imagePermis,
      this.vehiculeId});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    prenom = json['prenom'];
    telephone = json['telephone'];
    numeroPermis = json['numero_permis'];
    imagePermis = json['image_permis'];
    vehiculeId = json['vehicule_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nom'] = nom;
    data['prenom'] = prenom;
    data['telephone'] = telephone;
    data['numero_permis'] = numeroPermis;
    data['image_permis'] = imagePermis;
    data['vehicule_id'] = vehiculeId;
    return data;
  }
}
