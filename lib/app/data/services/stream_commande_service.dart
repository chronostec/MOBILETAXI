import 'dart:async';

import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/data/providers/providers.dart';
import 'package:alfred_taxi_driver/app/utils/keywords.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future checkCommandedisponiblePeriodicEvent() async {
  if (ctlHome.driver.value.id != null && ctlHome.driver.value.id!.toInt() > 0) {
    Timer.periodic(const Duration(seconds: 6), (Timer timer) async {
      if (ctlcommande.statuscommand.value != CMDSTATUS.COMMAND_EMPTY ||
          ctlcommande.statuscommand.value != CMDSTATUS.COMMAND_PAIEMENT ||
          ctlcommande.statuscommand.value != CMDSTATUS.COMMAND_PAIEMENT ||
          ctlcommande.statuscommand.value != CMDSTATUS.COMMAND_COMMENCEE) {
        ctlcommande.getCommandeDisponible();
        if (!ctlHome.cacheRead.value) {
          // ctlHome.readCommandeLocalInfo();
        }
      } else {
        timer.cancel();
      }
    });
  }
}

Future checkEchangePeriodicEvent() async {
  Timer.periodic(const Duration(seconds: 7), (Timer timer) async {
    if (ctlcommande.statuscommand.value != CMDSTATUS.COMMAND_EMPTY ||
        ctlcommande.statuscommand.value != CMDSTATUS.COMMAND_PAIEMENT ||
        ctlcommande.statuscommand.value != CMDSTATUS.COMMAND_ANNULEE ||
        ctlcommande.statuscommand.value != CMDSTATUS.COMMAND_COMMENCEE) {
      ctlEchange.lireMessages();
    } else {
      timer.cancel();
    }
  });
}

Future pdateDriverPosition() async {
  LatLng gps = const LatLng(0, 0);
  Timer.periodic(const Duration(seconds: 30), (Timer timer) async {
    if (ctlHome.driverGPS.value.latitude == 0 &&
        ctlHome.driverGPS.value.longitude == 0) {
      Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best,
              forceAndroidLocationManager: true)
          .then((Position position) async {
        gps = LatLng(position.latitude, position.longitude);
      }).catchError((e) {
        print(e);
      });

      if (gps.latitude != 0 && gps.longitude != 0) {
        proDriver.putDriverPosition(
            vehicule_id: ctlHome.driver.value.vehiculeId,
            latitude: gps.latitude,
            longitude: gps.longitude);
      }
    } else {
      proDriver.putDriverPosition(
          vehicule_id: ctlHome.driver.value.vehiculeId,
          latitude: ctlHome.driverGPS.value.latitude,
          longitude: ctlHome.driverGPS.value.longitude);
    }
  });
}

Future updateDriverPositionRemaingDistMatrix() async {
  LatLng gps = const LatLng(0, 0);
  Timer.periodic(const Duration(seconds: 6), (Timer timer) async {
    if (ctlHome.driverGPS.value.latitude == 0 &&
        ctlHome.driverGPS.value.longitude == 0) {
      Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best,
              forceAndroidLocationManager: true)
          .then((Position position) async {
        gps = LatLng(position.latitude, position.longitude);
      }).catchError((e) {
        print(e);
      });

      if (gps.latitude != 0 && gps.longitude != 0) {
        proDriver.updateDriverPositionRemaingDistMatrix(
            id_commande: ctlcommande.commande.value.id ?? 0,
            gps_latitude: gps.latitude,
            gps_longitude: gps.longitude,
            distance_en_metre: ctlDrivermap.distanceDuree.value.distance ?? 0,
            duree_en_seconde: ctlDrivermap.distanceDuree.value.duree ?? 0);
        print(
            "CHAUFFEUR==================================>${LatLng(double.parse(gps.latitude.toString()), double.parse(gps.longitude.toString()))}");
      }
    } else {
      proDriver.updateDriverPositionRemaingDistMatrix(
          id_commande: ctlcommande.commande.value.id ?? 0,
          gps_latitude: ctlHome.driverGPS.value.latitude,
          gps_longitude: ctlHome.driverGPS.value.longitude,
          distance_en_metre: ctlDrivermap.distanceDuree.value.distance ?? 0,
          duree_en_seconde: ctlDrivermap.distanceDuree.value.duree ?? 0);
    }
  });
}

Future reinitialiserLaCourse() async {
  ctlcommande.statuscommand.value = CMDSTATUS.COMMAND_EMPTY;
}
