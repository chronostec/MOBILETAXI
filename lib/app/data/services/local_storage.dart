import 'package:alfred_taxi_driver/app/data/models/commandes_model.dart';
import 'package:alfred_taxi_driver/app/data/models/driver_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalStorage extends GetxController {
  final box = GetStorage();
  var isAuth = false.obs;
  static const String tableName = "driver_user_data";
  static const String cmdeTable = "driver_cmde_data";

  ///`READ USER DATA FROM LOCAL STORAGE AND RETURN`
  ///`IF NOT EMPTY ELSE CLEAR USER`
  Future<Driver> readUserData() async {
    var currentUser = Driver();
    if (box.read(tableName) != null) {
      final data = box.read(tableName) as Map<String, dynamic>;

      currentUser = Driver(
          id: data['id'] ?? 0,
          nom: data['nom'] ?? '',
          prenom: data['prenom'] ?? '',
          telephone: data['telephone'] ?? '',
          password: data['password'] ?? '',
          cleConnexion: data['cle_connexion'] ?? '',
          gpsLatitude: data['gps_latitude'],
          gpsLongitude: data['gps_longitude'],
          proprioId: data['proprio_id'] ?? 0,
          vehiculeId: data['vehicule_id'] ?? 0,
          immatriculation: data['immatriculation'] ?? '',
          language: data['language'] ?? '',
          theme: data['theme'] ?? '',
          licence: data['licence'] ?? 0);
    } else {
      currentUser = Driver(id: null);
    }
    print("CURRENT USER: ${currentUser.toJson()}");
    return currentUser;
  }

  ///`SAVE USER DATA INTO LOCAL STORAGE`
  Future saveUserData(Driver model) async {
    box.write(
      tableName,
      {
        "id": model.id ?? 0,
        "nom": model.nom ?? '',
        "prenom": model.prenom ?? '',
        "telephone": model.telephone ?? '',
        "password": model.password ?? '',
        "cle_connexion": model.cleConnexion ?? '',
        "gps_latitude": model.gpsLatitude,
        "gps_longitude": model.gpsLongitude,
        "proprio_id": model.proprioId ?? 0,
        "vehicule_id": model.vehiculeId ?? 0,
        "immatriculation": model.immatriculation ?? '',
        "language": model.language ?? '',
        "theme": model.theme ?? '',
        "licence": model.licence ?? 0,
      },
    );
    return await readUserData();
  }

  ///`READ CMDE DATA FROM LOCAL STORAGE AND RETURN`
  ///`IF NOT EMPTY ELSE CLEAR CMDE`
  Future<Commande> readCurrentCmde() async {
    var commande = Commande(id: 0);
    if (box.read(cmdeTable) != null) {
      final data = box.read(cmdeTable) as Map<String, dynamic>;

      commande = Commande(
        id: data['id'] ?? 0,
        duree: data['duree'] ?? "",
        // distance: data['distance'] ?? "",
        montantReel: data['montant_reel'] ?? 0,
        montantPercu: data['montant_percu'] ?? 0,
        destLibelle: data['dest_libelle'] ?? "",
        destLatitude: data['dest_latitude'] ?? 0.0,
        destLongitude: data['dest_longitude'] ?? 0.0,
        clientLibelle: data['client_libelle'] ?? "",
        clientLatitude: data['client_latitude'] ?? 0.0,
        clientLongitude: data['client_longitude'] ?? 0.0,
        clientId: data['client_id'] ?? 0,
        clientTelephone: data['client_telephone'] ?? "",
        status: data['status'] ?? 0,
      );
    } else {
      commande = Commande(id: 0);
    }
    printInfo(info: "CURRENT CMDE: ${commande.toJson()}");
    return commande;
  }

  ///`SAVE CURRENT CMDE INTO LOCAL STORAGE`
  Future saveCurrentCmde(Commande commande) async {
    box.write(
      cmdeTable,
      {
        "id": commande.id ?? 0,
        "duree": commande.duree ?? 0,
        // "distance": commande.distance ?? "",
        "montant_reel": commande.montantReel ?? 0,
        "montant_percu": commande.montantPercu ?? 0,
        "dest_libelle": commande.destLibelle ?? "",
        "dest_latitude": commande.destLatitude ?? -0.1,
        "dest_longitude": commande.destLongitude ?? -0.1,
        "client_libelle": commande.clientLibelle ?? "",
        "client_latitude": commande.clientLatitude ?? -0.1,
        "client_longitude": commande.clientLongitude ?? -0.1,
        "client_id": 0,
        "client_telephone": commande.clientTelephone ?? "",
        "status": commande.status ?? 0,
      },
    );

    await readCurrentCmde();
  }

  @override
  void onInit() {
    readUserData();
    readCurrentCmde();
    super.onInit();
  }
}
