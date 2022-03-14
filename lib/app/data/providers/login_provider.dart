import 'dart:convert';

import 'package:alfred_taxi_client/app/common/app_urls.dart';
import 'package:alfred_taxi_client/app/data/models/otp_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginProvider extends GetConnect {
  postLogin(
      {required client_numero,
      required code_langue,
      required code_materiel}) async {
    var url = APPURL.BASE_URL +
        APPURL.LOGIN_PHONE_URL +
        "client_numero=$client_numero&code_langue=$code_langue";

    await http.post(Uri.parse(url));

    return true;
  }

  Future<Otp> postOTP({required numero_client, required otp}) async {
    var url = APPURL.BASE_URL +
        APPURL.LOGIN_OTP_URL +
        "numero_client=$numero_client&code_otp=$otp";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Otp.fromJson(json.decode(response.body));
    } else {
      return Otp();
    }
  }

  Otp parseOtpModel(responseBody) {
    final parsed = json.decode(responseBody);

    return Otp.fromJson(json.decode(responseBody));
  }
}
