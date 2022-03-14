class Categorie {
  int? id;
  String? libelle;

  Categorie({this.id, this.libelle});

  Categorie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    libelle = json['libelle'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['libelle'] = libelle;
    return data;
  }
}
