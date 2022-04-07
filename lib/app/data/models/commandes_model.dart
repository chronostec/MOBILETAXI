class Commandes {
  bool? bSuccess;
  String? message;
  List<Compte>? compte;
  List<Commande>? commande;

  Commandes({this.bSuccess, this.message, this.compte, this.commande});

  Commandes.fromJson(Map<String, dynamic> json) {
    bSuccess = json['bSuccess'];
    message = json['message'];
    if (json['compte'] != null) {
      compte = <Compte>[];
      json['compte'].forEach((v) {
        compte?.add(Compte.fromJson(v));
      });
    }
    if (json['commande'] != null) {
      commande = <Commande>[];
      json['commande'].forEach((v) {
        commande?.add(Commande.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bSuccess'] = bSuccess;
    data['message'] = message;
    if (compte != null) {
      data['compte'] = compte?.map((v) => v.toJson()).toList();
    }
    if (commande != null) {
      data['commande'] = commande?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Compte {
  int? statusCompte;
  dynamic solde;

  Compte({this.statusCompte, this.solde});

  Compte.fromJson(Map<String, dynamic> json) {
    statusCompte = json['status_compte'];
    solde = json['solde'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status_compte'] = statusCompte;
    data['solde'] = solde;
    return data;
  }
}

class Commande {
  int? id;
  int? duree;
  int? montantReel;
  int? montantPercu;
  int? montantNegocie;
  String? destLibelle;
  double? destLongitude;
  double? destLatitude;
  double? clientLongitude;
  double? clientLatitude;
  int? clientId;
  String? clientTelephone;
  int? status;
  String? clientLibelle;

  Commande(
      {this.id,
      this.duree,
      this.montantReel,
      this.montantPercu,
      this.montantNegocie,
      this.destLibelle,
      this.destLongitude,
      this.destLatitude,
      this.clientLongitude,
      this.clientLatitude,
      this.clientId,
      this.clientTelephone,
      this.status,
      this.clientLibelle});

  Commande.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    duree = json['duree'];
    montantReel = json['montant_reel'];
    montantPercu = json['montant_percu'];
    montantNegocie = json['montant_negocie'];
    destLibelle = json['dest_libelle'];
    destLongitude = json['dest_longitude'];
    destLatitude = json['dest_latitude'];
    clientLongitude = json['client_longitude'];
    clientLatitude = json['client_latitude'];
    clientId = json['client_id'];
    clientTelephone = json['client_telephone'];
    status = json['status'];
    clientLibelle = json['client_libelle'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['duree'] = duree;
    data['montant_reel'] = montantReel;
    data['montant_percu'] = montantPercu;
    data['montant_negocie'] = montantNegocie;
    data['dest_libelle'] = destLibelle;
    data['dest_longitude'] = destLongitude;
    data['dest_latitude'] = destLatitude;
    data['client_longitude'] = clientLongitude;
    data['client_latitude'] = clientLatitude;
    data['client_id'] = clientId;
    data['client_telephone'] = clientTelephone;
    data['status'] = status;
    data['client_libelle'] = clientLibelle;
    return data;
  }
}
