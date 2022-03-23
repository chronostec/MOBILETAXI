import 'package:flutter/material.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/data/models/categorie_model.dart';
import 'package:fredy_proprio/app/data/models/retour_model.dart';
import 'package:fredy_proprio/app/data/models/vehicule_historique_course_model.dart';
import 'package:fredy_proprio/app/data/models/vehicule_model.dart';
import 'package:fredy_proprio/app/data/models/vehicule_resume_model.dart';
import 'package:fredy_proprio/app/data/providers/providers.dart';
import 'package:get/get.dart';

class VehiculeController extends GetxController {
  TextEditingController searchTextTC = TextEditingController();

  TextEditingController immatTC = TextEditingController();
  TextEditingController marqueTC = TextEditingController();
  TextEditingController modelTC = TextEditingController();
  TextEditingController couleurTC = TextEditingController();
  TextEditingController anneeTC = TextEditingController();
  TextEditingController categorieTC = TextEditingController();
  RxInt categorieID = 0.obs;

  RxBool isEditing = false.obs;
  RxBool istLoading = false.obs;
  RxBool isFetching = false.obs;

  RxInt vehiculeID = 0.obs;
  Rx<DateTime> vehiculeAnnee = DateTime.now().obs;
  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> endedDate = DateTime.now().obs;
  Rx<DateTime> vehiculeDate = DateTime.now().obs;
  RxString dateJour = DateTime.now().toString().substring(0, 10).obs;

  final List<String> couleurList = <String>[
    "ORANGE",
    "BLANCHE",
    "VERTE",
    "BLEUE",
    "ROUGE",
    "NOIRE",
    "JAUNE",
    "GRISE",
    "VIOLETTE",
  ];

  RxList<Categorie> categoriesList = <Categorie>[].obs;
  Rx<Vehicule> vehicule = Vehicule().obs;
  Rx<VehiculeResume> vehiculeResume = VehiculeResume().obs;
  RxList<Vehicule> vehiculesList = <Vehicule>[].obs;
  RxList<Vehicule> tempVehiculeList = <Vehicule>[].obs;
  RxList<VehiculeHistoriqueCourse> vehiculeHistoriqueList =
      <VehiculeHistoriqueCourse>[].obs;

  @override
  void onInit() {
    listerVehicules();
    super.onInit();
  }

  @override
  void onReady() {
    listerVehicules();
    listerCategories();
    super.onReady();
  }

  @override
  void onClose() {}

  ///`CLEAR TEXT CONTROLLERS`
  clearTextFields() {
    immatTC.text = "";
    marqueTC.text = "";
    modelTC.text = "";
    // couleurTC.text = "";
    // anneeTC.text = "";
  }

  ///`LISTER CATEGORIES`
  Future listerCategories() async {
    categoriesList.value = await provCategorie.getCategorie();
  }

  ///`RESUME VEHICULE`
  Future<VehiculeResume> getVehiculeResume(vehicule_id) async {
    String _jour = DateTime.now().toString().substring(0, 10);
    istLoading.value = true;
    var _res = await provVehicule.getVehiculeResume(
        proprio_id: helper.proprioInfo.value.id ?? 0,
        vehicule_id: vehicule_id ?? 0,
        date_jour: _jour);
    if (_res.isNotEmpty) {
      vehiculeResume.value = _res.first;
    }
    istLoading.value = false;
    return vehiculeResume.value;
  }

  ///`LISTER VEHICULES`

  Future<List<Vehicule>> listerVehicules() async {
    istLoading.value = true;
    vehiculesList.value = await provVehicule.getListerVehicule(
        proprio_id: helper.proprioInfo.value.id ?? 0);
    tempVehiculeList.value = vehiculesList.reversed.toList();
    istLoading.value = false;
    return vehiculesList;
  }

  ///`LISTER HISTORIQUE D'UN VEHICULE`
  Future<List<VehiculeHistoriqueCourse>> listerHistoriqueCoursesVehicule(
      int vehicule_id) async {
    istLoading.value = true;
    vehiculeHistoriqueList.value =
        await provVehicule.getListerVehiculeHistoriqueCourse(
            proprio_id: helper.proprioInfo.value.id ?? 0,
            vehicule_id: vehicule_id,
            date_debut: startDate.value.toString().substring(0, 10),
            date_fin: endedDate.value.toString().substring(0, 10));
    vehiculeHistoriqueList.value = vehiculeHistoriqueList.reversed.toList();
    istLoading.value = false;
    return vehiculeHistoriqueList;
  }

  ///`ENREGISTRER VEHICULE`
  Future<Retour> addVehicule() async {
    istLoading.value = true;
    Retour _retour = await provVehicule.postVehicule(
        proprio_id: helper.proprioInfo.value.id ?? 0,
        immatriculation: immatTC.text.trim().toUpperCase(),
        categorie_id: categorieID.value,
        marque: marqueTC.text.trim().toUpperCase(),
        modele: modelTC.text.trim().toUpperCase(),
        couleur: couleurTC.text.trim().toUpperCase(),
        annee: vehiculeAnnee.value.toString().substring(0, 10));
    listerVehicules();
    // istLoading.value = false;

    return _retour;
  }

  ///`METTRE A JOUR VEHICULE`
  Future<Retour> updateVehicule() async {
    istLoading.value = true;
    Retour _retour = await provVehicule.putVehicule(
      id: vehicule.value.id!.toInt(),
      proprio_id: helper.proprioInfo.value.id!.toInt(),
      immatriculation: immatTC.text.trim().toUpperCase(),
      categorie_id: categorieID.value,
      marque: marqueTC.text.trim().toUpperCase(),
      modele: modelTC.text.trim().toUpperCase(),
      couleur: couleurTC.text.trim().toUpperCase(),
      statut: 1,
      annee: vehiculeAnnee.value.toString().substring(0, 10),
    );
    istLoading.value = false;
    listerVehicules();
    return _retour;
  }
}
