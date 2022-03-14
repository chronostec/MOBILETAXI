import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:alfred_taxi_driver/app/data/models/adresse_model.dart';
import 'package:alfred_taxi_driver/app/data/models/distance_duree_model.dart';
import 'package:alfred_taxi_driver/app/data/providers/providers.dart';
import 'package:alfred_taxi_driver/app/themes/colors/app_colors.dart';
import 'package:alfred_taxi_driver/app/utils/images_path.dart';
import 'package:alfred_taxi_driver/app/utils/keywords.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:get/get.dart';
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class DriverMapController extends GetxController {
  GoogleMapController? mapController; //contrller for Google map

  ///CURRENT LOCATION AND POLYLINES
  Location currentLocation = Location();
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{}.obs;

  var currentLatitude = 0.0.obs;
  var currentLongitude = 0.0.obs;

  ///DISTANCE MATRIX_DISTANCE AND DURATION
  final distanceDuree = DistanceDuree().obs;
  final adresse = Adresse().obs;

  ///LOCATIONS MARKERS ICONS
  var driverIcon = BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(size: ui.Size(4, 4)),
    PathImage.driver,
  ).obs;
  //BitmapDescriptor.defaultMarker.obs;
  var rdvIcon = BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(size: ui.Size(4, 4)),
    PathImage.rdv,
  ).obs;
  var destinationIcon = BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(size: ui.Size(4, 4)),
    PathImage.destination,
  ).obs;

  /// MARKERS
  Set<Marker> markers = <Marker>{}.obs;
  var originMarker =
      const Marker(markerId: MarkerId("origin"), position: LatLng(0.0, 0.0))
          .obs;
  var rdvMarker =
      const Marker(markerId: MarkerId("rdv"), position: LatLng(0.0, 0.0)).obs;
  var destinationMarker = const Marker(
          markerId: MarkerId("destination"), position: LatLng(0.0, 0.0))
      .obs;
  RxDouble testZoom = 15.0.obs;
  @override
  void onInit() async {
    refreshMarkers();
    super.onInit();
  }

  @override
  void onReady() async {
    await ctlDrivermap.getAddressFromLatLong(LatLng(
        ctlcommande.commande.value.clientLatitude ?? 0,
        ctlcommande.commande.value.clientLongitude ?? 0));
    super.onReady();
  }

  @override
  void onClose() {}

  ///`GET DRIVER POSITION GPS`
  // void getLocation() async {
  //   currentLocation.onLocationChanged.listen(
  //     (LocationData loc) async {
  //       mapController
  //           ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //         target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
  //         zoom: 15.0,
  //       )));

  //       currentLatitude.value = double.parse(loc.latitude.toString());
  //       currentLongitude.value = double.parse(loc.longitude.toString());
  //       showLocation = LatLng(currentLatitude.value, currentLongitude.value);
  //     },
  //   );
  //   showLocation = LatLng(currentLatitude.value, currentLongitude.value);
  // }

  /// `CREATE DRIVER MARKER`
  addDrivermarker(LatLng posLatLng) async {
    originMarker.value = Marker(
        markerId: MAPSMARKERS.driverMarkerId,
        position: posLatLng,
        icon: await driverIcon.value);
  }

  /// `CREATE RDV MARKER`
  addRdvmarker(LatLng posLatLng) async {
    rdvMarker.value = Marker(
        markerId: MAPSMARKERS.rdvMarkerId,
        position: posLatLng,
        icon: await rdvIcon.value);
  }

  /// `CREATE DESTINATION MARKER`
  addDestinationmarker(LatLng posLatLng) async {
    destinationMarker.value = Marker(
        markerId: MAPSMARKERS.destinationMarkerId,
        position: posLatLng,
        icon: await destinationIcon.value);
  }

  Future initDetailsMapMarkers() async {
    addDestinationmarker(LatLng(
      ctlcommande.commande.value.destLatitude!.toDouble(),
      ctlcommande.commande.value.destLongitude!.toDouble(),
    ));

    createCommanddetailMarker(
      driver: originMarker.value,
      rdv: rdvMarker.value,
      destination: destinationMarker.value,
    );
  }

  /// `INITI MARKERS ICON`
  // initializeMarkersIcons() async {
  //   driverIcon.value =
  //       await createBitmapicon(imagePath: PathImage.car_accepted);
  //   rdvIcon.value =
  //       await createBitmapicon(imagePath: PathImage.client_position);
  //   destinationIcon.value =
  //       await createBitmapicon(imagePath: PathImage.client_destination);
  // }

  /// `INITI MARKERS`
  refreshMarkers() async {
    if (ctlcommande.statuscommand.value != CMDSTATUS.COMMAND_EMPTY ||
        ctlcommande.DETAILLER_COMMANDE.value) {
      markers.clear();
      addDrivermarker(ctlHome.driverGPS.value);
      addRdvmarker(LatLng(
        ctlcommande.commande.value.clientLatitude!.toDouble(),
        ctlcommande.commande.value.clientLongitude!.toDouble(),
      ));
      addDestinationmarker(LatLng(
        ctlcommande.commande.value.destLatitude!.toDouble(),
        ctlcommande.commande.value.destLongitude!.toDouble(),
      ));
      createCommanddetailMarker(
        driver: originMarker.value,
        rdv: rdvMarker.value,
        destination: destinationMarker.value,
      );
    }
  }

  /// `BITMAP DESCRIPTOR ICON`
  Future<BitmapDescriptor> createBitmapicon({
    required String imagePath,
  }) async {
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
        size: ui.Size(4, 4),
      ),
      imagePath,
    );
    return markerbitmap;
  }

  /// `CREATE CONSULTING COMMAND DETAILS MARKERS`
  Future createCommanddetailMarker({
    required Marker driver,
    required Marker rdv,
    required Marker destination,
  }) async {
    markers.clear();
    markers.addAll({driver, rdv, destination});
  }

  /// `CREATE GOTO CLIENT MARKERS`
  Future createGotoClientMarker({
    required Marker driver,
    required Marker rdv,
    required Marker destination,
  }) async {
    markers.clear();
    markers.addAll({driver, rdv, destination});
  }

  /// `CREATE DRIVING MARKERS`
  Future createDrivingMarker({
    required Marker driver,
    required Marker destination,
  }) async {
    markers.clear();
    markers.addAll({driver, destination});
  }

/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////

  /// `RECUPERER LA DISTANCE ET LE TEMPS AVEC LES ADRESSES DE DESZTINATION ET D'ORIGINE`
  addPolyLine(List<LatLng> polylineCoordinates, {color = AppColors.DRED1}) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id,
        points: polylineCoordinates,
        width: 16,
        color: ctlcommande.DETAILLER_COMMANDE.value ? Colors.blue : color);
    polylines[id] = polyline;
  }

  void getPolyline(
      {required LatLng destination, color = AppColors.DRED1}) async {
    List<LatLng> polylineCoordinates = [];
    PolylineResult result;

    try {
      result = await polylinePoints.getRouteBetweenCoordinates(
          MAPSKEY.GMKEY,
          PointLatLng(ctlHome.driverGPS.value.latitude,
              ctlHome.driverGPS.value.longitude),
          PointLatLng(
            destination.latitude,
            destination.longitude,
          ),
          travelMode: TravelMode.driving,
          optimizeWaypoints: true);

      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      } else {
        print(result.errorMessage);
      }
    } catch (e) {
      print("ERREUR POLYLINE: $e");
    }

    addPolyLine(polylineCoordinates, color: color);

    if (ctlcommande.statuscommand.value != CMDSTATUS.COMMAND_EMPTY ||
        ctlcommande.statuscommand.value != CMDSTATUS.COMMAND_TERMINEE) {
      await getDistanceMatrix(LatLng(
        destination.latitude,
        destination.longitude,
      ));
    }
  }

  /// `GET DISTANCE DUREE`
  Future getDistanceMatrix(LatLng destination) async {
    var libelle, duree, distance;
    var result = await proDistancematrix.getDistanceMatrix(
      destination: destination,
      origin: ctlHome.driverGPS.value,
    );
    getAddressFromLatLong(destination);

    if (result.isNotEmpty) {
      distance = result[0]['elements'][0]["distance"]["text"];
      duree = result[0]['elements'][0]["duration"]["text"];

      // print("DISTANCE DUREE $distance $duree");
      distanceDuree.value = DistanceDuree(
        distance: distance,
        duree: duree,
        libelle:
            "${adresse.value.street},${adresse.value.subLocality},${adresse.value.locality},",
      );
    }
  }

  Future<Adresse> getAddressFromLatLong(LatLng position) async {
    List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        position.latitude, position.longitude);

    geo.Placemark place = placemarks[0];

    adresse.value = Adresse(
      street: place.street,
      subLocality: place.subLocality,
      locality: place.locality,
      postalCode: place.postalCode,
      country: place.country,
    );
    if (ctlcommande.statuscommand.value == CMDSTATUS.COMMAND_EMPTY) {
      distanceDuree.value = DistanceDuree(
        libelle:
            "${adresse.value.street},${adresse.value.subLocality},${adresse.value.locality},",
      );
    }

    return adresse.value;
  }
}
