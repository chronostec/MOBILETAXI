class Notifications {
  int? id;
  String? titre;
  String? message;
  String? lien;
  String? date;

  Notifications({this.id, this.titre, this.message, this.lien, this.date});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titre = json['titre'];
    message = json['message'];
    lien = json['lien'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['titre'] = titre;
    data['message'] = message;
    data['lien'] = lien;
    data['date'] = date;
    return data;
  }
}
