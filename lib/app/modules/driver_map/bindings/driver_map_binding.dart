import 'package:alfred_taxi_driver/app/modules/driver_map/controllers/driver_map_controller.dart';
import 'package:get/get.dart';

class DriverMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverMapController>(
      () => DriverMapController(),
    );
  }
}
