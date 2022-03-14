import 'package:get/get.dart';

class PaymentController extends GetxController {
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
}
