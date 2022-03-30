import 'package:get/get.dart';

import '../modules/aide/bindings/aide_binding.dart';
import '../modules/aide/views/aide_view.dart';
import '../modules/authentication/bindings/authentication_binding.dart';
import '../modules/authentication/views/authentication_view.dart';
import '../modules/chatbox/bindings/chatbox_binding.dart';
import '../modules/chatbox/views/chatbox_view.dart';
import '../modules/commande/bindings/commande_binding.dart';
import '../modules/commande/views/commande_driving_view.dart';
import '../modules/driver_map/bindings/driver_map_binding.dart';
import '../modules/driver_map/views/driver_map_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/parametres/bindings/parametres_binding.dart';
import '../modules/parametres/views/parametres_view.dart';
import '../modules/payment/bindings/payment_binding.dart';
import '../modules/payment/views/payment_view.dart';
import '../modules/phoneauth/bindings/phoneauth_binding.dart';
import '../modules/phoneauth/views/phoneauth_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/rechargement/bindings/rechargement_binding.dart';
import '../modules/rechargement/views/rechargement_view.dart';
import '../modules/recovery/bindings/recovery_binding.dart';
import '../modules/recovery/views/recovery_view.dart';
import '../modules/resetpwd/bindings/resetpwd_binding.dart';
import '../modules/resetpwd/views/resetpwd_view.dart';
import '../modules/service_client/bindings/service_client_binding.dart';
import '../modules/service_client/views/service_client_view.dart';
import '../modules/signin/bindings/signin_binding.dart';
import '../modules/signin/views/signin_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/support/bindings/support_binding.dart';
import '../modules/support/views/support_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.AUTHENTICATION;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(
        gmapStyle: "",
      ),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTHENTICATION,
      page: () => AuthenticationView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: _Paths.COMMANDE,
      page: () => CommandeView(),
      binding: CommandeBinding(),
    ),
    GetPage(
      name: _Paths.CHATBOX,
      page: () => ChatboxView(),
      binding: ChatboxBinding(),
    ),
    GetPage(
      name: _Paths.RECOVERY,
      page: () => RecoveryView(),
      binding: RecoveryBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.SUPPORT,
      page: () => SupportView(),
      binding: SupportBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.AIDE,
      page: () => AideView(),
      binding: AideBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE_CLIENT,
      page: () => ServiceClientView(),
      binding: ServiceClientBinding(),
    ),
    GetPage(
      name: _Paths.PARAMETRES,
      page: () => ParametresView(),
      binding: ParametresBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER_MAP,
      page: () => DriverMapView(),
      binding: DriverMapBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => SigninView(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: _Paths.RESETPWD,
      page: () => ResetpwdView(),
      binding: ResetpwdBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.PHONEAUTH,
      page: () => PhoneauthView(),
      binding: PhoneauthBinding(),
    ),
    GetPage(
      name: _Paths.RECHARGEMENT,
      page: () => RechargementView(),
      binding: RechargementBinding(),
    ),
  ];
}
