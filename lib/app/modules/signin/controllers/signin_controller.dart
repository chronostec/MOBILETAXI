import 'package:flutter/cupertino.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/data/models/proprio_model.dart';
import 'package:fredy_proprio/app/data/providers/providers.dart';
import 'package:fredy_proprio/app/data/services/local_storage.dart';
import 'package:fredy_proprio/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
  TextEditingController phoneTC = TextEditingController();
  TextEditingController passwordTC = TextEditingController();

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

  Future signinFN() async {
    isLoading.value = true;
    Proprio _signin = await provProprio.getConnexion(
        telephone: phoneTC.text.toString().substring(1, phoneTC.text.length),
        password: passwordTC.text.trim().toLowerCase());
    isLoading.value = false;

    if (_signin.id! > 0) {
      Get.snackbar("Merci", "Connexion établie avec succès !");

      await LocalStorage().saveUserData(_signin);
      helper.authenticateUser();

      phoneTC.text = "";
      passwordTC.text = "";

      Get.offAllNamed(Routes.HOME);
    } else {
      Get.snackbar("Erreur connexion", "Téléphone ou mot de pass incorrects !",
          duration: const Duration(milliseconds: 4000));
    }
  }
}
