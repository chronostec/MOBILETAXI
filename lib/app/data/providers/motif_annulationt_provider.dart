import 'dart:convert';

import 'package:alfred_taxi_client/app/common/app_urls.dart';
import 'package:alfred_taxi_client/app/data/models/motif_annulation_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MotifAnnulationtProvider extends GetConnect {
  Future<List<MotifAnnulation>> getMotifAnnulationt() async {
    var url = APPURL.BASE_URL + APPURL.MOTIF_ANNULATION_URL;

    var _list = <MotifAnnulation>[];

    final response = await http.get(Uri.parse(url));
    print("MOTIFS: ${response.body}");
    if (response.statusCode == 200) {
      _list = parseMotifAnnulations(response.body);
    }

    return _list;
  }

  List<MotifAnnulation> parseMotifAnnulations(responseBody) {
    final parsed =
        json.decode(responseBody)["objet"].cast<Map<String, dynamic>>();

    return parsed
        .map<MotifAnnulation>((json) => MotifAnnulation.fromJson(json))
        .toList();
  }
}
