import 'package:get/get.dart';

import '../controllers/ma_course_controller.dart';

class MaCourseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MaCourseController>(
      () => MaCourseController(),
    );
  }
}
