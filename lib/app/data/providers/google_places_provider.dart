import 'dart:convert';

import 'package:alfred_taxi_client/app/common/app_urls.dart';
import 'package:alfred_taxi_client/app/common/keywords.dart';
import 'package:alfred_taxi_client/app/data/models/google_place_model.dart';
import 'package:alfred_taxi_client/app/data/models/place_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class GooglePlacesProvider {
  Future<List<GooglePlace>> getSuggestion({required input, lang = "fr"}) async {
    List<GooglePlace> _placeList = <GooglePlace>[];

    var baseurl = MAPSURL.MAP_PLACE_URL,
        kPLACES_API_KEY = MAPSKEY.GMKEY,
        sessionToken = Uuid().v1();
    String request =
        '$baseurl?input=$input&language=$lang&components=country:ci&key=$kPLACES_API_KEY&sessiontoken=$sessionToken';

    var response = await http.post(Uri.parse(request));

    if (response.statusCode == 200) {
      _placeList = parseGooglePlaces(response.body);
    } else {
      throw Exception('Failed to load predictions');
    }

    return _placeList;
  }

  Future<PlaceDetail> findPlaceById(String placeid) async {
    var baseurl = MAPSURL.MAP_PLACE_ID_URL, kPLACES_API_KEY = MAPSKEY.GMKEY;
    String request = '$baseurl?place_id=$placeid&key=$kPLACES_API_KEY';
    PlaceDetail _detail = PlaceDetail();

    var response = await http.post(Uri.parse(request));

    return PlaceDetail.fromJson(json.decode(response.body)["result"]);
  }

  ///` Une fonction qui convertit un corps de réponse en une liste<Places>.`
  List<GooglePlace> parseGooglePlaces(responseBody) {
    final parsed =
        json.decode(responseBody)["predictions"].cast<Map<String, dynamic>>();

    return parsed
        .map<GooglePlace>((json) => GooglePlace.fromJson(json))
        .toList();
  }
}
