import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lesto/app/data/models/ingredient_model.dart';
import 'package:lesto/app/data/models/menu_model.dart';
import 'package:lesto/app/data/models/plat_model.dart';
import 'package:lesto/app/data/constants/colors/color_primary.dart';
import 'package:lesto/app/data/constants/contents/mock_data.dart';
import 'package:lesto/app/data/providers/menu_provider.dart';
import 'package:lesto/app/data/providers/plat_provider.dart';
import 'package:lesto/app/routes/app_pages.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final search = TextEditingController();
  final prohibition = TextEditingController();
  final storeMenu = GetStorage();
  var currentIndex = 0.obs; // Onglet Courses sélectionné par défaut
  var selectedDay = 'Lun'.obs;
  var numberOfPeople = 2.obs;
  var ingredientListe = <Ingredient>[].obs;

  // État des checkboxes pour la liste de courses
  final shoppingItems = MockData.shoppingItems.obs;

  final List<String> days = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];

  final weeklyMenus = MockData.weeklyMenus.obs;

  var platList = <Plat>[].obs;
  var platbyDay = <Plat>[].obs;
  var searchPlatList = <Plat>[].obs;
  var isloading = true.obs;
  var loading = true.obs;
  var dateDebut = "Date de début".obs;
  var dateFin = "Date de fin".obs;
  var generateMenu = <Dish>[].obs;
  var generateMenuStore = <Dish>[].obs;
  var historyMenus = <List<Dish>>[].obs;

  // Variables for GenerateRecipe
  var selectedIngredients = <String>[].obs;
  var selectedPersons = 2.obs;
  var selectedPeriod = '1 day'.obs;
  var selectedAllergies = <String>[].obs;
  var selectedCookingTime = '15-30 min'.obs;
  var selectedDifficulty = 'Easy'.obs;
  var selectedCuisineType = 'Asian'.obs;
  var searchQuery = ''.obs;
  var filteredIngredients = <Ingredient>[].obs;

  void searchIngredients(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredIngredients.value = ingredientListe;
    } else {
      filteredIngredients.value = ingredientListe
          .where((ingredient) =>
              ingredient.nom.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  @override
  void onInit() {
    super.onInit();
    filteredIngredients.value = ingredientListe;
    loadHistory();
    getPlat();
    getAllIngredients();
  }

  void loadHistory() {
    String? storedHistory = storeMenu.read('historyMenus');
    if (storedHistory != null) {
      try {
        List<dynamic> list = jsonDecode(storedHistory);
        historyMenus.value = list.map((e) {
          return (e as List).map((i) => Dish.fromJson(i)).toList();
        }).toList();
      } catch (e) {
        print('Error loading history: $e');
        historyMenus.value = [];
      }
    }
  }

  Future<void> getPlat() async {
    try {
      loading.value = true;
      platList.value = await PlatProvider().getPlats();
    } finally {
      loading.value = false;
    }
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
    try {
      final DateTime debut = DateTime.parse(dateDebut);
      final DateTime fin = DateTime.parse(dateFin);
      if (dateDebut == "Date de début" && dateFin == "Date de fin") {
        Get.snackbar('Date invalide', 'Selectionnez une date valide',
            backgroundColor: PrimaryColor.primary500, colorText: Colors.white);
      } else {
        var newMenu = await MenuProvider().getMenu(id, debut, fin);
        generateMenu.value = newMenu;

        // Save to history (at the beginning)
        historyMenus.insert(0, newMenu);

        // Persist history as JSON string
        final historyJson = jsonEncode(historyMenus
            .map((e) => e.map((i) => i.toJson()).toList())
            .toList());
        storeMenu.write('historyMenus', historyJson);

        // Store current generation
        final menuJson =
            jsonEncode(generateMenu.map((e) => e.toJson()).toList());
        storeMenu.write('menu', menuJson);
        storeMenu.write('menuDate', DateTime.now().toIso8601String());

        Get.toNamed(Routes.GENERATE_MENU);
      }
    } finally {
      loading.value = false;
    }
  }

  void searchPlat(String name) async {
    try {
      isloading.value = true;
      searchPlatList.value = await PlatProvider().searchPlats(name);
    } finally {
      isloading.value = false;
    }
  }

  void selectedDate(String date) {
    dateDebut.value = date;
  }

  void selectedDateFin(String date) {
    dateFin.value = date;
  }

  getPlatsByDate(date) {
    if (storeMenu.read('menu') != null) {
      generateMenuStore.value = storeMenu.read('menu');
      for (var jour in storeMenu.read('menu')) {
        if (jour.date == date) {
          return generateMenuStore.value = [jour];
        }
      }
    } else {
      return generateMenuStore.value = [];
    }
    return generateMenuStore.value = [];
  }

  void removeIngredient(String ingredient) {
    selectedIngredients.remove(ingredient);
  }

  void toggleIngredient(String ingredient) {
    if (selectedIngredients.contains(ingredient)) {
      selectedIngredients.remove(ingredient);
    } else {
      selectedIngredients.add(ingredient);
    }
  }

  // Methods for other selections
  void updatePersons(int value) {
    if (value >= 1 && value <= 10) {
      selectedPersons.value = value;
    }
  }

  void updatePeriod(String period) {
    selectedPeriod.value = period;
  }

  void updateDateDebut(String date) {
    dateDebut.value = date;
  }

  void updateDateFin(String date) {
    dateFin.value = date;
  }

  void toggleAllergy(String allergy) {
    if (selectedAllergies.contains(allergy)) {
      selectedAllergies.remove(allergy);
    } else {
      selectedAllergies.add(allergy);
    }
  }

  void updateCuisineType(String type) {
    selectedCuisineType.value = type;
  }
}
