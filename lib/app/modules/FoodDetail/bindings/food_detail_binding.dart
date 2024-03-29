import 'package:get/get.dart';

import '../controllers/food_detail_controller.dart';

class FoodDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodDetailController>(
      () => FoodDetailController(),
    );
  }
}
