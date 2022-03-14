class VehiculeHistoriqueCourse {
  String? message;
  List<Objet>? objet;
  String? totaux;
  String? espece;
  String? dematerialise;

  VehiculeHistoriqueCourse(
      {this.message, this.objet, this.totaux, this.espece, this.dematerialise});

  VehiculeHistoriqueCourse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['objet'] != null) {
      objet = <Objet>[];
      json['objet'].forEach((v) {
        objet?.add(Objet.fromJson(v));
      });
    }
    totaux = json['totaux'];
    espece = json['espece'];
    dematerialise = json['dematerialise'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    if (objet != null) {
      data['objet'] = objet?.map((v) => v.toJson()).toList();
    }
    data['totaux'] = totaux;
    data['espece'] = espece;
    data['dematerialise'] = dematerialise;
    return data;
  }
}

class Objet {
  int? duree;
  double? distance;
  String? montant;
  String? date;
  String? typePaiement;

  Objet(
      {this.duree, this.distance, this.montant, this.date, this.typePaiement});

  Objet.fromJson(Map<String, dynamic> json) {
    duree = json['duree'];
    distance = json['distance'];
    montant = json['montant'];
    date = json['date'];
    typePaiement = json['type_paiement'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['duree'] = duree;
    data['distance'] = distance;
    data['montant'] = montant;
    data['date'] = date;
    data['type_paiement'] = typePaiement;
    return data;
  }
}
