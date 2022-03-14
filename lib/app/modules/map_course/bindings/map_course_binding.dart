import 'package:get/get.dart';

import '../controllers/map_course_controller.dart';

class MapCourseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapCourseController>(
      () => MapCourseController(),
    );
  }
}
