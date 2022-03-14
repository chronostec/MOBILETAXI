import 'dart:convert';

import 'package:alfred_taxi_client/app/common/app_urls.dart';
import 'package:alfred_taxi_client/app/data/models/otp_model.dart';
import 'package:alfred_taxi_client/app/data/models/paiement_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PaiementProvider extends GetConnect {
  Future<Paiement> getPaiement({required commande_id}) async {
    var url =
        APPURL.BASE_URL + APPURL.PAIEMENT_URL + "commande_id=$commande_id";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      return Paiement.fromJson(parsed);
    } else {
      return Paiement();
    }
  }
}
