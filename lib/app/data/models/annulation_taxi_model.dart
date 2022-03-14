class AnnulationTaxi {
  var motifId;
  var commandeId;
  var bSuccess;
  var message;
  var objet;

  AnnulationTaxi(
      {this.motifId, this.commandeId, this.bSuccess, this.message, this.objet});

  AnnulationTaxi.fromJson(Map<String, dynamic> json) {
    motifId = json['motif_id'];
    commandeId = json['commande_id'];
    bSuccess = json['bSuccess'];
    message = json['message'];
    objet = json['objet'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['motif_id'] = motifId;
    data['commande_id'] = commandeId;
    data['bSuccess'] = bSuccess;
    data['message'] = message;
    data['objet'] = objet;
    return data;
  }
}
