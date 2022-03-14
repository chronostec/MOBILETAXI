import 'package:fredy_proprio/app/data/models/dashboard_resumer_model.dart';
import 'package:fredy_proprio/app/data/models/financeresume_model.dart';
import 'package:fredy_proprio/app/data/models/resume_model.dart';
import 'package:fredy_proprio/app/utils/app_urls.dart';
import 'package:http/http.dart' as http;

import 'decoder_retour.dart';

class FinanceProvider {
  /// EXECUTER REQUETE GET
  Future<Financeresume> getListerFinanceResumers({
    required int proprio_id,
    required String date_debut,
    required String date_fin,
  }) async {
    var url = APPURL.BASE_URL +
        APPURL.GET_FINANCE_RESUME +
        "proprio_id=$proprio_id&date_debut=$date_debut&date_fin=$date_fin";
    final response = await http.get(Uri.parse(url));
    return parsFinanceresume(response.body);
  }

  /// EXECUTER REQUETE GET
  // Future<Resume> getRapportJournee(
  //     {required int proprio_id, required String date_jour}) async {
  //   var url = APPURL.BASE_URL +
  //       APPURL.GET_RAPPORT_JOURNEE +
  //       "proprio_id=$proprio_id&date_jour=$date_jour";
  //   final response = await http.get(Uri.parse(url));
  //   return parseResumer(response.body);
  // }
}
