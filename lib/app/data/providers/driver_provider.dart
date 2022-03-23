import 'dart:convert';
import 'dart:io';

import 'package:fredy_proprio/app/data/models/driver_model.dart';
import 'package:fredy_proprio/app/data/models/retour_model.dart';
import 'package:fredy_proprio/app/data/models/vehicule_model.dart';
import 'package:fredy_proprio/app/data/providers/decoder_retour.dart';
import 'package:fredy_proprio/app/utils/app_urls.dart';
import 'package:http/http.dart' as http;

import '../models/resume_model.dart';

class DriverProvider {
  /// EXECUTER REQUETE GET
  Future<List<Driver>> getListerDrivers({required int proprio_id}) async {
    var url =
        APPURL.BASE_URL + APPURL.GET_LISTER_DRIVERS + "proprio_id=$proprio_id";
    final response = await http.get(Uri.parse(url));
    return parseDrivers(response.body);
  }

  /// EXECUTER REQUETE GET
  Future<List<Resume>> getListerHistoriqueDrivers({
    required int proprio_id,
    required int driver_id,
    required String date_debut,
    required String date_fin,
  }) async {
    var url = APPURL.BASE_URL +
        APPURL.GET_LISTER_HISTORIQUE_DRIVERS +
        "proprio_id=$proprio_id&date_debut=$date_debut&date_fin=$date_fin&driver_id=$driver_id";
    final response = await http.get(Uri.parse(url));
    return parseHistoriqueDrivers(response.body);
  }

  /// EXECUTER REQUETE GET
  Future<List<VehiculeLibre>> getListerVehiculeLibre(
      {required proprio_id}) async {
    var url =
        APPURL.BASE_URL + APPURL.GET_VEHICULE_LIBRE + "proprio_id=$proprio_id";
    final response = await http.get(Uri.parse(url));
    return parseVehiculeLibre(response.body);
  }

  /// EXECUTER REQUETE PUT
  Future<Retour> putAttribuerVehicule(
      {required int vehicule_id, required int driver_id}) async {
    var url = APPURL.BASE_URL +
        APPURL.PUT_ATTRIBUER_VEHICULE +
        "chauffeur_id=$driver_id&vehicule_id=$vehicule_id";
    final response = await http.put(Uri.parse(url));
    return parseRetour(response.body);
  }

  /// EXECUTER REQUETE PUT
  Future<Retour> putDriver({
    required int id,
    required int proprio_id,
    required String nom,
    required String prenom,
    required String numero_permis,
    required String telephone,
    required String image_permis,
  }) async {
    var url = APPURL.BASE_URL +
        APPURL.PUT_DRIVER +
        "id=$id&nom=$nom&prenom=$prenom&numero_permis=$numero_permis&telephone=$telephone&proprio_id=$proprio_id&image_permis=$image_permis";
    final response = await http.put(Uri.parse(url));
    return parseRetour(response.body);
  }

  /// EXECUTER REQUETE POST
  Future<Retour> postDriver({
    required int proprio_id,
    required String nom,
    required String prenom,
    required String numero_permis,
    required String telephone,
    required String image_permis,
    image,
  }) async {
    var url = APPURL.BASE_URL +
        APPURL.POST_DRIVER +
        "nom=$nom&prenom=$prenom&numero_permis=$numero_permis&telephone=$telephone&proprio_id=$proprio_id&image_permis=$image_permis";
    final response = await http.post(Uri.parse(url));

    return parseRetour(response.body);
  }
}
