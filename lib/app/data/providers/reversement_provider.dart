import 'dart:convert';

import 'package:fredy_proprio/app/utils/app_urls.dart';
import 'package:http/http.dart' as http;

import '../models/reversement_model.dart';

class ReversementProvider {
  /// EXECUTER REQUETE GET
  Future<Reversement> postGenererLienPaiement(
      {required int proprio_id, required String montant}) async {
    var url =
        APPURL.BASE_URL + APPURL.POST_REVERSEMENT + "proprio_id=44&montant=10";
    final response = await http.post(Uri.parse(url));
    return parsReversement(response.body);
  }

  Reversement parsReversement(responseBody) {
    return Reversement.fromJson(json.decode(responseBody));
  }
}
