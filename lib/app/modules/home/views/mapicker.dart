import 'dart:async';
import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/common/keywords.dart';
import 'package:alfred_taxi_client/app/data/services/stream_commande_service.dart';
import 'package:alfred_taxi_client/app/modules/home/controllers/picker_recherche.dart';
import 'package:alfred_taxi_client/app/modules/ma_course/views/ma_course_view.dart';
import 'package:alfred_taxi_client/app/themes/styles/app_colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:map_picker/map_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'choisir_destination.dart';
import 'menu_haut.dart';

class MaPicker extends StatefulWidget {
  MaPicker({Key? key}) : super(key: key);

  @override
  State<MaPicker> createState() => _MaPickerState();
}

class _MaPickerState extends State<MaPicker> {
  final _controller = Completer<GoogleMapController>();

  MapPickerController mapPickerController = MapPickerController();

  var textController = TextEditingController();
  var testController = TextEditingController();
  @override
  void initState() {
    textController.text = "";
    ctlRecherche.departTC.text =
        "Déplacer la carte pour choisir une destination";
    _determinePosition().then((value) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
            body: Stack(
          // alignment: Alignment.topCenter,
          children: [
            MapPicker(
                // pass icon widget
                iconWidget:
                    ctlMapCourse.statuscommand.value == CMDSTATUS.COMMAND_EMPTY
                        ? SvgPicture.asset(
                            "assets/location_icon.svg",
                            height: 80,
                          )
                        : SizedBox(),
                //add map picker controller
                mapPickerController: mapPickerController,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 0),
                  child: GoogleMap(
                    myLocationEnabled:
                        //  ctlMapCourse.statuscommand.value ==CMDSTATUS.COMMAND_EMPTY? false:
                        true,
                    zoomControlsEnabled: false,
                    // hide location button
                    myLocationButtonEnabled: true,
                    mapType: MapType.normal,
                    //  camera position
                    initialCameraPosition: ctlHome.cameraPosition.value,
                    polylines: Set<Polyline>.of(ctlMapCourse.polylines.values),
                    markers: Set<Marker>.of(ctlMapCourse.markers),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      controller.setMapStyle(
                          '[ { "featureType": "poi", "elementType": "labels.text.fill", "stylers": [ { "color": "#747474" }, { "lightness": "23" } ] }, { "featureType": "poi.attraction", "elementType": "geometry.fill", "stylers": [ { "color": "#f38eb0" } ] }, { "featureType": "poi.government", "elementType": "geometry.fill", "stylers": [ { "color": "#ced7db" } ] }, { "featureType": "poi.medical", "elementType": "geometry.fill", "stylers": [ { "color": "#ffa5a8" } ] }, { "featureType": "poi.park", "elementType": "geometry.fill", "stylers": [ { "color": "#c7e5c8" } ] }, { "featureType": "poi.place_of_worship", "elementType": "geometry.fill", "stylers": [ { "color": "#d6cbc7" } ] }, { "featureType": "poi.school", "elementType": "geometry.fill", "stylers": [ { "color": "#c4c9e8" } ] }, { "featureType": "poi.sports_complex", "elementType": "geometry.fill", "stylers": [ { "color": "#b1eaf1" } ] }, { "featureType": "road", "elementType": "geometry", "stylers": [ { "lightness": "100" } ] }, { "featureType": "road", "elementType": "labels", "stylers": [ { "visibility": "off" }, { "lightness": "100" } ] }, { "featureType": "road.highway", "elementType": "geometry.fill", "stylers": [ { "color": "#ffd4a5" } ] }, { "featureType": "road.arterial", "elementType": "geometry.fill", "stylers": [ { "color": "#ffe9d2" } ] }, { "featureType": "road.local", "elementType": "all", "stylers": [ { "visibility": "simplified" } ] }, { "featureType": "road.local", "elementType": "geometry.fill", "stylers": [ { "weight": "3.00" } ] }, { "featureType": "road.local", "elementType": "geometry.stroke", "stylers": [ { "weight": "0.30" } ] }, { "featureType": "road.local", "elementType": "labels.text", "stylers": [ { "visibility": "on" } ] }, { "featureType": "road.local", "elementType": "labels.text.fill", "stylers": [ { "color": "#747474" }, { "lightness": "36" } ] }, { "featureType": "road.local", "elementType": "labels.text.stroke", "stylers": [ { "color": "#e9e5dc" }, { "lightness": "30" } ] }, { "featureType": "transit.line", "elementType": "geometry", "stylers": [ { "visibility": "on" }, { "lightness": "100" } ] }, { "featureType": "water", "elementType": "all", "stylers": [ { "color": "#d2e7f7" } ] } ]');
                    },
                    onCameraMoveStarted: () {
                      // notify map is moving
                      mapPickerController.mapMoving!();
                      ctlRecherche.departTC.text = ""; //TODO BE CAREFULL
                      textController.text = "recherche en cours ...";
                    },
                    onCameraMove: (cameraPosition) {
                      ctlHome.cameraPosition.value = cameraPosition;
                    },
                    onCameraIdle: () async {
                      // notify map stopped moving
                      mapPickerController.mapFinishedMoving!();

                      //get address name from camera position
                      List<Placemark> originemarks =
                          await placemarkFromCoordinates(
                        ctlRecherche.departGps.value.latitude,
                        ctlRecherche.departGps.value.longitude,
                      );
                      List<Placemark> placemarks =
                          await placemarkFromCoordinates(
                        ctlHome.cameraPosition.value.target.latitude,
                        ctlHome.cameraPosition.value.target.longitude,
                      );

                      // update the ui with the address
                      ctlRecherche.departTC.text =
                          '${originemarks.first.street},${originemarks.first.name}, ${originemarks.first.administrativeArea}';
                      ctlRecherche.arriveeTC.text =
                          '${placemarks.first.street},${placemarks.first.name}, ${placemarks.first.administrativeArea}';
                      textController.text =
                          '${placemarks.first.street},${placemarks.first.name}, ${placemarks.first.administrativeArea}';
                    },
                  ),
                )),
            ctlMapCourse.statuscommand.value == CMDSTATUS.COMMAND_EMPTY
                ? Positioned(
                    top: 12,
                    left: 20.w,
                    // width: MediaQuery.of(context).size.width - 50,
                    // height: 50,
                    child: Container(
                        width: 65.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColor.CGREY),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: TextFormField(
                                maxLines: 2,
                                // textAlign: TextAlign.center,
                                readOnly: true,
                                style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                decoration: InputDecoration(
                                    hintText: "${ctlRecherche.departTC.text}",
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none),
                                controller: textController))),
                  )
                : SizedBox(),
            MENUHAUT(),
            ctlMapCourse.statuscommand.value == CMDSTATUS.COMMAND_PAIEMENT
                ? Positioned(child: PAIEMENTBTN(), top: 70)
                : SizedBox(),
            Align(
              alignment: Alignment.bottomCenter,
              child: (ctlMapCourse.statuscommand.value ==
                          CMDSTATUS.COMMAND_EMPTY ||
                      ctlHome.showbottom.value == true)
                  ? Column(mainAxisSize: MainAxisSize.min, children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 2),
                          child: SizedBox(
                            height: 50,
                            width: 100.w,
                            child: TextButton(
                                child: const Text(
                                  "Commander maintenant",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 19,
                                    // height: 19/19,
                                  ),
                                ),
                                onPressed: () {
                                  if (textController.text.isNotEmpty) {
                                    rechercherSelectiondestination(
                                        context, textController.text);
                                  } else {
                                    Get.snackbar("Recherche destination",
                                        "Veuillez choisir une destion en déplaçant l'icone avant!");
                                  }
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            AppColor.CREDO),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    )))),
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 4),
                          child: BOTTOMGO())
                    ])
                  : MaCourseView(),
            )
          ],
        )));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return await fournirposition();
  }
}
