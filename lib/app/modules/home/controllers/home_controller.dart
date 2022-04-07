import 'dart:async';

import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/data/models/commandes_model.dart';
import 'package:alfred_taxi_driver/app/data/models/driver_model.dart';
import 'package:alfred_taxi_driver/app/data/providers/providers.dart';
import 'package:alfred_taxi_driver/app/data/services/local_storage.dart';
import 'package:alfred_taxi_driver/app/data/services/stream_commande_service.dart';
import 'package:alfred_taxi_driver/app/modules/commande/views/commande_driving_view.dart';
import 'package:alfred_taxi_driver/app/themes/colors/app_colors.dart';
import 'package:alfred_taxi_driver/app/utils/keywords.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomeController extends GetxController {
  final defaultLanguage = 'fr_FR'.obs;
  final defaultTheme = 'LIGTH'.obs;
  final GlobalKey<ScaffoldState> ghomeKey = GlobalKey<ScaffoldState>();
  var driver = Driver().obs;
  RxBool cacheRead = false.obs;
  RxBool isWaiting = false.obs;
  RxBool isDriving = false.obs;

  RxDouble testZoom = 15.0.obs;

  @override
  void onInit() {
    readDriverLocalInfo();
    // readCommandeLocalInfo();

    super.onInit();
  }

  @override
  void onReady() {
    // ctlHome.rebaseCommandes();
    ctlcommande.getCommandeDisponible();

    checkCommandedisponiblePeriodicEvent();
    // onMapCreated(mapController);
    // readCommandeLocalInfo();
    updateDriverPosition();
    super.onReady();
  }

  @override
  void onClose() {
    mapController.dispose();
  }

  /// READ DATA
  Future readDriverLocalInfo() async {
    driver.value = await LocalStorage().readUserData();
  }

  /// READ CMDE
  Future readCommandeLocalInfo() async {
    var res = Commandes();
    await LocalStorage().readCurrentCmde().then((_cmde) async {
      if (_cmde.status != CMDSTATUS.COMMAND_ANNULEE ||
          _cmde.status != CMDSTATUS.COMMAND_TERMINEE ||
          _cmde.status != CMDSTATUS.COMMAND_EMPTY) {
        res = await proCommande.getCommandeDetailAcceptee(
            driver_id: driver.value.id as int, cmde_id: _cmde.id as int);
      }

      // if (res.isNotEmpty && res[0].id == _cmde.id) {
      //   cacheRead.value = true;
      //   ctlcommande.getDetailCommandeAcceptee().then((value) =>
      //       value ? Get.off(() => const CommandeDrivingView()) : null);
      // }
    });
  }

  /// WRITE DATA
  Future writeDriverLocalInfo(Driver driver) async {
    await LocalStorage().saveUserData(driver);
    readDriverLocalInfo();
  }

  Future rebaseCommandes() async {
    ctlcommande.statuscommand.value = CMDSTATUS.COMMAND_EMPTY;
    ctlcommande.FINCOURSE.value = false;
    ctlcommande.PAIEMENTCOURSE.value = false;
    // ctlcommande.commande.value = Commande();
    checkCommandedisponiblePeriodicEvent();
  }

  var mapController; //= GoogleMapsController()
  Location driverLocation = Location();
  var driverGPS = const LatLng(0.0, 0.0).obs;

  double changeZoom(int status) {
    double res = 19.0;
    switch (status) {
      case CMDSTATUS.COMMAND_EMPTY:
        res = 15;
        // ctlHome.testZoom.value = 15;
        break;
      case CMDSTATUS.COMMAND_ACCEPTEE:
        res = 19;
        // ctlHome.testZoom.value = 17;
        break;
      case CMDSTATUS.COMMAND_COMMENCEE:
        res = 19;
        // ctlHome.testZoom.value = 19;
        break;
      case CMDSTATUS.COMMAND_TRAITEMENT:
        res = 14;
        // ctlHome.testZoom.value = 14;
        break;
      case CMDSTATUS.COMMAND_PAIEMENT:
        res = 19;
        // ctlHome.testZoom.value = 19;
        break;
      default:
        res = 15;
      // ctlHome.testZoom.value = 15;
    }

    return res;
  }

  Future onMapCreated(_cntlr) async {
    // Position position = await Geolocator.getCurrentPosition();

    driverLocation.onLocationChanged.listen((l) {
      double _zoom = changeZoom(ctlcommande.statuscommand.value);
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(l.latitude!.toDouble(), l.longitude!.toDouble()),
            zoom: _zoom,
            tilt: ctlcommande.statuscommand.value == CMDSTATUS.COMMAND_EMPTY
                ? 15
                : 60,
            bearing: l.heading!.toDouble(),
          ),
        ),
      );
      driverGPS.value = LatLng(l.latitude!.toDouble(), l.longitude!.toDouble());
      ctlDrivermap.refreshMarkers();
      print(
          "DRIVER POSITION: ${l.latitude!.toDouble()} ${l.longitude!.toDouble()}");

      // updateDriverPosition();
      if (ctlcommande.statuscommand.value == CMDSTATUS.COMMAND_ACCEPTEE &&
          isWaiting.value == false) {
        ctlDrivermap.getPolyline(
          destination: LatLng(
            ctlcommande.commande.value.clientLatitude!.toDouble(),
            ctlcommande.commande.value.clientLongitude!.toDouble(),
          ),
          color: AppColors.DGREENLIGHT,
        );

        if (isWaiting.value == false) {
          isWaiting.value = true;
        }
      } else if ((ctlcommande.statuscommand.value ==
                  CMDSTATUS.COMMAND_COMMENCEE ||
              ctlcommande.statuscommand.value == CMDSTATUS.COMMAND_PAIEMENT) &&
          isDriving.value == false) {
        ctlDrivermap.getPolyline(
          destination: LatLng(
            ctlcommande.commande.value.destLatitude!.toDouble(),
            ctlcommande.commande.value.destLongitude!.toDouble(),
          ),
          color: AppColors.DORANGE1,
        );
        if (isDriving.value == false) {
          isDriving.value = true;
        }
      }
    });
  }
}
