import 'package:get/get.dart';

import '../controllers/reversement_controller.dart';

class ReversementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReversementController>(
      () => ReversementController(),
    );
  }
}
