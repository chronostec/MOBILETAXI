import 'dart:convert';

import 'package:alfred_taxi_driver/app/data/models/echange_model.dart';
import 'package:alfred_taxi_driver/app/data/models/partage_model.dart';
import 'package:alfred_taxi_driver/app/utils/app_urls.dart';
import 'package:http/http.dart' as http;

class EchangeProvider {
  Future<List<Echange>> getEchange({
    required cmde_id,
  }) async {
    var url = APPURL.BASE_URL + APPURL.GET_DRIVER_LIRE + "cmde_id=$cmde_id";

    var _list = <Echange>[];

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      _list = parseEchanges(response.body);
    }
    if (_list.isNotEmpty) {
      return _list;
    } else {
      return [];
    }
  }

  Future<Resultat> postEchange({
    required cmde_id,
    required driver_id,
    required message,
  }) async {
    var url = APPURL.BASE_URL +
        APPURL.POST_DRIVER_ECRIRE +
        "driver_id=$driver_id&cmde_id=$cmde_id&message=$message";

    var _res = Resultat();
    final response = await http.post(Uri.parse(url));
    // print(response.body);
    _res = parseResultats(response.body);

    return _res;
  }

  Resultat parseResultats(responseBody) {
    final parsed = json.decode(responseBody);

    return Resultat.fromJson(parsed);
  }

  List<Echange> parseEchanges(responseBody) {
    List<Echange> _res = [];
    try {
      final parsed =
          json.decode(responseBody)["objet"].cast<Map<String, dynamic>>();

      _res = parsed.map<Echange>((json) => Echange.fromJson(json)).toList();
    } catch (e) {
      print(e);
    }

    return _res;
  }
}
