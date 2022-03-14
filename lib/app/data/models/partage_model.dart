class Partage {
  var numeropartage;
  var commandeId;
  var bSuccess;
  var message;
  var objet;

  Partage(
      {this.numeropartage,
      this.commandeId,
      this.bSuccess,
      this.message,
      this.objet});

  Partage.fromJson(Map<String, dynamic> json) {
    numeropartage = json['numeropartage'];
    commandeId = json['commande_id'];
    bSuccess = json['bSuccess'];
    message = json['message'];
    objet = json['objet'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['numeropartage'] = numeropartage;
    data['commande_id'] = commandeId;
    data['bSuccess'] = bSuccess;
    data['message'] = message;
    data['objet'] = objet;
    return data;
  }
}
