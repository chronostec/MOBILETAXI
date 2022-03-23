import 'dart:convert';

import 'package:fredy_proprio/app/data/models/dashboard_resumer_model.dart';
import 'package:fredy_proprio/app/data/models/financeresume_model.dart';
import 'package:fredy_proprio/app/data/models/proprio_model.dart';
import 'package:fredy_proprio/app/data/models/resume_model.dart';
import 'package:fredy_proprio/app/data/models/retour_model.dart';
import 'package:fredy_proprio/app/data/models/vehicule_historique_course_model.dart';
import 'package:fredy_proprio/app/data/models/vehicule_resume_model.dart';
import 'package:fredy_proprio/app/utils/app_urls.dart';

import '../models/categorie_model.dart';
import '../models/driver_model.dart';
import '../models/message_support_model.dart';
import '../models/objet_message_model.dart';
import '../models/vehicule_model.dart';

Retour parseRetour(responseBody) {
  print(responseBody);
  final parsed = json.decode(responseBody);
  return Retour.fromJson(parsed);
}

List<VehiculeHistoriqueCourse> parseRetourLVHC(responseBody) {
  // final parsed = json.decode(responseBody);
  final parsed =
      json.decode(responseBody)["objet"].cast<Map<String, dynamic>>();
  return parsed
      .map<VehiculeHistoriqueCourse>(
          (json) => VehiculeHistoriqueCourse.fromJson(json))
      .toList();
  // return VehiculeHistoriqueCourse.fromJson(parsed);
}

List<VehiculeResume> parseVehiculeresume(responseBody) {
  final parsed =
      json.decode(responseBody)["objet"].cast<Map<String, dynamic>>();
  return parsed
      .map<VehiculeResume>((json) => VehiculeResume.fromJson(json))
      .toList();
}

/// DECODER LES DONNEES
DashboardResumer parseDashboardResumer(responseBody) {
  final parsed =
      json.decode(responseBody)["objet"].cast<Map<String, dynamic>>();
  List<DashboardResumer> res = parsed
      .map<DashboardResumer>((json) => DashboardResumer.fromJson(json))
      .toList();

  if (res.isNotEmpty) {
    return res.first;
  } else {
    return DashboardResumer();
  }
}

Financeresume parsFinanceresume(responseBody) {
  return Financeresume.fromJson(json.decode(responseBody));
}

// Resume parseResumer(responseBody) {
//   final parsed =
//       json.decode(responseBody)["objet"].cast<Map<String, dynamic>>();

//   return parsed
//       .map<Financeresume>((json) => Financeresume.fromJson(json))
//       .toList();
// }

Proprio parseProprio(responseBody) {
  final parsed =
      json.decode(responseBody)["objet"].cast<Map<String, dynamic>>();
  List<Proprio> res =
      parsed.map<Proprio>((json) => Proprio.fromJson(json)).toList();
  print(res);
  if (res.isNotEmpty) {
    return res.first;
  } else {
    return Proprio(id: 0);
  }
}

/// DECODER LES DONNEES
List<Vehicule> parseVehicules(responseBody) {
  final parsed =
      json.decode(responseBody)["objet"].cast<Map<String, dynamic>>();
  return parsed.map<Vehicule>((json) => Vehicule.fromJson(json)).toList();
}

/// DECODER LES DONNEES
List<Categorie> parseCategories(responseBody) {
  final parsed =
      json.decode(responseBody)["objet"].cast<Map<String, dynamic>>();
  return parsed.map<Categorie>((json) => Categorie.fromJson(json)).toList();
}

/// DECODER LES DONNEES
List<Driver> parseDrivers(responseBody) {
  final parsed =
      json.decode(responseBody)["objet"].cast<Map<String, dynamic>>();
  return parsed.map<Driver>((json) => Driver.fromJson(json)).toList();
}

/// DECODER LES DONNEES
List<Resume> parseHistoriqueDrivers(responseBody) {
  final parsed =
      json.decode(responseBody)["objet"].cast<Map<String, dynamic>>();
  return parsed.map<Resume>((json) => Resume.fromJson(json)).toList();
}

/// DECODER LES DONNEES
List<VehiculeLibre> parseVehiculeLibre(responseBody) {
  final parsed =
      json.decode(responseBody)["objet"].cast<Map<String, dynamic>>();
  return parsed
      .map<VehiculeLibre>((json) => VehiculeLibre.fromJson(json))
      .toList();
}

MessageSupport parseMessageSupport(responseBody) {
  final parsed = json.decode(responseBody);
  return MessageSupport.fromJson(parsed);
}

List<ObjetMessage> parseObjetMessages(responseBody) {
  final parsed =
      json.decode(responseBody)["objet"].cast<Map<String, dynamic>>();
  return parsed
      .map<ObjetMessage>((json) => ObjetMessage.fromJson(json))
      .toList();
}
