import 'package:fredy_proprio/app/data/models/proprio_model.dart';
import 'package:fredy_proprio/app/data/models/retour_model.dart';
import 'package:fredy_proprio/app/data/providers/decoder_retour.dart';
import 'package:fredy_proprio/app/utils/app_urls.dart';
import 'package:http/http.dart' as http;

class ProprioProvider {
  /// EXECUTER REQUETE GET
  Future<Proprio> getConnexion({
    required String telephone,
    required String password,
  }) async {
    var url = APPURL.BASE_URL +
        APPURL.GET_CONNEXION +
        "password=$password&telephone=$telephone";
    final response = await http.get(Uri.parse(url));
    return parseProprio(response.body);
  }

  /// EXECUTER REQUETE GET
  Future<Proprio> getOldPassword({
    required String telephone,
    required String password,
  }) async {
    var url = APPURL.BASE_URL +
        APPURL.GET_OLD_PASSWORD +
        "telephone=$telephone&password=$password";
    final response = await http.get(Uri.parse(url));
    return parseProprio(response.body);
  }

  /// EXECUTER REQUETE GET
  Future<Proprio> getResetPassword({required String telephone}) async {
    var url =
        APPURL.BASE_URL + APPURL.GET_OLD_PASSWORD + "telephone=$telephone";
    final response = await http.get(Uri.parse(url));
    return parseProprio(response.body); // return id if true, else 0
  }

  /// EXECUTER REQUETE PUT
  Future<Retour> putNewPassword({
    required String telephone,
    required String new_password,
  }) async {
    var url = APPURL.BASE_URL +
        APPURL.PUT_NEW_PASSWORD +
        "telephone=$telephone&new_password=$new_password";
    final response = await http.put(Uri.parse(url));
    return parseRetour(response.body);
  }

  /// EXECUTER REQUETE POST
  Future<Retour> postInscription({
    required String nom,
    required String prenom,
    required String telephone,
    required String email,
    required String password,
  }) async {
    var url = APPURL.BASE_URL +
        APPURL.POST_INSCRIPTION +
        "nom=$nom&prenom=$prenom&telephone=$telephone&email=$email&password=$password";
    final response = await http.post(Uri.parse(url));

    return parseRetour(response.body);
  }
}
