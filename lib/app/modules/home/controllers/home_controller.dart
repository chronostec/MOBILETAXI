import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/common/keywords.dart';
import 'package:alfred_taxi_client/app/data/models/distance_matrix_model.dart';
import 'package:alfred_taxi_client/app/data/models/point_model.dart';
import 'package:alfred_taxi_client/app/data/models/user_model.dart';
import 'package:alfred_taxi_client/app/data/services/local_storage.dart';
import 'package:alfred_taxi_client/app/data/services/stream_commande_service.dart';
import 'package:alfred_taxi_client/app/routes/app_pages.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:map_picker/map_picker.dart';

class HomeController extends GetxController {
  final defaultLanguage = 'fr_FR'.obs;
  final deviceInfo = "".obs;
  Rx<LatLng> currentPosition = LatLng(0, 0).obs;
  final user_is_connected = false.obs;
  final showbottom = false.obs;
  final user = User(id: 1).obs;

  final GlobalKey<ScaffoldState> ghomeKey = GlobalKey<ScaffoldState>();

  Rx<CameraPosition> cameraPosition = CameraPosition(
    target: LatLng(5.400386701133325, -3.958976247793585),
    zoom: 16,
  ).obs;

  RxString urlpaiement = "".obs;
  @override
  void onInit() {
    currentPosition.value =
        LatLng(user.value.gpsLatitude ?? 0, user.value.gpsLongitude ?? 0);
    ActualiserGPSIM();
    verifierIdentite();
    checkVehiculeAroundPeriodicEvent();
    super.onInit();
  }

  @override
  void onReady() {
    ctlMapCourse.rechercheVehiculeAProximite();
    checkVehiculeAroundPeriodicEvent();
    super.onReady();
  }

  @override
  void onClose() {}

  /// VERIFIER IDENTITE
  Future<bool> verifierIdentite() async {
    user.value = await LocalStorage().readUserData();
    if (user.value.id != null && user.value.id != 0) {
      user_is_connected.value = true;
    } else {
      user_is_connected.value = false;
    }
    return user_is_connected.value;
  }

  /// ACTUALISER GPS SIM
  Future<LatLng> ActualiserGPSIM() async {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) async {
      currentPosition.value = LatLng(position.latitude, position.longitude);
    }).catchError((e) {
      print(e);
    });
    print("SIM POSITION ${currentPosition.value}");
    return currentPosition.value;
  }

  reinitialiserTout() async {
    ctlMapCourse.statuscommand.value = CMDSTATUS.COMMAND_EMPTY;
    //  ctlMapCourse.statuscommand.value = CMDSTATUS.COMMAND_EMPTY
    ctlEchange.chatboxList.clear();
    ctlMapCourse.ISWEBVIEW.value = false;
    ctlHome.showbottom.value == true;
    ctlMapCourse.polylinePoints = PolylinePoints();
    ctlMapCourse.rdvDistMatrix.value = DistanceMatrix();
    ctlMapCourse.drivingDistMatrix.value = DistanceMatrix();
    ctlMapCourse.vehiculibreList.value = [];
    ctlMapCourse.markers.clear();
    ctlMapCourse.polylines.clear();
    ctlMapCourse.markers = {};
    ctlMapCourse.polylines = {};
    ctlHome.urlpaiement.value = "";
    checkEchangePeriodicEvent(res: true);
    checkVehiculeAroundPeriodicEvent();
    // Get.offAllNamed(Routes.HOME);
  }
}
