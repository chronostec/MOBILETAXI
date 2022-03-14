import 'dart:convert';

import 'package:alfred_taxi_client/app/common/app_urls.dart';
import 'package:alfred_taxi_client/app/data/models/annulation_taxi_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AnnulationTaxiProvider extends GetConnect {
  Future<AnnulationTaxi> postAnnulationTaxi(
      {required motif_id, required proposition_id}) async {
    var url = APPURL.BASE_URL +
        APPURL.ANNULATION_TAXI_URL +
        "motif_id=$motif_id&proposition_id=$proposition_id";

    print("ANNULAER COMMANDE: $motif_id $proposition_id");
    print(url);
    var _res = AnnulationTaxi();

    final response = await http.post(Uri.parse(url));
    print("ANNULAER COMMANDE: ${response.body}");
    if (response.statusCode == 200) {
      _res = parseAnnulationTaxis(response.body);
    }

    return _res;
  }

  AnnulationTaxi parseAnnulationTaxis(responseBody) {
    final parsed = json.decode(responseBody);

    return AnnulationTaxi.fromJson(parsed);
  }
}
