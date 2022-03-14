class Historique {
  int? id;
  String? destination;
  int? duree;
  String? montantPercu;
  String? date;

  Historique(
      {this.id, this.destination, this.duree, this.montantPercu, this.date});

  Historique.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    destination = json['destination'];
    duree = json['duree'];
    montantPercu = json['montant_percu'].toString();
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['destination'] = destination;
    data['duree'] = duree;
    data['montant_percu'] = montantPercu;
    data['date'] = date;
    return data;
  }
}
