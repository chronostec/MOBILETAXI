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

  Future signinUser() async {}
}
