import 'package:get/get.dart';

import '../controllers/chatbox_controller.dart';

class ChatboxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatboxController>(
      () => ChatboxController(),
    );
  }
}
