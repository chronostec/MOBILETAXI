class ImagePath {
  int? id;
  String? nom;
  String? path;

  ImagePath({this.id, this.nom, this.path});

  ImagePath.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nom'] = nom;
    data['path'] = path;
    return data;
  }
}
