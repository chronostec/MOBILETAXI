import 'dart:convert';

import 'package:alfred_taxi_driver/app/data/models/driver_model.dart';
import 'package:alfred_taxi_driver/app/utils/app_urls.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/resultat_model.dart';

class DriverProvider extends GetConnect {
  Future<Driver> getDriver({
    required telephone,
    required password,
  }) async {
    var url = APPURL.BASE_URL +
        APPURL.GET_DRIVER_INFO +
        "password=$password&telephone=$telephone";

    var _res = Driver();

    final response = await http.get(Uri.parse(url));

    if (json.decode(response.body)["message"] == "succes") {
      // print("***************SUCCES***************");
      _res = parseDriver(response.body);
    } else {
      // print("***************ERREUR DE DONNEES***************");
      print(response.body);
      _res = Driver(id: 0);
    }

    return _res;
  }

  Future putDriverPwd(
      {required driver_telephone,
      required ancien_password,
      required new_password}) async {
    var _res = Resultat(bSuccess: false, message: "echec");
    var url = APPURL.BASE_URL +
        APPURL.PUT_DRIVER_PWD +
        "driver_telephone=$driver_telephone&ancien_password=$new_password&new_password=$new_password";
    var _response = await http.put(Uri.parse(url));
    if (_response.statusCode == 200) {
      _res = parseResultats(_response.body);
    }
    return _res;
  }

  Future putDriverPosition({
    required vehicule_id,
    required latitude,
    required longitude,
  }) async {
    var url = APPURL.BASE_URL +
        APPURL.PUT_DRIVER_GPS +
        "vehicule_id=$vehicule_id&longitude=$longitude&latitude=$latitude";
    await http.put(Uri.parse(url));
  }

  ///update driver position with remaining time and distance
  Future updateDriverPositionRemaingDistMatrix({
    required id_commande,
    required gps_latitude,
    required gps_longitude,
    required distance_en_metre,
    required duree_en_seconde,
  }) async {
    print("POSITION GPS EN COURS DE COURSE");
    var url = APPURL.BASE_URL +
        APPURL.PUT_DRIVER_POSITION +
        "id_commande=$id_commande&gps_longitude=$gps_longitude&gps_latitude=$gps_latitude&distance_en_metre=$distance_en_metre&duree_en_seconde=$duree_en_seconde";
    await http.post(Uri.parse(url));
  }

  Driver parseDriver(responseBody) {
    final parsed =
        json.decode(responseBody)["objet"].cast<Map<String, dynamic>>();
    List<Driver> result =
        parsed.map<Driver>((json) => Driver.fromJson(json)).toList();
    if (result.isNotEmpty) {
      return result[0];
    } else {
      return Driver();
    }
  }

  Resultat parseResultats(responseBody) {
    final parsed = json.decode(responseBody);
    return Resultat.fromJson(parsed);
  }
}
