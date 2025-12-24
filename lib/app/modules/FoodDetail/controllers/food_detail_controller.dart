import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesto/app/data/models/ingredient_model.dart';
import 'package:lesto/app/data/models/plat_model.dart';
import 'package:lesto/app/data/models/menu_model.dart';
import 'package:lesto/app/data/providers/plat_provider.dart';

class FoodDetailController extends GetxController {
  dynamic argumentData = Get.arguments;
  final loading = true.obs;
  final pageController = PageController();
  final currentTab = 0.obs;
  var ingredients = <Ingredient>[].obs;

  String get nom {
    if (argumentData is Plat) return (argumentData as Plat).nom;
    if (argumentData is PlatMenu) return (argumentData as PlatMenu).libelle;
    return "Plat inconnu";
  }

  String get duree {
    if (argumentData is Plat) return (argumentData as Plat).duree;
    if (argumentData is PlatMenu) return (argumentData as PlatMenu).duree;
    return "0 min";
  }

  String get image {
    if (argumentData is Plat) return (argumentData as Plat).image;
    if (argumentData is PlatMenu) return (argumentData as PlatMenu).image;
    return "";
  }

  String get description {
    if (argumentData is Plat) return (argumentData as Plat).description;
    if (argumentData is PlatMenu) return (argumentData as PlatMenu).description;
    return "Aucune description";
  }

  String get level {
    if (argumentData is Plat) return (argumentData as Plat).level;
    if (argumentData is PlatMenu) return (argumentData as PlatMenu).level;
    return "Facile";
  }

  int get id {
    if (argumentData is Plat) return (argumentData as Plat).id;
    if (argumentData is PlatMenu) return (argumentData as PlatMenu).id;
    return 0;
  }

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
      ingredients.value = await PlatProvider().getPlatsIngredients(id);
    } finally {
      loading.value = false;
    }
  }
}
