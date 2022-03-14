import 'package:alfred_taxi_driver/app/utils/keywords.dart';
import 'package:get/get.dart';

class ParametresController extends GetxController {
  RxBool receiveNotifications = true.obs;
  RxBool receiveUpdate = true.obs;
  var language = LANGUAGEKEY.ENGLISH.obs;
  var apptheme = THEMEKEY.LIGHT.obs;

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

  Future changerLangue(lang) async {
    language.value = lang;
  }

  Future changerTheme(them) async {
    apptheme.value = them;
  }
}
