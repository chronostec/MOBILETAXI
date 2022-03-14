import 'package:flutter/material.dart';
import 'package:fredy_proprio/app/data/models/proprio_model.dart';
import 'package:fredy_proprio/app/data/models/retour_model.dart';
import 'package:fredy_proprio/app/data/providers/providers.dart';
import 'package:fredy_proprio/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  TextEditingController nomTC = TextEditingController();
  TextEditingController prenomTC = TextEditingController();
  TextEditingController emailTC = TextEditingController();
  TextEditingController phoneTC = TextEditingController();
  TextEditingController passwordTC = TextEditingController();
  TextEditingController confirmpasswordTC = TextEditingController();

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

  Future signupFN() async {
    isLoading.value = true;
    Retour _signup = await provProprio.postInscription(
        nom: nomTC.text.trim(),
        prenom: prenomTC.text.trim(),
        telephone: phoneTC.text.trim().toLowerCase(),
        email: emailTC.text.trim().toLowerCase(),
        password: passwordTC.text.trim().toLowerCase());
    isLoading.value = false;

    if (_signup.message == "succes") {
      Get.snackbar("Merci",
          "Inscription éffectuée avec succès ! Merci de vous connecter svp.",
          duration: const Duration(milliseconds: 5000));
      phoneTC.text = "";
      nomTC.text = "";
      prenomTC.text = "";
      emailTC.text = "";
      passwordTC.text = "";

      Get.offAllNamed(Routes.SIGNIN);
    } else {
      Get.snackbar("Erreur connexion", "Téléphone ou mot de pass incorrects !",
          duration: const Duration(milliseconds: 4000));
    }
  }
}
