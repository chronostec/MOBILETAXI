import 'dart:ui' as ui;
import 'package:alfred_taxi_client/app/modules/utils/images_path.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';

class AppMarker {
  ///LOCATIONS MARKERS ICONS
  var driverIcon = BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(size: ui.Size(4, 4)),
    AppImage.driver,
  );
  //BitmapDescriptor.defaultMarker;
  var rdvIcon = BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(size: ui.Size(4, 4)),
    AppImage.rdv,
  );
  var destinationIcon = BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(size: ui.Size(4, 4)),
    AppImage.destination,
  );
  var vehiculeIcon = BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(size: ui.Size(4, 4)),
    AppImage.client,
  );
}
