import 'dart:convert';

import 'package:fredy_proprio/app/data/models/retour_model.dart';
import 'package:fredy_proprio/app/data/models/vehicule_historique_course_model.dart';
import 'package:fredy_proprio/app/data/models/vehicule_model.dart';
import 'package:fredy_proprio/app/data/models/vehicule_resume_model.dart';
import 'package:fredy_proprio/app/utils/app_urls.dart';
import 'package:http/http.dart' as http;

import 'decoder_retour.dart';

class VehiculeProvider {
  /// EXECUTER REQUETE GET
  Future<List<Vehicule>> getListerVehicule({required int proprio_id}) async {
    var url =
        APPURL.BASE_URL + APPURL.GET_LISTER_VEHICULE + "proprio_id=$proprio_id";
    final response = await http.get(Uri.parse(url));

    return parseVehicules(response.body);
  }

  /// EXECUTER REQUETE GET
  Future<List<VehiculeResume>> getVehiculeResume({
    required int proprio_id,
    required int vehicule_id,
    required String date_jour,
  }) async {
    var url = APPURL.BASE_URL +
        APPURL.GET_VEHICULE_RESUME +
        "proprio_id=$proprio_id&vehicule_id=$vehicule_id&date_jour=$date_jour";
    final response = await http.get(Uri.parse(url));
    return parseVehiculeresume(response.body);
  }

  /// EXECUTER REQUETE GET
  Future<List<VehiculeHistoriqueCourse>> getListerVehiculeHistoriqueCourse({
    required int proprio_id,
    required int vehicule_id,
    required String date_debut,
    required String date_fin,
  }) async {
    var url = APPURL.BASE_URL +
        APPURL.GET_VEHICULE_HISTORIQUE_COURSE +
        "proprio_id=$proprio_id&date_debut=$date_debut&date_fin=$date_fin&vehicule_id=$vehicule_id";
    final response = await http.get(Uri.parse(url));
    return parseRetourLVHC(response.body);
  }

  /// EXECUTER REQUETE PUT
  Future<Retour> putVehicule({
    required int id,
    required int proprio_id,
    required int categorie_id,
    required String immatriculation,
    required String marque,
    required String modele,
    required String couleur,
    required String annee,
    required int statut,
  }) async {
    var url = APPURL.BASE_URL +
        APPURL.PUT_VEHICULE +
        "id=$id&proprio_id=$proprio_id&id=$id&immatriculation=$immatriculation&marque=$marque&modele=$modele&couleur=$couleur&annee=$annee&statut=$statut&categorie_id=$categorie_id";

    final response = await http.put(Uri.parse(url));
    return parseRetour(response.body);
  }

  /// EXECUTER REQUETE PUT
  Future<Retour> postVehicule({
    required int proprio_id,
    required int categorie_id,
    required String immatriculation,
    required String marque,
    required String modele,
    required String couleur,
    required String annee,
  }) async {
    var url = APPURL.BASE_URL +
        APPURL.POST_VEHICULE +
        "proprio_id=$proprio_id&immatriculation=$immatriculation&marque=$marque&modele=$modele&couleur=$couleur&annee=$annee&categorie_id=$categorie_id";

    final response = await http.post(Uri.parse(url));
    return parseRetour(response.body);
  }
}
