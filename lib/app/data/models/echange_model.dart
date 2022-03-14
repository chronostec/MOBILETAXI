class Echange {
  dynamic clientId;
  dynamic driverId;
  String? contenu;

  Echange({this.clientId, this.driverId, this.contenu});

  Echange.fromJson(Map<String, dynamic> json) {
    clientId = json['client_id'];
    driverId = json['driver_id'];
    contenu = json['contenu'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['client_id'] = clientId;
    data['driver_id'] = driverId;
    data['contenu'] = contenu;
    return data;
  }
}
