import 'dart:async';

import 'package:alfred_taxi_client/app/common/controllers.dart'
    show ctlHome, ctlRecherche;
import 'package:alfred_taxi_client/app/common/keywords.dart';
import 'package:alfred_taxi_client/app/data/models/distance_matrix_model.dart';
import 'package:alfred_taxi_client/app/data/models/place_detail_model.dart'
    as pd;
import 'package:alfred_taxi_client/app/data/models/point_model.dart';
import 'package:alfred_taxi_client/app/data/models/vehicule_libre_model.dart';
import 'package:alfred_taxi_client/app/data/providers/providers.dart'
    show provDistMatrix, provGplaces, provVLibre;
import 'package:alfred_taxi_client/app/modules/utils/markers_icon.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart' as geo;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class MapCourseController extends GetxController {
  var mapController;
  // final mapController = Completer<GoogleMapController>();
  final statuscommand = CMDSTATUS.COMMAND_EMPTY.obs;
  RxBool ISWEBVIEW = false.obs;
  RxBool ISCHARGING = false.obs;
  final pointPosition = Point().obs;
  final pointOrigine = Point().obs;
  final pointDestination = Point().obs;
  final pointChauffeur = Point().obs;

  final distMatrix = DistanceMatrix().obs;
  final drivingDistMatrix = DistanceMatrix(rows: []).obs;
  final rdvDistMatrix = DistanceMatrix().obs;
  final pointActuelle = const LatLng(0.0, 0.0).obs;
  loc.Location userLocation = loc.Location();
  RxDouble zoom = 17.0.obs;

  final vehiculibreList = <VehiculeLibre>[].obs;

  /// MARKERS
  Set<Marker> markers = <Marker>{}.obs;
  List<Marker> vehiculesMarker = <Marker>[].obs;

  ///POLYLINES POUR DESSINER TRAJET
  Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{}.obs;
  PolylinePoints polylinePoints = PolylinePoints();

  var userMarker =
      const Marker(markerId: MarkerId("user"), position: LatLng(0.0, 0.0)).obs;
  var driverMarker =
      const Marker(markerId: MarkerId("driver"), position: LatLng(0.0, 0.0))
          .obs;
  var rdvMarker =
      const Marker(markerId: MarkerId("rdv"), position: LatLng(0.0, 0.0)).obs;
  var destinationMarker = const Marker(
          markerId: MarkerId("destination"), position: LatLng(0.0, 0.0))
      .obs;
  var vehiculeMarker = const Marker(
          markerId: MarkerId("destination"), position: LatLng(0.0, 0.0))
      .obs;

  @override
  void onInit() {
    pointActuelle.value = ctlHome.currentPosition.value;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  /// CREATE DRIVER MARKER
  addDrivermarker(LatLng posLatLng) async {
    driverMarker.value = Marker(
        markerId: MAPSMARKERS.driverMarkerId,
        position: posLatLng,
        icon: await AppMarker().driverIcon);
  }

  /// CREATE USER MARKER
  addUsermarker(LatLng posLatLng) async {
    userMarker.value = Marker(
        markerId: MAPSMARKERS.destinationMarkerId,
        position: posLatLng,
        icon: await AppMarker().destinationIcon);
  }

  /// CREATE RDV MARKER
  addRdvmarker(LatLng posLatLng) async {
    rdvMarker.value = Marker(
        markerId: MAPSMARKERS.rdvMarkerId,
        position: posLatLng,
        icon: await AppMarker().rdvIcon);
  }

  /// CREATE DESTINATION MARKER
  addDestinationmarker(LatLng posLatLng) async {
    destinationMarker.value = Marker(
        markerId: MAPSMARKERS.destinationMarkerId,
        position: posLatLng,
        icon: await AppMarker().destinationIcon);
  }

  ///DEFINIR ORIGIN
  ///DEFINIR DESTINATION

  ///TROUVER DETAILS PLACE ID
  Future<pd.PlaceDetail> trouverDetailPlaceId(String placeid) async {
    assert(placeid != "");
    pd.PlaceDetail result = await provGplaces.findPlaceById(placeid);
    return result;
  }

  ///TROUVER DETAILS PLACE GPS
  Future<geo.Placemark> trouverDetailPlaceGPS(LatLng position) async {
    assert(position != null);
    List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        position.latitude, position.longitude);
    // printInfo(info: "PCAE INFO BY DPS: ${placemarks[0]}");
    return placemarks[0];
  }

  ///CALCULER DISTANCE MATRIX DRIVER-RDV
  Future<DistanceMatrix> rdvDistanceMatrix(
      LatLng origine, LatLng destination) async {
    LatLng orig = origine;
    LatLng dest = destination;
    DistanceMatrix resultat = await provDistMatrix.getDistanceMatrix(
      destination: dest,
      origin: orig,
    );

    rdvDistMatrix.value = DistanceMatrix(
        destination:
            Destination(latitude: dest.latitude, longitude: dest.longitude),
        origin: Destination(latitude: orig.latitude, longitude: orig.longitude),
        destinationAddresses: resultat.destinationAddresses,
        originAddresses: resultat.originAddresses,
        rows: resultat.rows);
    // printInfo(info: "DMX: ${rdvDistMatrix.value.rows![0].elements![0].duration!.text}");
    return distMatrix.value;
  }

  ///CALCULER DISTANCE MATRIX DRIVER-DESTINATION
  Future<DistanceMatrix> drivingDistanceMatrix(
      LatLng origine, LatLng destination) async {
    if (statuscommand.value != CMDSTATUS.COMMAND_EMPTY) {
      LatLng orig = origine;
      LatLng dest = destination;
      DistanceMatrix resultat = await provDistMatrix.getDistanceMatrix(
        destination: dest,
        origin: orig,
      );

      drivingDistMatrix.value = DistanceMatrix(
          destination:
              Destination(latitude: dest.latitude, longitude: dest.longitude),
          origin:
              Destination(latitude: orig.latitude, longitude: orig.longitude),
          destinationAddresses: resultat.destinationAddresses,
          originAddresses: resultat.originAddresses,
          rows: resultat.rows);
    }
    return distMatrix.value;
  }

  ///CALCULER DISTANCE MATRIX ORIGINE-DESTINATION
  Future<DistanceMatrix> calculerDistanceMatrix(
      LatLng origine, LatLng destination) async {
    if (statuscommand.value == CMDSTATUS.COMMAND_EMPTY) {
      LatLng orig = origine;
      LatLng dest = destination;
      DistanceMatrix resultat = await provDistMatrix.getDistanceMatrix(
        destination: dest,
        origin: orig,
      );

      distMatrix.value = DistanceMatrix(
          destination:
              Destination(latitude: dest.latitude, longitude: dest.longitude),
          origin:
              Destination(latitude: orig.latitude, longitude: orig.longitude),
          destinationAddresses: resultat.destinationAddresses,
          originAddresses: resultat.originAddresses,
          rows: resultat.rows);
    }

    return distMatrix.value;
  }

  ///AJOUTER LIGNE TRAJET POUR DESSINER TRAJET
  ///AJOUTER MARKERS
  actualiserMarkerVehicules({
    required origin,
    required vehicules,
  }) async {
    markers.clear();
    markers.add(origin);
    for (var mark in vehicules) {
      markers.add(mark);
    }
  }

  actualiserMarkerCourse() async {
    markers.clear();
    markers.add(driverMarker.value);
    markers.add(rdvMarker.value);
    markers.add(destinationMarker.value);
  }

  ///origine et destination de type [PointLatLng ]
  dessinierTrajet({
    required origine,
    required destination,
    required color,
  }) async {
    PolylineId id = PolylineId("poly");
    List<LatLng> polylineCoordinates = [];
    PolylineResult result;
    if (statuscommand.value != CMDSTATUS.COMMAND_EMPTY) {
      result = await polylinePoints.getRouteBetweenCoordinates(
        MAPSKEY.GMKEY,
        origine,
        destination,
      );

      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      }

      Polyline polyline = Polyline(
        polylineId: id,
        color: color,
        points: polylineCoordinates,
        width: 12,
      );

      polylines[id] = polyline;
    }
  }

  ///RECHERCHE DE VEHICULES DANS LES ENVIRONS DE RAYON 2KM
  rechercheVehiculeAProximite() async {
    vehiculibreList.value = await provVLibre.getVehiculeLibre(
        longitude: ctlRecherche.departGps.value.longitude,
        latitude: ctlRecherche.departGps.value.latitude);

    vehiculesMarker = [];
    // printInfo(info: "INFORMATION ${vehiculibreList.first}");
    for (var vehicule in vehiculibreList) {
      vehiculesMarker.add(Marker(
          markerId: MarkerId("${vehicule.immatriculation}"),
          position: LatLng(
            double.parse(vehicule.latitude.toString()),
            double.parse(vehicule.longitude.toString()),
          ),
          icon: await AppMarker().vehiculeIcon));
    }

    actualiserMarkerVehicules(
        origin: userMarker.value, vehicules: vehiculesMarker);
  }

  ///TRACER TRAJET

  ///TROUVER POSITION GPS ACTUELLE
  void onMapCreated(GoogleMapController _cntlr) async {
    mapController = _cntlr;
    userLocation.onLocationChanged.listen((l) async {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(l.latitude!.toDouble(), l.longitude!.toDouble()),
            zoom: zoom.value,
          ),
        ),
      );
      pointActuelle.value =
          LatLng(l.latitude!.toDouble(), l.longitude!.toDouble());
      print(
          "MA POSITION: ${l.latitude!.toDouble()} ${l.longitude!.toDouble()}");
      addUsermarker(LatLng(l.latitude!.toDouble(), l.longitude!.toDouble()));

      await trouverDetailPlaceGPS(
              LatLng(l.latitude!.toDouble(), l.longitude!.toDouble()))
          .then((value) {
        pointPosition.value = Point(
          libelle: value.name,
          latitude: l.latitude,
          longitude: l.longitude,
          info: "${value.street}, ${value.subLocality}, ${value.locality}",
        );
      });
    });
  }
}
