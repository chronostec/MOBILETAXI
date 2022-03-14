class Resultat {
  var bSuccess;
  var message;
  var objet;

  Resultat({this.bSuccess, this.message, this.objet});

  Resultat.fromJson(Map<String, dynamic> json) {
    bSuccess = json['bSuccess'];
    message = json['message'];
    objet = json['objet'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['bSuccess'] = bSuccess;
    data['message'] = message;
    data['objet'] = objet;
    return data;
  }
}
