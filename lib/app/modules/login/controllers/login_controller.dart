import 'package:alfred_taxi_client/app/common/controllers.dart';
import 'package:alfred_taxi_client/app/data/models/otp_model.dart';
import 'package:alfred_taxi_client/app/data/models/user_model.dart';
import 'package:alfred_taxi_client/app/data/providers/providers.dart'
    show provLogin;
import 'package:alfred_taxi_client/app/data/services/local_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginController extends GetxController with CodeAutoFill {
  final isRequesting = false.obs;
  final isPhoneSending = false.obs;
  final isCodeSending = false.obs;
  final isOTPview = false.obs;

  final codeDigit = '+225'.obs;
  final phoneNumber = ''.obs;
  final smsCode = ''.obs;

  TextEditingController phoneTF = TextEditingController();
  final initialCountry = 'CI'.obs;
  final number = PhoneNumber(isoCode: 'CI').obs;
  RxString appSignature = ''.obs;
  RxString otpCode = ''.obs;

  @override
  void codeUpdated() {
    smsCode.value = otpCode.value;
  }

  @override
  void onInit() async {
    // await SmsAutoFill().listenForCode;
    // SmsAutoFill().getAppSignature.then((signature) {
    //   appSignature.value = signature;
    // });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    SmsAutoFill().unregisterListener();
  }

  /// ENVOYER TELEPHONE
  envoyerTelephone() async {
    isPhoneSending.value = true;
    isOTPview.value = false;

    var resultat = await provLogin.postLogin(
      client_numero: codeDigit.value.substring(1, codeDigit.value.length) +
          phoneNumber.value,
      code_langue: ctlHome.defaultLanguage.value
          .toString()
          .toLowerCase()
          .substring(0, 2),
      code_materiel: ctlHome.deviceInfo.value.toString(),
    );
    isOTPview.value = true;
    isPhoneSending.value = false;
    // await SmsAutoFill().listenForCode;

    return resultat;
  }

  /// ENVOYER CODE OTP
  Future<Otp> envoyerCodeOTP({required pin}) async {
    // assert(pin != "0000");
    isCodeSending.value = true;
    Otp resultat = await provLogin.postOTP(
        numero_client: codeDigit.value.substring(1, codeDigit.value.length) +
            phoneNumber.value,
        otp: pin);

    if (resultat.message == "succes") {
      print("MESABO ID: ${resultat.objet![0].iDClient}");
      LocalStorage().saveUserData(User(
        id: resultat.objet![0].iDClient,
        telephone: codeDigit.value.substring(1, codeDigit.value.length) +
            phoneNumber.value,
        status: true,
        language: ctlHome.defaultLanguage.value,
        materiel: ctlHome.deviceInfo.value,
        gpsLatitude: ctlRecherche.detailOigine.value.geometry!.location!.lat,
        gpsLongitude: ctlRecherche.detailOigine.value.geometry!.location!.lng,
      ));
    } else if (resultat.bSuccess == false) {
      smsCode.value = "";
    }
    print("VERIFICATION TERMINEE");
    ctlHome.verifierIdentite();

    isCodeSending.value = false;
    onClose();
    return resultat;
  }
}
