import 'package:alfred_taxi_driver/app/data/models/notifications_model.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  final List<Notifications> notificationList = <Notifications>[
    for (var i = 1; i < 15; i++)
      Notifications(
          id: i,
          titre: "titre $i",
          message:
              "Bonjour, des travaux seront effectués sur l'application cet après midi. Pour plus d'informations, consulter le lien ci-dessous",
          lien: "https://stackoverflow.com/users/8768524/m-e-s-a-b-o",
          date: DateTime.now().toString().substring(0, 19))
  ];

  RxBool unreadNotifications = true.obs;
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
