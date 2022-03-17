class RechercheEvaluation {
  var id;
  var libelle;
  int? montant;
  int? montantMinimum;
  int? palier;

  RechercheEvaluation(
      {this.id, this.libelle, this.montant, this.montantMinimum, this.palier});

  RechercheEvaluation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    libelle = json['Libelle'];
    montant = json['montant'];
    montantMinimum = json['montant_minimum'];
    palier = json['palier'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['Libelle'] = libelle;
    data['montant'] = montant;
    data['montant_minimum'] = montantMinimum;
    data['palier'] = palier;
    return data;
  }
}
