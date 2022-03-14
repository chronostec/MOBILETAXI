import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool showPassword = false.obs;

  var globalKey = GlobalKey<FormState>();
  var fnameTF = TextEditingController().obs;
  var lnameTF = TextEditingController().obs;
  var phoneTF = TextEditingController().obs;
  var passwordTF = TextEditingController().obs;

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
}
