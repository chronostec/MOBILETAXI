import 'package:flutter/material.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/data/models/proprio_model.dart';
import 'package:fredy_proprio/app/data/models/retour_model.dart';
import 'package:fredy_proprio/app/data/providers/providers.dart';
import 'package:fredy_proprio/app/routes/app_pages.dart';
import 'package:get/get.dart';

class NewpasswordController extends GetxController {
  TextEditingController passwordTC = TextEditingController();
  TextEditingController confirmPasswordTC = TextEditingController();
  final RxBool isLoading = false.obs;

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

  Future puNewPasswordFN() async {
    isLoading.value = true;
    Retour _putnewpass = await provProprio.putNewPassword(
        telephone: ctlOtp.phoneNumber.value.trim().toLowerCase(),
        new_password: passwordTC.text.trim().toLowerCase());
    isLoading.value = false;

    if (_putnewpass.message == "succes") {
      Get.snackbar("Merci", "Mot de pass réinitialisé avec succès !");
      helper.authenticateUser();
      ctlSignin.phoneTC.text = ctlOtp.phoneNumber.value;
      passwordTC.text = "";
      confirmPasswordTC.text = "";

      Get.offAllNamed(Routes.SIGNIN);
    } else {
      Get.snackbar("Erreur connexion", "Quelque chose s'st mal passsé !",
          duration: const Duration(milliseconds: 4000));
    }
  }
}
