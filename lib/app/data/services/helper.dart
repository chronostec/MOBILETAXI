import 'package:fredy_proprio/app/data/models/proprio_model.dart';
import 'package:get/get.dart';

import 'local_storage.dart';

class Helper extends GetxController {
  final Rx<Proprio> proprioInfo = Proprio().obs;
  RxBool connected = false.obs;
  RxBool blocked = false.obs;
  RxString defaultLanguage = "".obs;

  authenticateUser() async {
    proprioInfo.value = await LocalStorage().readUserData();
    proprioInfo.value.id! > 0 ? connected.value : !connected.value;
  }

  RxString startdate = DateTime.now().toUtc().toString().substring(0, 10).obs;
  RxString enddate = DateTime.now().toUtc().toString().substring(0, 10).obs;
}
