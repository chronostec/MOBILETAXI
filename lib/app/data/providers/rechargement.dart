import 'package:fredy_proprio/app/data/models/paiement_model.dart';
import 'package:fredy_proprio/app/data/models/rechargement_model.dart';
import 'package:fredy_proprio/app/utils/app_urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RechargementProvider {
  /// DEMANDER UN LIEN DE RECHARGEMENT
  Future<Paiement> getLienRechargement(
      {required int proprio_id,
      required int driver_id,
      required String driver_contact,
      required int montant}) async {
    var url = APPURL.BASE_URL +
        APPURL.GET_LIEN_RECHARGE +
        "proprio_id=$proprio_id&driver_id=$driver_id&driver_contact=$driver_contact&montant=$montant";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Paiement.fromJson(json.decode(response.body));
    } else {
      return Paiement();
    }
  }

  /// LISTER LES 100 DERNIERS  RECHARGEMENTS
  Future<Rechargement> getListerHistoriqueRechargement(
      {required int proprio_id}) async {
    var url = APPURL.BASE_URL +
        APPURL.GET_LISTER_HISTORIQUE_RECHARGE +
        "proprio_id=$proprio_id";
    final response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      return Rechargement.fromJson(json.decode(response.body));
    } else {
      return Rechargement();
    }
  }
}
