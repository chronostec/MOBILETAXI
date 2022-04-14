import 'package:alfred_taxi_driver/app/data/services/local_storage.dart';
import 'package:alfred_taxi_driver/app/routes/app_pages.dart';
import 'package:get/get.dart';

class Deconnexion {
  seDeconnecter() {
    LocalStorage().box.erase();
    Get.snackbar("Déconnexion",
        "Vos identifiants sont corrompus, veuillez vous reconnecter à nous nouveau");
    Get.offAllNamed(Routes.AUTHENTICATION);
  }
}
