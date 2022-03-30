import 'package:alfred_taxi_driver/app/data/models/rechargement_model.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class RechargementController extends GetxController {
  final RxInt saisie = 0.obs;
  final RxString url = "".obs;
  final RxList<int> montant = <int>[].obs;

  Rx<Rechargement> rechargements =
      Rechargement(driverId: 1, solde: 550000, operation: [
    for (var i = 0; i < 10; i++)
      Operation(
          id: i,
          contact: "075777750$i",
          montant: "${i * 10000}",
          date: DateTime.now().toString().substring(0, 19),
          ref: const Uuid().v1().substring(6, 15))
  ]).obs;

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
}
