import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/data/models/otp_model.dart';
import 'package:alfred_taxi_client/app/data/models/user_model.dart';
import 'package:alfred_taxi_client/app/data/providers/providers.dart'
    show provLogin;
import 'package:alfred_taxi_client/app/data/services/local_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class LoginController extends GetxController {
  final isRequesting = false.obs;
  final isPhoneSending = false.obs;
  final isCodeSending = false.obs;
  final isOTPview = false.obs;

  final codeDigit = '+225'.obs;
  final phoneNumber = ''.obs;

  TextEditingController phoneTF = TextEditingController();
  final initialCountry = 'CI'.obs;
  final number = PhoneNumber(isoCode: 'CI').obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  /// ENVOYER TELEPHONE
  envoyerTelephone() async {
    isPhoneSending.value = true;
    isOTPview.value = false;

    var resultat = await provLogin.postLogin(
      client_numero: phoneNumber.value,
      code_langue: ctlHome.defaultLanguage.value
          .toString()
          .toLowerCase()
          .substring(0, 2),
      code_materiel: ctlHome.deviceInfo.value.toString(),
    );
    isPhoneSending.value = false;
    isOTPview.value = true;

    return resultat;
  }

  /// ENVOYER CODE OTP
  Future<Otp> envoyerCodeOTP({required pin}) async {
    // assert(pin != "0000");
    isCodeSending.value = true;
    var res = Otp();
    var resultat =
        await provLogin.postOTP(numero_client: phoneNumber, otp: pin);

    if (resultat.message == "succes") {
      print("MESABO ID: ${resultat.objet![0].iDClient}");

      LocalStorage().saveUserData(User(
        id: resultat.objet![0].iDClient,
        telephone: phoneNumber.value,
        status: true,
        language: ctlHome.defaultLanguage.value,
        materiel: ctlHome.deviceInfo.value,
        gpsLatitude: ctlRecherche.detailOigine.value.geometry!.location!.lat,
        gpsLongitude: ctlRecherche.detailOigine.value.geometry!.location!.lng,
      ));
    }
    ctlHome.verifierIdentite();
    Get.back();
    isCodeSending.value = false;

    return res;
  }
}
