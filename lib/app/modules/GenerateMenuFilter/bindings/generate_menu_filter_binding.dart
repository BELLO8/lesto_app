import 'package:get/get.dart';

import '../controllers/generate_menu_filter_controller.dart';

class GenerateMenuFilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenerateMenuFilterController>(
      () => GenerateMenuFilterController(),
    );
  }
}
