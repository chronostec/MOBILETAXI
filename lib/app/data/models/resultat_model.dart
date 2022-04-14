class Resultat {
  var bSuccess;
  var message;
  var objet;
  var etatConnexion;

  Resultat({this.bSuccess, this.message, this.objet, this.etatConnexion});

  Resultat.fromJson(Map<String, dynamic> json) {
    bSuccess = json['bSuccess'];
    message = json['message'];
    etatConnexion = json['etat_connexion'];
    objet = json['objet'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['bSuccess'] = bSuccess;
    data['message'] = message;
    data['etat_connexion'] = etatConnexion;
    data['objet'] = objet;
    return data;
  }
}
