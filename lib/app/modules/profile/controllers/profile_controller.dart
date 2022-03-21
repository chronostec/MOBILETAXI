import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/data/models/partage_model.dart';
import 'package:alfred_taxi_driver/app/data/providers/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPasswordEditing = false.obs;
  RxBool isNewPasswordEditing = false.obs;

  var globalKey = GlobalKey<FormState>();
  var fnameTF = TextEditingController().obs;
  var lnameTF = TextEditingController().obs;
  var phoneTF = TextEditingController().obs;
  var oldpasswordTC = TextEditingController(text: "").obs;
  var passwordTC = TextEditingController(text: "").obs;
  var confirmpasswordTC = TextEditingController(text: "").obs;

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

  Future updatePassword() async {
    isLoading.value = true;
    Resultat _resultat = await proDriver.putDriverPwd(
        numero_driver: ctlHome.driver.value.id ?? 0,
        ancien_password: oldpasswordTC.value.text.trim(),
        new_password: passwordTC.value.text.trim());
    if (_resultat.bSuccess) {
      isPasswordEditing.value = false;
      isNewPasswordEditing.value = false;
      Get.snackbar("MOT DE PASSE", "Mot de passe mis à jour avec succès !");
    } else {
      Get.snackbar("MOT DE PASSE", "Echec de mis à jour du mot de passe !");
    }
    isLoading.value = false;
  }
}
