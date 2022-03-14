class MotifAnnulation {
  var id;
  var libelle;

  MotifAnnulation({this.libelle});

  MotifAnnulation.fromJson(Map<String, dynamic> json) {
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
