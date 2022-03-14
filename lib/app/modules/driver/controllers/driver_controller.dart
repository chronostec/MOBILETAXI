import 'package:flutter/widgets.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/data/models/driver_model.dart';
import 'package:fredy_proprio/app/data/models/resume_model.dart';
import 'package:fredy_proprio/app/data/models/retour_model.dart';
import 'package:fredy_proprio/app/data/models/vehicule_model.dart';
import 'package:fredy_proprio/app/data/models/vehicule_resume_model.dart';
import 'package:fredy_proprio/app/data/providers/providers.dart';
import 'package:get/get.dart';

class DriverController extends GetxController {
  RxInt segmentedControlGroupValue = 0.obs;
  RxInt activeCurrentStep = 0.obs;
  RxInt? chosedVehicleIndex = 0.obs;
  RxString? chosedVehicleName = "".obs;

  TextEditingController searchTextTC = TextEditingController();
  TextEditingController vehiculeTC = TextEditingController();
  TextEditingController nomTC = TextEditingController();
  TextEditingController prenomTC = TextEditingController();
  TextEditingController permisTC = TextEditingController();
  TextEditingController telephoneTC = TextEditingController();
  TextEditingController photoTC = TextEditingController();

  TextEditingController startTC = TextEditingController();
  TextEditingController endTC = TextEditingController();

  RxInt vehiculeID = 0.obs;
  RxInt driverID = 0.obs;
  RxString imagepath = "".obs;

  RxBool isEditing = false.obs;
  RxBool istLoading = false.obs;
  RxBool isFetching = false.obs;

  final vehicleSelected = Vehicule(
          id: 0,
          annee: "",
          couleur: "",
          categorie: "",
          immatriculation: "",
          marque: "",
          modele: "")
      .obs;

  final vehiclelibre = VehiculeLibre().obs;

  Rx<Driver> driver = Driver().obs;
  RxList<Driver> driversList = <Driver>[].obs;
  RxList<Driver> tempDriverList = <Driver>[].obs;
  RxList<VehiculeLibre> vehiculelibreList = <VehiculeLibre>[].obs;
  RxList<VehiculeLibre> tempVehiculelibreList = <VehiculeLibre>[].obs;
  Rx<VehiculeResume> vehiculeResume = VehiculeResume().obs;

  late FocusNode myFocusNode;
  var tooltipBehavior;

  DateTime datejour = DateTime.now();
  final isready = false.obs;

  final RxBool isLoading = false.obs;
  RxList<Resume> historiqueDriverList = <Resume>[].obs;
  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> endedDate = DateTime.now().obs;
  RxString dateJour = DateTime.now().toString().substring(0, 10).obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    ctlVehicule.listerVehicules();
    ctlDriver.ListerDrivers();
    super.onReady();
  }

  @override
  void onClose() {}

  ///`CLEAR TEXT CONTROLLERS`
  clearTextFields() {
    nomTC.text = "";
    prenomTC.text = "";
    permisTC.text = "";
    telephoneTC.text = "";
    // couleurTC.text = "";
    // anneeTC.text = "";
  }

  ///`RESUME VEHICULE`
  Future<VehiculeResume> getVehiculeResume(vehicule_id) async {
    String _jour = DateTime.now().toString().substring(0, 10);
    istLoading.value = true;
    vehiculeResume.value = await provVehicule.getVehiculeResume(
        proprio_id: helper.proprioInfo.value.id ?? 0,
        vehicule_id: vehicule_id,
        date_jour: _jour);
    istLoading.value = false;
    return vehiculeResume.value;
  }

  ///`VEHICULES LIBRES`
  Future<List<VehiculeLibre>> getVehiculeLibre() async {
    istLoading.value = true;
    vehiculelibreList.value = await provDriver.getListerVehiculeLibre();
    tempVehiculelibreList.value = vehiculelibreList.reversed.toList();
    istLoading.value = false;
    return vehiculelibreList.value;
  }

  ///`AJOUTER VEHICULE`
  Future<Retour> postDriver() async {
    String _jour = DateTime.now().toString().substring(0, 10);
    istLoading.value = true;
    Retour _res = await provDriver.postDriver(
      proprio_id: helper.proprioInfo.value.id ?? 0,
      nom: nomTC.text.trim().toUpperCase(),
      prenom: prenomTC.text.trim().toUpperCase(),
      numero_permis: permisTC.text.trim().toUpperCase(),
      telephone: telephoneTC.text,
      image_permis: "RIEN",
    );
    clearTextFields();
    ctlVehicule.listerVehicules();
    ctlDriver.ListerDrivers();
    istLoading.value = false;
    return _res;
  }

  ///`UPDATE VEHICULE`
  Future<Retour> putDriver() async {
    String _jour = DateTime.now().toString().substring(0, 10);
    istLoading.value = true;
    Retour _res = await provDriver.putDriver(
      id: driver.value.id ?? 0,
      proprio_id: helper.proprioInfo.value.id ?? 0,
      nom: nomTC.text.trim().toUpperCase(),
      prenom: prenomTC.text.trim().toUpperCase(),
      numero_permis: permisTC.text.trim().toUpperCase(),
      telephone: telephoneTC.text,
      image_permis: "RIEN",
    );
    ctlVehicule.listerVehicules();
    ctlDriver.ListerDrivers();
    istLoading.value = false;
    return _res;
  }

  ///`ATTRIBUER VEHICULE`
  Future<Retour> attribuerVehicule() async {
    istLoading.value = true;
    Retour _res = await provDriver.putAttribuerVehicule(
        vehicule_id: vehicleSelected.value.id ?? 0, driver_id: driverID.value);
    ctlVehicule.listerVehicules();
    ctlDriver.ListerDrivers();
    istLoading.value = false;
    return _res;
  }

  ///`LISTER CATEGORIES`
  Future ListerDrivers() async {
    istLoading.value = true;
    driversList.value = await provDriver.getListerDrivers(
        proprio_id: helper.proprioInfo.value.id ?? 0);
    driversList.value = driversList.reversed.toList();
    tempDriverList.value = driversList;
    istLoading.value = false;
    return driversList;
  }

  ///`LISTER HISTORIQUE`
  Future<List<Resume>> getHistorique() async {
    isLoading.value = true;
    historiqueDriverList.value = await provDriver.getListerHistoriqueDrivers(
        proprio_id: helper.proprioInfo.value.id!.toInt(),
        driver_id: driver.value.id!.toInt(),
        date_debut: startDate.value.toString().substring(0, 10),
        date_fin: endedDate.value.toString().substring(0, 10));
    isLoading.value = false;
    return historiqueDriverList.value;
  }
}
