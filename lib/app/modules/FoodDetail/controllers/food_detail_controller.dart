import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesto/app/data/models/ingredient_model.dart';
import 'package:lesto/app/data/models/plat_model.dart';
import 'package:lesto/app/data/providers/plat_provider.dart';

class FoodDetailController extends GetxController {
  Plat argumentData = Get.arguments;
  final loading = true.obs;
  final pageController = PageController();
  final currentTab = 0.obs;
  var ingredients = <Ingredient>[].obs;

  void changeTab(int index) {
    currentTab.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

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
