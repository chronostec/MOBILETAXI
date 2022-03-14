import 'dart:convert';

import 'package:alfred_taxi_client/app/common/app_urls.dart';
import 'package:alfred_taxi_client/app/data/models/historique_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HistoriqueProvider extends GetConnect {
  Future<List<Historique>> getHistorique({
    required driver_id,
  }) async {
    var url =
        APPURL.BASE_URL + APPURL.HISTORIQUE_TRAJET_URL + "client_id=$driver_id";

    var _list = <Historique>[];

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      _list = parseHistoriques(response.body);
    }

    return _list;
  }

  List<Historique> parseHistoriques(responseBody) {
    final parsed =
        json.decode(responseBody)["objet"].cast<Map<String, dynamic>>();

    return parsed.map<Historique>((json) => Historique.fromJson(json)).toList();
  }
}
