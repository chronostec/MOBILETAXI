import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/data/models/driver_model.dart';
import 'package:alfred_taxi_driver/app/data/providers/providers.dart'
    show proAuth;
import 'package:alfred_taxi_driver/app/data/services/local_storage.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  RxBool DIALOGSTATUS = false.obs;
  @override
  void onInit() {
    DIALOGSTATUS.value = false;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  /// `SIGN IN DRIVER`
  Future<bool> signIn({
    required phone,
    required password,
  }) async {
    if (phone.toString().toLowerCase() ==
            ctlHome.driver.value.telephone.toString().toLowerCase() &&
        password.toString().toLowerCase() ==
            ctlHome.driver.value.password.toString().toLowerCase()) {
      return true;
    } else {
      var _res = await getMoreInfo(phone: phone, password: password);
      if (_res) {
        return true;
      } else {
        return false;
      }
    }
  }

  /// `GET MORE INFO ABOUT DRIVER`
  Future<bool> getMoreInfo({
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
      return true;
    } else {
      LocalStorage().box.erase();
      return false;
    }
  }
}
