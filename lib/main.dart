import 'dart:io';

import 'package:alfred_taxi_client/app/data/services/stream_commande_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

import 'app/common/controllers.dart' show ctlHome;
import 'app/routes/app_pages.dart';
import 'app/themes/styles/app_theme.dart';
import 'app/translation/translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await periodicPosition();
  ctlHome.onInit();
  ctlHome.defaultLanguage.value = Platform.localeName;

  runApp(
    Sizer(
      builder: (p0, p1, p2) => GetMaterialApp(
        title: "CLIENT",
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.INITIAL,
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
