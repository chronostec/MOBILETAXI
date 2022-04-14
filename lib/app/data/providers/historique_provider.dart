import 'dart:convert';

import 'package:alfred_taxi_driver/app/data/models/historique_model.dart';
import 'package:alfred_taxi_driver/app/utils/app_urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HistoriqueProvider extends GetConnect {
  Future<List<Historique>> getHistorique(
      {required driver_id, cleConnexion}) async {
    var url = APPURL.BASE_URL +
        APPURL.GET_HISTORIQUE +
        "driver_id=$driver_id&cle_connexion=$cleConnexion&id_user=$driver_id";

    var _list = <Historique>[];

    final response = await http.get(Uri.parse(url));
    // print(response.body);
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
