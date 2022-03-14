import 'dart:convert';
import 'package:alfred_taxi_client/app/common/app_urls.dart';
import 'package:alfred_taxi_client/app/data/models/vehicule_libre_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VehiculeLibreProvider extends GetConnect {
  Future<List<VehiculeLibre>> getVehiculeLibre({
    required longitude,
    required latitude,
  }) async {
    var url = APPURL.BASE_URL +
        APPURL.GET_VEHICULE_PROXIMITE_URL +
        "longitude=$longitude&latitude=$latitude";
    var _list = <VehiculeLibre>[];

    final response = await http.get(Uri.parse(url));
    print("VEHICULE A PROXIM >>=====>>> ${response.body}");
    if (response.statusCode == 200) {
      _list = parseVehiculeLibres(response.body);
    }
    return _list;
  }

  List<VehiculeLibre> parseVehiculeLibres(responseBody) {
    final parsed =
        json.decode(responseBody)["objet"].cast<Map<String, dynamic>>();

    return parsed
        .map<VehiculeLibre>((json) => VehiculeLibre.fromJson(json))
        .toList();
  }
}
