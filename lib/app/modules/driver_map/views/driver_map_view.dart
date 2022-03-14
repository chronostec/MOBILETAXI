import 'package:alfred_taxi_driver/app/constants/controllers.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/driver_map_controller.dart';

class DriverMapView extends GetView<DriverMapController> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Obx(
      () => GoogleMap(
        myLocationEnabled: true,
        tiltGesturesEnabled: true,
        scrollGesturesEnabled: true,
        // trafficEnabled: true,
        initialCameraPosition: CameraPosition(
          target: ctlHome.driverGPS.value,
          // tilt: 30,
          // bearing: 90,
          // zoom: 19//ctlHome.testZoom.value,
        ),
        mapType: MapType.normal,

        onMapCreated: (controller) {
          ctlHome.mapController = controller;
          ctlHome.mapController.setMapStyle(
              '[ { "featureType": "all", "elementType": "labels", "stylers": [ { "visibility": "on" } ] }, { "featureType": "all", "elementType": "labels.text.fill", "stylers": [ { "saturation": 36 }, { "color": "#000000" }, { "lightness": 40 } ] }, { "featureType": "all", "elementType": "labels.text.stroke", "stylers": [ { "visibility": "on" }, { "color": "#000000" }, { "lightness": 16 } ] }, { "featureType": "all", "elementType": "labels.icon", "stylers": [ { "visibility": "off" } ] }, { "featureType": "administrative", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" }, { "lightness": 20 } ] }, { "featureType": "administrative", "elementType": "geometry.stroke", "stylers": [ { "color": "#000000" }, { "lightness": 17 }, { "weight": 1.2 } ] }, { "featureType": "administrative.country", "elementType": "labels.text.fill", "stylers": [ { "color": "#e5c163" } ] }, { "featureType": "administrative.locality", "elementType": "labels.text.fill", "stylers": [ { "color": "#c4c4c4" } ] }, { "featureType": "administrative.neighborhood", "elementType": "labels.text.fill", "stylers": [ { "color": "#e5c163" } ] }, { "featureType": "landscape", "elementType": "geometry", "stylers": [ { "color": "#000000" }, { "lightness": 20 } ] }, { "featureType": "landscape.natural.terrain", "elementType": "all", "stylers": [ { "visibility": "on" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#000000" }, { "lightness": 21 }, { "visibility": "on" } ] }, { "featureType": "poi.business", "elementType": "geometry", "stylers": [ { "visibility": "on" } ] }, { "featureType": "road.highway", "elementType": "geometry.fill", "stylers": [ { "color": "#e5c163" }, { "lightness": "0" } ] }, { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [ { "visibility": "off" } ] }, { "featureType": "road.highway", "elementType": "labels.text.fill", "stylers": [ { "color": "#ffffff" } ] }, { "featureType": "road.highway", "elementType": "labels.text.stroke", "stylers": [ { "color": "#e5c163" } ] }, { "featureType": "road.arterial", "elementType": "geometry", "stylers": [ { "color": "#000000" }, { "lightness": 18 } ] }, { "featureType": "road.arterial", "elementType": "geometry.fill", "stylers": [ { "color": "#575757" } ] }, { "featureType": "road.arterial", "elementType": "labels.text.fill", "stylers": [ { "color": "#ffffff" } ] }, { "featureType": "road.arterial", "elementType": "labels.text.stroke", "stylers": [ { "color": "#2c2c2c" } ] }, { "featureType": "road.local", "elementType": "geometry", "stylers": [ { "color": "#000000" }, { "lightness": 16 } ] }, { "featureType": "road.local", "elementType": "labels.text.fill", "stylers": [ { "color": "#999999" } ] }, { "featureType": "transit", "elementType": "all", "stylers": [ { "visibility": "on" } ] }, { "featureType": "transit", "elementType": "geometry", "stylers": [ { "color": "#000000" }, { "lightness": 19 } ] }, { "featureType": "water", "elementType": "geometry", "stylers": [ { "color": "#000000" }, { "lightness": 17 } ] } ]');
          ctlHome.onMapCreated(controller);
        },
        polylines: Set<Polyline>.of(ctlDrivermap.polylines.values),
        markers: Set<Marker>.of(ctlDrivermap.markers),
      ),
    ));
  }
}
