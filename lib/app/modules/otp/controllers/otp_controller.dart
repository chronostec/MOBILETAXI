import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';

class OtpController extends GetxController {
  OtpFieldController phoneTC = OtpFieldController();

  final phoneNumber = "".obs;
  final isComplete = false.obs;
  final isDowntime = false.obs;

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
}
