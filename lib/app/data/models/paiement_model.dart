class Paiement {
  String? lien;

  Paiement({this.lien});

  Paiement.fromJson(Map<String, dynamic> json) {
    lien = json['lien'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lien'] = lien;
    return data;
  }
}
