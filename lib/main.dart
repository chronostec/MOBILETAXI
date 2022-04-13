import 'dart:io';

import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/themes/app_theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

import 'app/routes/app_pages.dart';
import 'app/translation/translation.dart';

void main() async {
  await GetStorage.init();

  ctlHome.onInit();
  final String defaultLocale = Platform.localeName;
  ctlHome.defaultLanguage.value = defaultLocale;

  ctlHome.readDriverLocalInfo();

  runApp(
    Sizer(
      builder: (p0, p1, p2) => GetMaterialApp(
        title: "DRIVER",
        debugShowCheckedModeBanner: false,
        initialRoute: ctlHome.driver.value.licence == null ||
                ctlHome.driver.value.licence! == 0
            ? Routes.LICENCE
            : ctlHome.driver.value.id != null &&
                    ctlHome.driver.value.id!.toInt() > 0
                ? Routes.HOME
                : AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: AppTheme().lightThemeData,
        defaultTransition: Transition.cupertinoDialog,
        translationsKeys: AppTranslation.translationsKeys,
        locale: Get.deviceLocale,
        fallbackLocale: const Locale('fr', 'FR'),
      ),
    ),
  );
}
