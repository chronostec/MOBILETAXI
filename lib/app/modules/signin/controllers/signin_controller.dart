import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/data/models/driver_model.dart';
import 'package:alfred_taxi_driver/app/data/providers/providers.dart';
import 'package:alfred_taxi_driver/app/data/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
  TextEditingController phoneTC = TextEditingController();
  TextEditingController passwordTC = TextEditingController();

  final RxBool keepAsConnected = false.obs;
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

  Future signinUser() async {
    isLoading.value = true;
    if (phoneTC.text.toString().toLowerCase() ==
            ctlHome.driver.value.telephone.toString().toLowerCase() &&
        passwordTC.text.toString().toLowerCase() ==
            ctlHome.driver.value.password.toString().toLowerCase()) {
      isLoading.value = false;
      return true;
    } else {
      Driver _res =
          await getMoreInfo(phone: phoneTC.text, password: passwordTC.text);
      if (_res.id != null && _res.id! > 0) {
        //TODO
        isLoading.value = false;
        return true;
      } else if (_res.id != null && _res.id! > 0) {
        //TODO
        isLoading.value = false;
        return true;
      } else {
        //TODO
        isLoading.value = false;
        return false;
      }
    }
  }

  Future getMoreInfo({
    required phone,
    required password,
  }) async {
    var _driver = await proAuth.getDriver(telephone: phone, password: password);

    if (_driver.id!.toInt() > 0) {
      ctlHome.writeDriverLocalInfo(Driver(
        id: _driver.id,
        nom: _driver.nom,
        prenom: _driver.prenom,
        telephone: phone,
        password: password,
        language: ctlHome.defaultLanguage.value.substring(0, 2),
        theme: ctlHome.defaultTheme.value,
        vehiculeId: _driver.vehiculeId,
        proprioId: _driver.proprioId,
        immatriculation: _driver.immatriculation,
      ));
    } else {
      LocalStorage().box.erase();
    }
    return _driver;
  }
}
