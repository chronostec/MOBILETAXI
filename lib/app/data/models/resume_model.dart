class Resume {
  int? duree;
  String? montant;
  double? distance;
  String? date;
  String? espece;
  String? dematerialise;

  Resume(
      {this.duree,
      this.montant,
      this.distance,
      this.date,
      this.espece,
      this.dematerialise});

  Resume.fromJson(Map<String, dynamic> json) {
    duree = json['duree'];
    montant = json['montant'];
    distance = json['distance'];
    date = json['date'];
    espece = json['espece'];
    dematerialise = json['dematerialise'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['duree'] = duree;
    data['montant'] = montant;
    data['distance'] = distance;
    data['date'] = date;
    data['espece'] = espece;
    data['dematerialise'] = dematerialise;
    return data;
  }
}
