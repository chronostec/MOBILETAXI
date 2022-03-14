import 'dart:convert';
import 'package:alfred_taxi_client/app/common/app_urls.dart';
import 'package:alfred_taxi_client/app/data/models/recherche_evaluation_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RechercheEvaluationProvider extends GetConnect {
  Future<List<RechercheEvaluation>> postRechercheEvaluation({
    required client_id,
    required dest_libelle,
    required longitude,
    required latitude,
    required duree,
    required distance,
    required dest_longitude,
    required dest_latitude,
    required origine_libelle,
  }) async {
    var url = APPURL.BASE_URL +
        APPURL.RECHERCHE_EVALUATION_URL +
        "client_id=$client_id&dest_libelle=$dest_libelle&longitude=$longitude&latitude=$latitude&duree=$duree&distance=$distance&dest_longitude=$dest_longitude&dest_latitude=$dest_latitude&origine_libelle=$origine_libelle";

    var _list = <RechercheEvaluation>[];

    final response = await http.post(Uri.parse(url));
    print("EVALUATION: ${response.body}");
    if (response.statusCode == 200) {
      _list = parseRechercheEvaluations(response.body);
    }
    return _list;
  }

  List<RechercheEvaluation> parseRechercheEvaluations(responseBody) {
    final parsed =
        json.decode(responseBody)["objet"].cast<Map<String, dynamic>>();

    return parsed
        .map<RechercheEvaluation>((json) => RechercheEvaluation.fromJson(json))
        .toList();
  }
}
