class Rechargement {
  List<Operation>? operation;
  int? proprioId;
  int? solde;

  Rechargement({this.operation, this.proprioId, this.solde});

  Rechargement.fromJson(Map<String, dynamic> json) {
    if (json['operation'] != null) {
      operation = <Operation>[];
      json['operation'].forEach((v) {
        operation?.add(Operation.fromJson(v));
      });
    }
    proprioId = json['proprio_id'];
    solde = json['solde'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (operation != null) {
      data['operation'] = operation?.map((v) => v.toJson()).toList();
    }
    data['proprio_id'] = proprioId;
    data['solde'] = solde;
    return data;
  }
}

class Operation {
  int? id;
  String? reference;
  String? telDest;
  int? montant;
  String? type;
  String? date;
  int? status;

  Operation(
      {this.id,
      this.reference,
      this.telDest,
      this.montant,
      this.type,
      this.date,
      this.status});

  Operation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reference = json['reference'];
    telDest = json['tel_dest'];
    montant = json['montant'];
    type = json['type'];
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['reference'] = reference;
    data['tel_dest'] = telDest;
    data['montant'] = montant;
    data['type'] = type;
    data['date'] = date;
    data['status'] = status;
    return data;
  }
}
