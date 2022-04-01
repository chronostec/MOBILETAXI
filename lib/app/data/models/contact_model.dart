class Contact {
  int? id;
  String? telephone;
  String? reseau;

  Contact({this.id, this.telephone, this.reseau});

  Contact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    telephone = json['telephone'];
    reseau = json['reseau'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['telephone'] = telephone;
    data['reseau'] = reseau;
    return data;
  }
}
