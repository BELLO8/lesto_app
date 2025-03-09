import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesto/app/data/Models/ingredient_model.dart';
import 'package:lesto/app/data/Models/plat_model.dart';
import 'package:lesto/app/data/providers/plat_provider.dart';

class FoodDetailController extends GetxController {
  Plat argumentData = Get.arguments;
  final loading = true.obs;
  final pageController = PageController();
  var ingredients = <Ingredient>[].obs;

  @override
  void onInit() {
    super.onInit();
    getIngredient();
  }

  Future<void> getIngredient() async {
    try {
      loading.value = true;
      ingredients.value =
          await PlatProvider().getPlatsIngredients(argumentData.id);
    } finally {
      loading.value = false;
    }
  }
}
