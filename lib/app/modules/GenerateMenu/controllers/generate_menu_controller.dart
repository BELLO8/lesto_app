import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lesto/app/data/models/ingredient_model.dart';
import 'package:lesto/app/data/models/menu_model.dart';
import 'package:lesto/app/data/providers/plat_provider.dart';

class GenerateMenuController extends GetxController {
  final argumentData = GetStorage();
  var generateMenu = <Dish>[].obs;
  var isLoading = true.obs;
  var selectedDay = ''.obs;
  var numberOfPeople = 2.obs;

  final PlatProvider _platProvider = Get.find<PlatProvider>();
  var shoppingList = <Ingredient>[].obs;
  var isAggregating = false.obs;

  List<PlatMenu> get selectedDayPlats {
    if (selectedDay.value.isEmpty || generateMenu.isEmpty) return [];
    try {
      final dish = generateMenu.firstWhere((d) => d.name == selectedDay.value);
      return dish.plats;
    } catch (e) {
      return [];
    }
  }

  @override
  void onInit() {
    super.onInit();
    getMenu();
  }

  void getMenu() {
    isLoading.value = false;

    // Check if a specific menu was passed as an argument
    if (Get.arguments != null && Get.arguments is List<Dish>) {
      generateMenu.value = Get.arguments as List<Dish>;
      if (generateMenu.isNotEmpty) {
        selectedDay.value = generateMenu.first.name;
      }
      return;
    }

    // Fallback to latest stored menu
    String? storedMenu = argumentData.read("menu");
    if (storedMenu != null) {
      try {
        List<dynamic> list = jsonDecode(storedMenu);
        generateMenu.value = list.map((e) => Dish.fromJson(e)).toList();
        if (generateMenu.isNotEmpty) {
          selectedDay.value = generateMenu.first.name;
        }
      } catch (e) {
        print('Error parsing menu: $e');
        generateMenu.value = [];
      }
    }
  }

  Future<void> aggregateIngredients() async {
    isAggregating.value = true;
    Map<String, Ingredient> aggregated = {};

    try {
      for (var dish in generateMenu) {
        for (var plat in dish.plats) {
          final ingredients = await _platProvider.getPlatsIngredients(plat.id);
          for (var ing in ingredients) {
            if (aggregated.containsKey(ing.nom)) {
              // Simple aggregation: try to add quantities if they are numeric
              // For now, we'll just keep the first one or append if needed
              // In a real app, unit conversion would happen here
            } else {
              aggregated[ing.nom] = ing;
            }
          }
        }
      }
      shoppingList.value = aggregated.values.toList();
    } catch (e) {
      print('Error aggregating ingredients: $e');
    } finally {
      isAggregating.value = false;
    }
  }
}
