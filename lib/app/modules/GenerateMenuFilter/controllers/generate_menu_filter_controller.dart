import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lesto/app/data/Models/ingredient_model.dart';
import 'package:lesto/app/data/Models/menu_model.dart';
import 'package:lesto/app/data/providers/menu_provider.dart';
import 'package:lesto/app/data/providers/plat_provider.dart';
import 'package:lesto/app/routes/app_pages.dart';

class GenerateMenuFilterController extends GetxController {
  //TODO: Implement GenerateMenuFilterController
  final pageController = PageController();
  final isLastPage = false.obs;
  final isFirstPage = true.obs;
  final currentPage = 0.obs;
  var ingredientListe = <Ingredient>[].obs;
  var loading = true.obs;
  var generateMenu = <Dish>[].obs;
  final storeMenu = GetStorage();
  final state = false.obs;
  var arraySelectItem = <String>[].obs;
  final selectItem = "".obs;
  var arrayKitchen = <String>[].obs;

  List<Map<dynamic, dynamic>> type = [
    {
      'id': 1,
      'icon': 'https://cdn.hugeicons.com/icons/oven-stroke-rounded.svg',
      'label': 'Four',
    },
    {
      'id': 2,
      'icon': "https://cdn.hugeicons.com/icons/microwave-stroke-rounded.svg",
      'label': 'Micro-Onde',
    },
    {
      'id': 3,
      'icon': "https://cdn.hugeicons.com/icons/pan-03-stroke-rounded.svg",
      'label': 'Poêle',
    },
    {
      'id': 4,
      'icon': "https://cdn.hugeicons.com/icons/beater-stroke-rounded.svg",
      'label': 'Mixeur',
    },
    {
      'id': 5,
      'icon': "https://cdn.hugeicons.com/icons/refrigerator-stroke-rounded.svg",
      'label': 'Réfrigérateur',
    },
  ];

  @override
  void onInit() {
    super.onInit();
    getAllIngredients();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getAllIngredients() async {
    try {
      loading.value = true;
      ingredientListe.value = await PlatProvider().getAllIngredients();
    } finally {
      loading.value = false;
    }
  }

  Future<void> getMenu(int id, String dateDebut, String dateFin) async {
    loading.value = true;
    generateMenu.value = await MenuProvider().getMenu(id, dateDebut, dateFin);
    storeMenu.write('menu', generateMenu);
    storeMenu.write('menuDate', DateTime.now());
    Get.toNamed(Routes.GENERATE_MENU);
  }

  void checked() {
    arraySelectItem.contains(selectItem.value)
        ? arraySelectItem.remove(selectItem.value)
        : arraySelectItem.add(selectItem.value);
  }

  void checkedKitchenItem() {
    arrayKitchen.contains(selectItem.value)
        ? arrayKitchen.remove(selectItem.value)
        : arrayKitchen.add(selectItem.value);
  }
}
