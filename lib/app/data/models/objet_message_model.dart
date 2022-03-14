class ObjetMessage {
  var id;
  var libelle;

  ObjetMessage({this.id, this.libelle});

  ObjetMessage.fromJson(Map<String, dynamic> json) {
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
