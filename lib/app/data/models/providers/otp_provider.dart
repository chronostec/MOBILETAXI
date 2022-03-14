import 'package:get/get.dart';

import '../otp_model.dart';

class OtpProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Otp.fromJson(map);
      if (map is List) return map.map((item) => Otp.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Otp?> getOtp(int id) async {
    final response = await get('otp/$id');
    return response.body;
  }

  Future<Response<Otp>> postOtp(Otp otp) async => await post('otp', otp);
  Future<Response> deleteOtp(int id) async => await delete('otp/$id');
}
