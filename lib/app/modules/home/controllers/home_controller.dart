import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt currentPage = 0.obs;

  @override
  void onInit() {
    currentPage.value = 0;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
