import 'package:get/get.dart';

class RechargementController extends GetxController {
  final RxInt saisie = 0.obs;
  final RxString url = "".obs;
  final RxList<int> montant = <int>[].obs;
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
