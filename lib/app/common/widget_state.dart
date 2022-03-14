import 'package:get/state_manager.dart';

class WidgetState extends GetxController {
  RxBool SHOW_SEARCH_BOTTOM = false.obs;
  RxBool SHOW_FAB = false.obs;
  RxBool SHOW_CATEGORY = false.obs;
  RxBool SHOW_CATEGORY_DETAILS = false.obs;
  RxBool SHOW_WAITING_DRIVER = false.obs;
  RxBool SHOW_DRIVING = false.obs;
  RxBool SHOW_PAIEMENT = false.obs;
}
