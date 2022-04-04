import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/driver_map_controller.dart';

class DrivingMapView extends GetView<DriverMapController> {
  const DrivingMapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GoogleMap(
        myLocationEnabled: false,
        trafficEnabled: true,
        tiltGesturesEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: false,
        initialCameraPosition: CameraPosition(
          target: ctlHome.driverGPS.value,
          // tilt: 30,
          // bearing: 120,
          // zoom:19//ctlHome. testZoom.value,
        ),
        mapType: MapType.normal,
        onMapCreated: (controller) {
          ctlHome.mapController = controller;
          ctlHome.mapController.setMapStyle(
              '[ { "featureType": "administrative", "elementType": "all", "stylers": [ { "saturation": "-100" } ] }, { "featureType": "administrative.province", "elementType": "all", "stylers": [ { "visibility": "off" } ] }, { "featureType": "landscape", "elementType": "all", "stylers": [ { "saturation": -100 }, { "lightness": 65 }, { "visibility": "on" } ] }, { "featureType": "poi", "elementType": "all", "stylers": [ { "saturation": -100 }, { "lightness": "50" }, { "visibility": "simplified" } ] }, { "featureType": "poi.attraction", "elementType": "all", "stylers": [ { "visibility": "on" } ] }, { "featureType": "poi.attraction", "elementType": "geometry.fill", "stylers": [ { "visibility": "off" } ] }, { "featureType": "poi.business", "elementType": "all", "stylers": [ { "visibility": "simplified" } ] }, { "featureType": "road", "elementType": "all", "stylers": [ { "saturation": "-100" } ] }, { "featureType": "road.highway", "elementType": "all", "stylers": [ { "visibility": "simplified" } ] }, { "featureType": "road.arterial", "elementType": "all", "stylers": [ { "lightness": "30" } ] }, { "featureType": "road.local", "elementType": "all", "stylers": [ { "lightness": "40" }, { "visibility": "on" } ] }, { "featureType": "transit", "elementType": "all", "stylers": [ { "saturation": -100 }, { "visibility": "simplified" } ] }, { "featureType": "water", "elementType": "geometry", "stylers": [ { "hue": "#ffff00" }, { "lightness": -25 }, { "saturation": -97 } ] }, { "featureType": "water", "elementType": "labels", "stylers": [ { "lightness": -25 }, { "saturation": -100 } ] } ]');
          ctlHome.onMapCreated(ctlHome.mapController);
        },
        polylines: Set<Polyline>.of(ctlDrivermap.polylines.values),
        markers: Set<Marker>.of(ctlDrivermap.markers),
      ),
    );
  }
}
