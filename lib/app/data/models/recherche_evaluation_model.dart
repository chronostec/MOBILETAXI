class RechercheEvaluation {
  var id;
  var libelle;
  var montant;

  RechercheEvaluation({this.id, this.libelle, this.montant});

  RechercheEvaluation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    libelle = json['Libelle'];
    montant = json['montant'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['Libelle'] = libelle;
    data['montant'] = montant;
    return data;
  }
}
