import 'dart:convert';

import 'package:alfred_taxi_client/app/common/app_urls.dart';
import 'package:alfred_taxi_client/app/data/models/partage_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PartageProvider extends GetConnect {
  Future<Partage> postPartage(
      {required numeropartage, required commande_id}) async {
    var url = APPURL.BASE_URL +
        APPURL.PARTAGE_URL +
        "numeropartage=$numeropartage&commande_id=$commande_id";
    var _res = Partage(bSuccess: false, message: 'succes');

    final response = await http.post(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      _res = parsePartages(response.body);
    }
    return _res;
  }

  Partage parsePartages(responseBody) {
    final parsed = json.decode(responseBody);

    return Partage.fromJson(parsed);
  }
}
