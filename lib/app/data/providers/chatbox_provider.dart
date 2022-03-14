import 'dart:convert';

import 'package:alfred_taxi_client/app/common/app_urls.dart';
import 'package:alfred_taxi_client/app/data/models/echange_model.dart';
import 'package:alfred_taxi_client/app/data/models/partage_model.dart';
import 'package:http/http.dart' as http;

class EchangeProvider {
  Future<List<Echange>> getEchange({
    required cmde_id,
  }) async {
    var url = APPURL.BASE_URL + APPURL.GET_CLIENT_LIRE + "cmde_id=$cmde_id";

    var _list = <Echange>[];

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) _list = parseEchanges(response.body);

    if (_list.isNotEmpty) {
      return _list;
    } else {
      return [];
    }
  }

  Future<Partage> postEchange({
    required cmde_id,
    required driver_id,
    required message,
  }) async {
    var url = APPURL.BASE_URL +
        APPURL.POST_CLIENT_ECRIRE +
        "driver_id=$driver_id&cmde_id=$cmde_id&message=$message";

    var _res = Partage();
    final response = await http.post(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) _res = parseResultats(response.body);

    return _res;
  }

  Partage parseResultats(responseBody) {
    final parsed = json.decode(responseBody);

    return Partage.fromJson(parsed);
  }

  List<Echange> parseEchanges(responseBody) {
    final parsed =
        json.decode(responseBody)["objet"].cast<Map<String, dynamic>>();

    return parsed.map<Echange>((json) => Echange.fromJson(json)).toList();
  }
}
