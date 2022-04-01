import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/data/models/contact_model.dart';
import 'package:alfred_taxi_driver/app/data/models/paiement_model.dart';
import 'package:alfred_taxi_driver/app/data/models/rechargement_model.dart';
import 'package:alfred_taxi_driver/app/data/providers/providers.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class RechargementController extends GetxController {
  final RxInt saisie = 0.obs;
  final RxString url = "".obs;
  final RxList<int> montant = <int>[].obs;
  final RxBool isContactLoading = false.obs;
  final RxBool isOperationLoading = false.obs;
  final RxBool isUrlLoading = false.obs;

  // Rx<Rechargement> rechargements =
  //     Rechargement(driverId: 1, solde: 550000, operation: []).obs;

  Rx<Rechargement> rechargements = Rechargement().obs;
  RxList<Contact> contacts = <Contact>[].obs;

  CurrencyFormatter currency = CurrencyFormatter();
  CurrencyFormatterSettings unitSettings = CurrencyFormatterSettings(
    symbol: 'XOF',
    symbolSide: SymbolSide.right,
    thousandSeparator: '.',
    decimalSeparator: ',',
  );

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    listerHistoriqueRecharges();
    listercontactServiceRecharge();
    super.onReady();
  }

  @override
  void onClose() {}

  ajouterChiffre(int val) {
    montant.add(val);
    saisie.value = int.parse(montant.join(""));
  }

  enleverChiffre() {
    if (saisie.value > 0 && montant.length > 1) {
      montant.removeLast();
      saisie.value = int.parse(montant.join(""));
    } else if (saisie.value > 0 && montant.length == 1) {
      montant.removeLast();
      saisie.value = 0;
    } else {
      saisie.value = 0;
    }
  }

  Future<List<Contact>> listercontactServiceRecharge() async {
    isContactLoading.value = true;
    contacts.value =
        await proRechargement.getListerContactServiceRechargement();
    isContactLoading.value = false;
    return contacts;
  }

  Future<Rechargement> listerHistoriqueRecharges() async {
    isOperationLoading.value = true;
    rechargements.value = await proRechargement.getListerHistoriqueRechargement(
        driver_id: ctlHome.driver.value.id ?? 0);
    isOperationLoading.value = false;
    print(rechargements.value.toJson());
    return rechargements.value;
  }

  Future<Paiement> demanderUrlRecharge(int montant) async {
    isOperationLoading.value = true;
    var _res = proRechargement.getLienRechargement(
        driver_id: ctlHome.driver.value.id ?? 0, montant: montant);
    isOperationLoading.value = false;
    return _res;
  }
}
