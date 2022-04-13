import 'dart:io';

import 'package:alfred_taxi_driver/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:alfred_taxi_driver/app/constants/controllers.dart'
    show ctlHome, ctlLicence;
import 'package:alfred_taxi_driver/app/data/models/licence_model.dart';
import 'package:alfred_taxi_driver/app/themes/colors/light_color.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/licence_controller.dart';
import 'licenses_widget.dart';

class LicenceView extends GetView<LicenceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Licence>>(
        future: ctlLicence.loadLicences(context),
        builder: (context, snapshot) {
          final licences = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return const Center(
                    child: Text('Echec de chargement de la licence!'));
              } else {
                return Stack(
                  children: [
                    LicencesWidget(licences: licences!),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 8.h,
                          width: 100.w,
                          decoration:
                              const BoxDecoration(color: LightColor.yellow),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    exit(0);
                                  },
                                  child: Text(
                                    "refuser",
                                    style: TextStyle(
                                        color: Colors.white54,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    print("accepter");
                                    ctlHome.driver.value.licence = 1;
                                    ctlLicence
                                        .updateDriver(ctlHome.driver.value)
                                        .then((value) => Get.offAllNamed(
                                            ctlHome.driver.value.id != null &&
                                                    ctlHome.driver.value.id!
                                                            .toInt() >
                                                        0
                                                ? Routes.HOME
                                                : Routes.AUTHENTICATION));
                                  },
                                  child: Text("accepter",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.sp))),
                            ],
                          ),
                        ))
                  ],
                );
              }
          }
        },
      ),
    );
  }
}
