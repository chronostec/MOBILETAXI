import 'package:get/get.dart';

import '../vehicule_model.dart';

class VehiculeProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Vehicule.fromJson(map);
      if (map is List)
        return map.map((item) => Vehicule.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Vehicule?> getVehicule(int id) async {
    final response = await get('vehicule/$id');
    return response.body;
  }

  Future<Response<Vehicule>> postVehicule(Vehicule vehicule) async =>
      await post('vehicule', vehicule);
  Future<Response> deleteVehicule(int id) async => await delete('vehicule/$id');

  /* String path = userSelectedImagePath;
    Map<String, String> data = {
      "name": firstName!,
      "email": userEmail!
    };
   

    String token = await LocaldbHelper().getToken();
    Map<String, String> headers = {
      'X-Requested-With': 'XMLHttpRequest',
      'authorization': 'Bearer $token',
    };


   var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiUrl.updateProfile),
      );
      request.fields.addAll(data);
      request.headers.addAll(headers);
      var multipartFile = await http.MultipartFile.fromPath(
          'avatar', path); //returns a Future<MultipartFile>
      request.files.add(multipartFile);
      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      var jsonData = jsonDecode(respStr);
      if (response.statusCode == 200) {
        // success
      } else {
        // error
      } */
}
