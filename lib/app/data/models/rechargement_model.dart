class Rechargement {
  int? driverId;
  int? solde;
  List<Operation>? operation;

  Rechargement({this.driverId, this.solde, this.operation});

  Rechargement.fromJson(Map<String, dynamic> json) {
    driverId = json['driver_id'];
    solde = json['solde'];
    if (json['operation'] != null) {
      operation = <Operation>[];
      json['operation'].forEach((v) {
        operation?.add(Operation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['driver_id'] = driverId;
    data['solde'] = solde;
    if (operation != null) {
      data['operation'] = operation?.map((v) => v.toJson()).toList();
    }
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
  String? status;

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
