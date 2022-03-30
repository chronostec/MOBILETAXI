class Rechargement {
  int? driverId;
  double? solde;
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
  String? ref;
  String? contact;
  String? montant;
  String? date;
  String? status;

  Operation(
      {this.id, this.ref, this.contact, this.montant, this.date, this.status});

  Operation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ref = json['ref'];
    contact = json['contact'];
    montant = json['montant'];
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['ref'] = ref;
    data['contact'] = contact;
    data['montant'] = montant;
    data['date'] = date;
    data['status'] = status;
    return data;
  }
}