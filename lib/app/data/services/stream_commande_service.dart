import 'dart:async';

import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/common/keywords.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future checkVehiculeAroundPeriodicEvent() async {
  Timer.periodic(const Duration(seconds: 10), (Timer timer) async {
    if (ctlMapCourse.statuscommand.value == CMDSTATUS.COMMAND_EMPTY &&
        (ctlRecherche.departGps.value.latitude != 0 &&
            ctlRecherche.departGps.value.longitude != 0)) {
      ctlMapCourse.rechercheVehiculeAProximite();
    } else {
      timer.cancel();
    }
  });
}

Future checkCommandStatus() async {
  Timer.periodic(const Duration(seconds: 5), (Timer timer) async {
    if (ctlMapCourse.statuscommand.value != CMDSTATUS.COMMAND_EMPTY ||
        ctlMapCourse.statuscommand.value != CMDSTATUS.COMMAND_TERMINEE) {
      ctlRecherche.recevoirCommande();
    } else {
      timer.cancel();
    }
  });
}

Future checkEchangePeriodicEvent({bool res = false}) async {
  Timer.periodic(const Duration(seconds: 7), (Timer timer) async {
    if (ctlMapCourse.statuscommand.value != CMDSTATUS.COMMAND_EMPTY ||
        res == false ||
        ctlMapCourse.statuscommand.value == CMDSTATUS.COMMAND_PAIEMENT ||
        ctlMapCourse.statuscommand.value == CMDSTATUS.COMMAND_COMMENCEE ||
        ctlMapCourse.statuscommand.value == CMDSTATUS.COMMAND_ACCEPTEE) {
      ctlEchange.lireMessages();
    } else {
      timer.cancel();
    }
  });
}

Future periodicPosition() async {
  Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
    fournirposition();
  });
}

Future<Position> fournirposition() async {
  var _pos = await Geolocator.getCurrentPosition();
  CameraPosition(
    target: LatLng(_pos.latitude, _pos.longitude),
    zoom: ctlMapCourse.zoom.value,
  );
  ctlRecherche.departGps.value = LatLng(_pos.latitude, _pos.longitude);

  print("NOUS SOMMES A ${_pos.latitude} , ${_pos.longitude}");
  print(
      "DEPART LAT: ${_pos.latitude} , CAMERA LAT: ${ctlHome.cameraPosition.value.target.latitude}");

  return _pos;
}
