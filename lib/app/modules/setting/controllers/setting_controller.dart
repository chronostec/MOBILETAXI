import 'package:flutter/material.dart';
import 'package:fredy_proprio/app/themes/themeservice.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
   final lockInBackground = true.obs;
  final notificationsEnabled = true.obs;

  final themecolor = 'Thème clair'.obs;


  void changethemetext() {
    ThemeService().theme == ThemeData.dark()
        ? themecolor.value = 'Thème clair'
        : themecolor.value = 'Thème sombre';
  }

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
