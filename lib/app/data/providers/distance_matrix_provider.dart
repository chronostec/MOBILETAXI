import 'package:alfred_taxi_client/app/common/app_urls.dart';
import 'package:alfred_taxi_client/app/common/keywords.dart';
import 'package:alfred_taxi_client/app/data/models/distance_matrix_model.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class DistanceMatrixProvider extends GetConnect {
  Future<DistanceMatrix> getDistanceMatrix({
    origin,
    destination,
  }) async {
    String baseurl = MAPSURL.MAP_DISTANCEMATRIX_URL;
    String mapkey = MAPSKEY.GMKEY;
    var _distanceMat = <DistanceMatrix>[];
    String request =
        '$baseurl?destinations=${destination.latitude}%2C${destination.longitude}&origins=${origin.latitude}%2C${origin.longitude}&language=fr-FR&key=${MAPSKEY.GMKEY}';

    var response = await http.post(Uri.parse(request));
    if (response.statusCode == 200) {
      return DistanceMatrix.fromJson(json.decode(response.body));
    }
    return DistanceMatrix();
  }
}
