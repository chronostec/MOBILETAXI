import 'package:currency_formatter/currency_formatter.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/data/models/driver_model.dart';
import 'package:fredy_proprio/app/data/models/rechargement_model.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class RechargementController extends GetxController {
  final RxInt saisie = 0.obs;
  final RxString url = "".obs;
  final RxList<int> montant = <int>[].obs;

  Rx<Rechargement> rechargements =
      Rechargement(proprioId: 1, solde: 5500000, operation: [
    for (var i = 0; i < 10; i++)
      Operation(
          id: i,
          destinataireContact: "075777750$i",
          montant: "${i * 10000}",
          date: DateTime.now().toString().substring(0, 19),
          ref: const Uuid().v1().substring(6, 15))
  ]).obs;

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
}
