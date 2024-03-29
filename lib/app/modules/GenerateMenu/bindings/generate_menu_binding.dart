import 'package:get/get.dart';

import '../controllers/generate_menu_controller.dart';

class GenerateMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenerateMenuController>(
      () => GenerateMenuController(),
    );
  }
}
