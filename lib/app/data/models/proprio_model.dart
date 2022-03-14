class Proprio {
  int? id;
  String? nom;
  String? prenom;
  String? email;
  String? telephone;
  String? password;
  int? status;
  // String? urlien;

  Proprio(
      {this.id,
      this.nom,
      this.prenom,
      this.email,
      this.telephone,
      this.password,
      this.status,
      // this.urlien,
      });

  Proprio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    prenom = json['prenom'];
    email = json['email'];
    telephone = json['telephone'];
    password = json['password'];
    status = json['status'];
    // urlien = json['urlien'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nom'] = nom;
    data['prenom'] = prenom;
    data['email'] = email;
    data['telephone'] = telephone;
    data['password'] = password;
    data['status'] = status;
    // data['urlien'] = urlien;
    return data;
  }
}
