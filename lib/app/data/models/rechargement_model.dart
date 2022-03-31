class Rechargement {
  int? proprioId;
  double? solde;
  List<Operation>? operation;

  Rechargement({this.proprioId, this.solde, this.operation});

  Rechargement.fromJson(Map<String, dynamic> json) {
    proprioId = json['proprio_id'];
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
    data['proprio_id'] = proprioId;
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
  String? montant;
  String? destinataireContact;
  int? beneficiaireId;
  String? beneficiaireContact;
  String? beneficiaireNom;
  String? beneficiairePrenom;
  String? date;
  String? type;
  String? status;

  Operation(
      {this.id,
      this.ref,
      this.montant,
      this.destinataireContact,
      this.beneficiaireId,
      this.beneficiaireContact,
      this.beneficiaireNom,
      this.beneficiairePrenom,
      this.date,
      this.type,
      this.status});

  Operation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ref = json['ref'];
    montant = json['montant'];
    destinataireContact = json['destinataire_contact'];
    beneficiaireId = json['beneficiaire_id'];
    beneficiaireContact = json['beneficiaire_contact'];
    beneficiaireNom = json['beneficiaire_nom'];
    beneficiairePrenom = json['beneficiaire_prenom'];
    date = json['date'];
    type = json['type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['ref'] = ref;
    data['montant'] = montant;
    data['destinataire_contact'] = destinataireContact;
    data['beneficiaire_id'] = beneficiaireId;
    data['beneficiaire_contact'] = beneficiaireContact;
    data['beneficiaire_nom'] = beneficiaireNom;
    data['beneficiaire_prenom'] = beneficiairePrenom;
    data['date'] = date;
    data['type'] = type;
    data['status'] = status;
    return data;
  }
}
