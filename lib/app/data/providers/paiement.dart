import 'package:alfred_taxi_driver/app/data/models/partage_model.dart';
import 'package:alfred_taxi_driver/app/utils/app_urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaiementProvider {
  Future<Resultat> postPaiement({required int commande_id}) async {
    var url = APPURL.BASE_URL +
        APPURL.POST_ESPECE +
        "mode_paiement_id=1&monnaie=0&etat=1&detail=neant&commande_id=$commande_id";
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to load predictions');
    }
    return Resultat.fromJson(json.decode(response.body));
  }
}
