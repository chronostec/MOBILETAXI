import 'package:currency_formatter/currency_formatter.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/data/models/driver_model.dart';
import 'package:fredy_proprio/app/data/models/paiement_model.dart';
import 'package:fredy_proprio/app/data/models/rechargement_model.dart';
import 'package:fredy_proprio/app/data/providers/providers.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class RechargementController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxInt saisie = 0.obs;
  final RxString url = "".obs;
  final RxList<int> montant = <int>[].obs;
  final RxBool isOperationLoading = false.obs;
  final RxBool isUrlLoading = false.obs;

  Rx<Rechargement> rechargements =
      Rechargement(proprioId: 1, solde: 5500000, operation: []).obs;

  final recharger = Rechargement().obs;
  final driver = Driver().obs;

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

  Future ouvrirWebView() async {}

  Future chercherContact(String value) async {
    return ctlDriver.driversList
        .where((p0) =>
            p0.telephone
                .toString()
                .trim()
                .toLowerCase()
                .contains(value.toString().trim().toLowerCase()) ||
            p0.nom
                .toString()
                .trim()
                .toLowerCase()
                .contains(value.toString().trim().toLowerCase()) ||
            p0.prenom
                .toString()
                .trim()
                .toLowerCase()
                .contains(value.toString().trim().toLowerCase()))
        .toList();
  }

  Future chargerUrlRecharge() async {
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 5))
        .then((value) => isLoading.value = false);
  }

  Future<Rechargement> listerHistoriqueRecharges() async {
    isOperationLoading.value = true;
    rechargements.value = await proRechargement.getListerHistoriqueRechargement(
        proprio_id: helper.proprioInfo.value.id ?? 0);
    isOperationLoading.value = false;
    print(rechargements.value.toJson());
    return rechargements.value;
  }

  Future<Paiement> demanderUrlRecharge(
      int driver_id, String contact, int montant) async {
    isOperationLoading.value = true;
    var _res = proRechargement.getLienRechargement(
        proprio_id: helper.proprioInfo.value.id ?? 0,
        driver_id: driver_id,
        driver_contact: contact,
        montant: montant);
    isOperationLoading.value = false;
    return _res;
  }
}
