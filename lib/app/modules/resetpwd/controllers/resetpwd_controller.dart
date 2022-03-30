import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetpwdController extends GetxController {
  TextEditingController phoneTC = TextEditingController();
  TextEditingController password1TC = TextEditingController();
  TextEditingController password2TC = TextEditingController();
  final isLoading = false.obs;
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

  Future forcerChangerPwd() async {
    isLoading.value = true;

    isLoading.value = false;
  }
}
