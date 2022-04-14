import 'package:alfred_taxi_driver/app/data/models/contact_model.dart';
import 'package:alfred_taxi_driver/app/data/models/paiement_model.dart';
import 'package:alfred_taxi_driver/app/data/models/rechargement_model.dart';
import 'package:alfred_taxi_driver/app/utils/app_urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RechargementProvider {
  /// DEMANDER UN LIEN DE RECHARGEMENT
  Future<Paiement> getLienRechargement(
      {required int driver_id, required int montant, cleConnexion}) async {
    var url = APPURL.BASE_URL +
        APPURL.GET_LIEN_RECHARGE +
        "driver_id=$driver_id&cle_connexion=$cleConnexion&id_user=$driver_id&montant=$montant";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Paiement.fromJson(json.decode(response.body));
    } else {
      return Paiement();
    }
  }

  /// LISTER LES 100 DERNIERS  RECHARGEMENTS
  Future<Rechargement> getListerHistoriqueRechargement(
      {required int driver_id, cleConnexion}) async {
    var url = APPURL.BASE_URL +
        APPURL.GET_LISTER_HISTORIQUE_RECHARGE +
        "driver_id=$driver_id&cle_connexion=$cleConnexion&id_user=$driver_id";
    final response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      return Rechargement.fromJson(json.decode(response.body));
    } else {
      return Rechargement();
    }
  }

  /// LISTER LES CONTACTS DU SERVICE DE RECHARGEMENT
  Future<List<Contact>> getListerContactServiceRechargement(
      cleConnexion, id_user) async {
    var url = APPURL.BASE_URL +
        APPURL.GET_CONTACT_SERVICE_RECHARGEMENT +
        "cle_connexion=$cleConnexion&id_user=$id_user";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final parsed =
          json.decode(response.body)["objet"].cast<Map<String, dynamic>>();
      return parsed.map<Contact>((json) => Contact.fromJson(json)).toList();
    } else {
      return [];
    }
  }
}
