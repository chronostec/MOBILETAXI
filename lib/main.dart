import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fredy_proprio/app/constants/controllers.dart';
import 'package:fredy_proprio/app/data/models/proprio_model.dart';
import 'package:fredy_proprio/app/data/services/local_storage.dart';
import 'package:fredy_proprio/app/themes/app_theme.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

import 'app/routes/app_pages.dart';
import 'app/themes/themeservice.dart';

void main() async {
  await GetStorage.init();
  helper.connected.value = false;
  helper.defaultLanguage.value = Platform.localeName;

  await LocalStorage().readUserData().then((value) {
    helper.proprioInfo.value = value;
    value.id != null && value.id! > 0
        ? helper.connected.value = true
        : helper.connected.value = false;
  });

  runApp(Sizer(
    builder: (p0, p1, p2) => GetMaterialApp(
      title: "PROPRIO",
      debugShowCheckedModeBanner: false,
      theme: AppTheme().lightThemeData,
      darkTheme: AppTheme().darkThemeData,
      themeMode: ThemeService().theme,
      initialRoute: helper.connected.value ? Routes.HOME : AppPages.INITIAL,
      getPages: AppPages.routes,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
    ),
  ));
}

/// AUTHENTICATE USER
authenticate(Proprio proprio) => (proprio.id != null && proprio.id! > 0)
    ? Get.offAllNamed(Routes.HOME)
    : Get.offAllNamed(Routes.SIGNIN);
