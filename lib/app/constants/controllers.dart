import 'package:fredy_proprio/app/data/services/helper.dart';
import 'package:fredy_proprio/app/modules/changepassword/controllers/changepassword_controller.dart';
import 'package:fredy_proprio/app/modules/changernewpassword/controllers/changernewpassword_controller.dart';
import 'package:fredy_proprio/app/modules/dashboard/children/rapportactivite/controllers/rapportactivite_controller.dart';
import 'package:fredy_proprio/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:fredy_proprio/app/modules/driver/controllers/driver_controller.dart';
import 'package:fredy_proprio/app/modules/finance/children/repport/controllers/repport_controller.dart';
import 'package:fredy_proprio/app/modules/finance/controllers/finance_controller.dart';
import 'package:fredy_proprio/app/modules/home/controllers/home_controller.dart';
import 'package:fredy_proprio/app/modules/newpassword/controllers/newpassword_controller.dart';
import 'package:fredy_proprio/app/modules/otp/controllers/otp_controller.dart';
import 'package:fredy_proprio/app/modules/rechargement/controllers/rechargement_controller.dart';
import 'package:fredy_proprio/app/modules/resetpass/controllers/resetpass_controller.dart';
import 'package:fredy_proprio/app/modules/reversement/controllers/reversement_controller.dart';
import 'package:fredy_proprio/app/modules/setting/controllers/setting_controller.dart';
import 'package:fredy_proprio/app/modules/signin/controllers/signin_controller.dart';
import 'package:fredy_proprio/app/modules/signup/controllers/signup_controller.dart';
import 'package:fredy_proprio/app/modules/vehicule/controllers/vehicule_controller.dart';
import 'package:get/get.dart';

import '../modules/oldpassword/controllers/oldpassword_controller.dart';

HomeController ctlHome = Get.put(HomeController());
DashboardController ctlDashboard = Get.put(DashboardController());
DriverController ctlDriver = Get.put(DriverController());
SigninController ctlSignin = Get.put(SigninController());
SignupController ctlSignup = Get.put(SignupController());
OldpasswordController ctlOldpassword = Get.put(OldpasswordController());
NewpasswordController ctlNewpassword = Get.put(NewpasswordController());
ResetpassController ctlresetpassword = Get.put(ResetpassController());
ChangepasswordController ctlchangerpassword =
    Get.put(ChangepasswordController());
ChangernewpasswordController ctlchangernewpassword =
    Get.put(ChangernewpasswordController());
OtpController ctlOtp = Get.put(OtpController());
VehiculeController ctlVehicule = Get.put(VehiculeController());
SettingController ctlSetting = Get.put(SettingController());
FinanceController ctlFinance = Get.put(FinanceController());
RepportController ctlReport = Get.put(RepportController());
RapportactiviteController ctlRapportActivite =
    Get.put(RapportactiviteController());
Helper helper = Get.put(Helper());
ReversementController ctlReversement = Get.put(ReversementController());
RechargementController ctlRechargement = Get.put(RechargementController());
