import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/data/models/reversement_model.dart';
import 'package:fredy_proprio/app/data/providers/providers.dart';
import 'package:get/get.dart';

class ReversementController extends GetxController {
  RxString urlPaiement = "".obs;
  RxBool isLoading = false.obs;
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

  Future<String> genererLienPaiement(int proprioId, String montant) async {
    isLoading.value = true;
    Reversement _reversement = await provReversement.postGenererLienPaiement(
        proprio_id: proprioId, montant: montant);
    if (_reversement.bSuccess == true &&
        _reversement.versementUrl != null &&
        _reversement.versementUrl!.isNotEmpty) {
      urlPaiement.value = _reversement.versementUrl!;
    }
    isLoading.value = false;
    return _reversement.versementUrl ?? urlPaiement.value;
  }
}
