import 'dart:convert';

import 'package:alfred_taxi_client/app/common/app_urls.dart';
import 'package:alfred_taxi_client/app/data/models/commande_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CommandeProvider {
  Future<String> postCommande(
      {required int proposition_id,
      required int client_id,
      required int montant_negocie}) async {
    var url = APPURL.BASE_URL +
        APPURL.ENREGISTRER_COMMANDE_URL +
        "proposition_id=$proposition_id&client_id=$client_id&montant_negocie=$montant_negocie";
    var _res = "";

    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      if (json.decode(response.body)["message"] == "succes") {
        _res = json.decode(response.body)["message"];
      }
    }

    return _res;
  }

  Commande parseCommandes(responseBody) {
    final parsed = json.decode(responseBody);

    return Commande.fromJson(parsed);
  }

  Future<List<Commande>> getCommande({
    required proposition_id_saisir,
    required commande_id,
  }) async {
    var url = APPURL.BASE_URL +
        APPURL.RECUP_DRIVER_URL +
        "proposition_id_saisir=$proposition_id_saisir&commande_id=$commande_id";
    print(url);

    var _list = <Commande>[];

    final response = await http.get(Uri.parse(url));
    print("MA COMMANDE ${response.body}");

    if (response.statusCode == 200) {
      if (json.decode(response.body)["message"] == "succes") {
        _list = parseDrivers(response.body);
      }
    }

    return _list;
  }

  List<Commande> parseDrivers(responseBody) {
    final parsed =
        json.decode(responseBody)["objet"].cast<Map<String, dynamic>>();

    return parsed.map<Commande>((json) => Commande.fromJson(json)).toList();
  }
}
