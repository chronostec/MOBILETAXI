class Otp {
  bool? bSuccess;
  String? message;
  List<Objet>? objet;

  Otp({this.bSuccess, this.message, this.objet});

  Otp.fromJson(Map<String, dynamic> json) {
    bSuccess = json['bSuccess'];
    message = json['message'];
    if (json['objet'] != null) {
      objet = <Objet>[];
      json['objet'].forEach((v) {
        objet?.add(Objet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bSuccess'] = bSuccess;
    data['message'] = message;
    if (objet != null) {
      data['objet'] = objet?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Objet {
  int? eTAT;
  int? iDClient;
  String? message;

  Objet({this.eTAT, this.iDClient, this.message});

  Objet.fromJson(Map<String, dynamic> json) {
    eTAT = json['ETAT'];
    iDClient = json['IDClient'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ETAT'] = eTAT;
    data['IDClient'] = iDClient;
    data['Message'] = message;
    return data;
  }
}
