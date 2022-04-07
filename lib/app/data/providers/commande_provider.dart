import 'dart:convert';

import 'package:alfred_taxi_driver/app/data/models/partage_model.dart';
import 'package:alfred_taxi_driver/app/utils/app_urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/commandes_model.dart';

class CommandeProvider extends GetConnect {
  Future<Commandes> getCommande({
    required driver_id,
  }) async {
    var url = APPURL.BASE_URL + APPURL.GET_LISTER_CMDE + "driver_id=$driver_id";
    final response = await http.get(Uri.parse(url));
    print("LISTE COMMANDE ${response.body}");
    if (response.statusCode == 200) {
      return Commandes.fromJson(json.decode(response.body));
    }
    return Commandes();
  }

  Commandes parseCommandes(responseBody) {
    final parsed = json.decode(responseBody);
    return Commandes.fromJson(parsed);

    // final parsed =
    //     json.decode(responseBody)["objet"].cast<Map<String, dynamic>>();
    // var res = parsed.map<Commande>((json) => Commande.fromJson(json)).toList();

    // return res;
  }

  //////////////////////////////
  Future<Commandes> getCommandeDetail(
      {required cmde_id, required driver_id}) async {
    var url = APPURL.BASE_URL +
        APPURL.GET_DETAIL_CMDE +
        "cmde_id=$cmde_id&&driver_id=$driver_id";

    var _list = Commandes();

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      _list = Commandes.fromJson(json.decode(response.body));
    }
    if (_list.bSuccess == true) {
      return _list;
    } else {
      return Commandes(
          bSuccess: true,
          message: "succes",
          commande: [],
          compte: [Compte(solde: 0, statusCompte: 0)]);
    }
  }

  Future<Commandes> getCommandeDetailAcceptee({
    required driver_id,
    required cmde_id,
  }) async {
    var url = APPURL.BASE_URL +
        APPURL.GET_DETAIL_CMDE_ACCEPTEE +
        "driver_id=$driver_id&cmde_id=$cmde_id";

    var _list = Commandes();

    final response = await http.get(Uri.parse(url));
    // print(response.body);
    if (response.statusCode == 200) {
      _list = parseCommandes(response.body);
    }
    if (_list.bSuccess == true) {
      return _list;
    } else {
      return Commandes(
          bSuccess: true,
          message: "succes",
          commande: [],
          compte: [Compte(solde: 0, statusCompte: 0)]);
    }
  }

  Future<Resultat> putRefuserCommande({
    required commande_id_saisir,
    required chauffeur_id_saisir,
  }) async {
    var url = APPURL.BASE_URL +
        APPURL.PUT_REFUSER_CMDE +
        "commande_id_saisir=$commande_id_saisir&chauffeur_id_saisir=$chauffeur_id_saisir";

    var _res = Resultat();
    final response = await http.put(Uri.parse(url));
    if (response.statusCode == 200) _res = parseResultats(response.body);
    return _res;
  }

  Future<Resultat> putManagerCommande({
    required status,
    required driver_id,
    required cmde_id,
  }) async {
    var url = APPURL.BASE_URL +
        APPURL.PUT_MANAGER_CMDE +
        "driver_id=$driver_id&cmde_id=$cmde_id&status=$status";

    var _res = Resultat();
    final response = await http.put(Uri.parse(url));
    // print(response.body);
    if (response.statusCode == 200) _res = parseResultats(response.body);
    return _res;
  }

  Resultat parseResultats(responseBody) {
    final parsed = json.decode(responseBody);
    return Resultat.fromJson(parsed);
  }

  // List<Commande> parseCommande(responseBody) {
  //   final parsed =
  //       json.decode(responseBody)["objet"].cast<Map<String, dynamic>>();
  //   return parsed.map<Commande>((json) => Commande.fromJson(json)).toList();
  // }
}
