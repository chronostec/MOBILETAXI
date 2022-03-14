import 'package:alfred_taxi_driver/app/constants/urls.dart';
import 'package:alfred_taxi_driver/app/utils/keywords.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class DistanceMatrixProvider extends GetConnect {
  getDistanceMatrix({
    origin,
    destination,
  }) async {
    String baseurl = URLS.MAP_DISTANCEMATRIX_URL;
    String mapkey = MAPSKEY.GMKEY;
    var _distance;
    String request =
        '${URLS.MAP_DISTANCEMATRIX_URL}?destinations=${destination.latitude}%2C${destination.longitude}&origins=${origin.latitude}%2C${origin.longitude}&language=fr-FR&key=${MAPSKEY.GMKEY}';

    var response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      _distance = json.decode(response.body)['rows'];
    }

    return _distance;
  }
}
