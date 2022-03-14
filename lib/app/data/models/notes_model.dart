class Notes {
  int? id;
  String? libelle;
  List<Details>? details;

  Notes({this.id, this.libelle, this.details});

  Notes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    libelle = json['libelle'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details?.add(Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['libelle'] = libelle;
    if (details != null) {
      data['details'] = details?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  int? iD;
  int? noteId;
  String? libelle;

  Details({this.iD, this.noteId, this.libelle});

  Details.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    noteId = json['note_id'];
    libelle = json['libelle'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ID'] = iD;
    data['note_id'] = noteId;
    data['libelle'] = libelle;
    return data;
  }
}
