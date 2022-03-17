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

Future updateDriverPosition() async {
  // LatLng gps = const LatLng(0, 0);
  Timer.periodic(const Duration(seconds: 30), (Timer timer) async {
    if (ctlHome.driverGPS.value.latitude == 0 &&
        ctlHome.driverGPS.value.longitude == 0) {
      var _pos = await Geolocator.getCurrentPosition();

      if (_pos.latitude != 0 && _pos.longitude != 0) {
        proDriver.putDriverPosition(
            vehicule_id: ctlHome.driver.value.vehiculeId,
            latitude: _pos.latitude,
            longitude: _pos.longitude);
      } else {
        proDriver.putDriverPosition(
            vehicule_id: ctlHome.driver.value.vehiculeId,
            latitude: ctlHome.driverGPS.value.latitude,
            longitude: ctlHome.driverGPS.value.longitude);
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
  Timer.periodic(const Duration(seconds: 6), (Timer timer) async {
    if (ctlcommande.commande.value.status == CMDSTATUS.COMMAND_ACCEPTEE ||
        ctlcommande.commande.value.status == CMDSTATUS.COMMAND_COMMENCEE ||
        ctlcommande.commande.value.status == CMDSTATUS.COMMAND_PAIEMENT) {
      if (ctlHome.driverGPS.value.latitude == 0 &&
          ctlHome.driverGPS.value.longitude == 0) {
        var _pos = await Geolocator.getCurrentPosition();

        if (_pos.latitude != 0 && _pos.longitude != 0) {
          proDriver.updateDriverPositionRemaingDistMatrix(
              id_commande: ctlcommande.commande.value.id ?? 0,
              gps_latitude: _pos.latitude,
              gps_longitude: _pos.longitude,
              distance_en_metre: ctlDrivermap.distanceDuree.value.distance ?? 0,
              duree_en_seconde: ctlDrivermap.distanceDuree.value.duree ?? 0);
          print(
              "CHAUFFEUR=================>${LatLng(double.parse(_pos.latitude.toString()), double.parse(_pos.longitude.toString()))}");
        }
      } else {
        proDriver.updateDriverPositionRemaingDistMatrix(
            id_commande: ctlcommande.commande.value.id ?? 0,
            gps_latitude: ctlHome.driverGPS.value.latitude,
            gps_longitude: ctlHome.driverGPS.value.longitude,
            distance_en_metre: ctlDrivermap.distanceDuree.value.distance ?? 0,
            duree_en_seconde: ctlDrivermap.distanceDuree.value.duree ?? 0);
      }
    } else {
      timer.cancel();
    }
  });
}

Future reinitialiserLaCourse() async {
  ctlcommande.statuscommand.value = CMDSTATUS.COMMAND_EMPTY;
}
