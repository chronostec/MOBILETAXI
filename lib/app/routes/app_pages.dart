import 'package:get/get.dart';

import '../modules/changepassword/bindings/changepassword_binding.dart';
import '../modules/changepassword/views/changepassword_view.dart';
import '../modules/changernewpassword/bindings/changernewpassword_binding.dart';
import '../modules/changernewpassword/views/changernewpassword_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/children/rapportactivite/bindings/rapportactivite_binding.dart';
import '../modules/dashboard/children/rapportactivite/views/rapportactivite_view.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/driver/bindings/driver_binding.dart';
import '../modules/driver/views/driver_view.dart';
import '../modules/finance/bindings/finance_binding.dart';
import '../modules/finance/children/repport/bindings/repport_binding.dart';
import '../modules/finance/children/repport/bindings/repport_binding.dart';
import '../modules/finance/children/repport/views/repport_view.dart';
import '../modules/finance/children/repport/views/repport_view.dart';
import '../modules/finance/views/finance_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/newpassword/bindings/newpassword_binding.dart';
import '../modules/newpassword/views/newpassword_view.dart';
import '../modules/oldpassword/bindings/oldpassword_binding.dart';
import '../modules/oldpassword/views/oldpassword_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/rechargement/bindings/rechargement_binding.dart';
import '../modules/rechargement/views/rechargement_view.dart';
import '../modules/resetpass/bindings/resetpass_binding.dart';
import '../modules/resetpass/views/resetpass_view.dart';
import '../modules/reversement/bindings/reversement_binding.dart';
import '../modules/reversement/views/reversement_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/children/account/bindings/account_binding.dart';
import '../modules/setting/children/account/views/account_view.dart';
import '../modules/setting/children/badges/bindings/badges_binding.dart';
import '../modules/setting/children/badges/views/badges_view.dart';
import '../modules/setting/children/licenses/bindings/licenses_binding.dart';
import '../modules/setting/children/licenses/views/licenses_view.dart';
import '../modules/setting/children/management/bindings/management_binding.dart';
import '../modules/setting/children/management/views/management_view.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/signin/bindings/signin_binding.dart';
import '../modules/signin/views/signin_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/vehicule/bindings/vehicule_binding.dart';
import '../modules/vehicule/views/vehicule_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SIGNIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
      children: [
        GetPage(
          name: _Paths.RAPPORTACTIVITE,
          page: () => RapportactiviteView(),
          binding: RapportactiviteBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => SigninView(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
      children: [
        GetPage(
          name: _Paths.ACCOUNT,
          page: () => AccountView(),
          binding: AccountBinding(),
        ),
        GetPage(
          name: _Paths.BADGES,
          page: () => BadgesView(),
          binding: BadgesBinding(),
        ),
        GetPage(
          name: _Paths.LICENSES,
          page: () => LicensesView(),
          binding: LicensesBinding(),
        ),
        GetPage(
          name: _Paths.MANAGEMENT,
          page: () => ManagementView(),
          binding: ManagementBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.VEHICULE,
      page: () => VehiculeView(),
      binding: VehiculeBinding(),
    ),
    GetPage(
      name: _Paths.RESETPASS,
      page: () => ResetpassView(),
      binding: ResetpassBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER,
      page: () => const DriverView(),
      binding: DriverBinding(),
    ),
    GetPage(
      name: _Paths.FINANCE,
      page: () => FinanceView(),
      binding: FinanceBinding(),
      children: [
        GetPage(
          name: _Paths.FINANCE,
          page: () => FinanceView(),
          binding: FinanceBinding(),
        ),
        GetPage(
          name: _Paths.REPPORT,
          page: () => RepportView(),
          binding: RepportBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.OLDPASSWORD,
      page: () => OldpasswordView(),
      binding: OldpasswordBinding(),
    ),
    GetPage(
      name: _Paths.NEWPASSWORD,
      page: () => NewpasswordView(),
      binding: NewpasswordBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.CHANGEPASSWORD,
      page: () => ChangepasswordView(),
      binding: ChangepasswordBinding(),
    ),
    GetPage(
      name: _Paths.CHANGERNEWPASSWORD,
      page: () => ChangernewpasswordView(),
      binding: ChangernewpasswordBinding(),
    ),
    GetPage(
      name: _Paths.REVERSEMENT,
      page: () => ReversementView(),
      binding: ReversementBinding(),
    ),
    GetPage(
      name: _Paths.RECHARGEMENT,
      page: () => RechargementView(),
      binding: RechargementBinding(),
    ),
  ];
}
