class MessageSupport {
  var clientId;
  var objet;
  var contenu;
  var bSuccess;
  var message;

  MessageSupport(
      {this.clientId, this.objet, this.contenu, this.bSuccess, this.message});

  MessageSupport.fromJson(Map<String, dynamic> json) {
    clientId = json['client_id'];
    objet = json['objet'];
    contenu = json['contenu'];
    bSuccess = json['bSuccess'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['client_id'] = clientId;
    data['objet'] = objet;
    data['contenu'] = contenu;
    data['bSuccess'] = bSuccess;
    data['message'] = message;
    return data;
  }
}
