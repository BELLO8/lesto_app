import 'package:get/get.dart';

import 'package:lesto/app/data/providers/plat_provider.dart';
import '../controllers/generate_menu_controller.dart';

class GenerateMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlatProvider>(
      () => PlatProvider(),
    );
    Get.lazyPut<GenerateMenuController>(
      () => GenerateMenuController(),
    );
  }
}
