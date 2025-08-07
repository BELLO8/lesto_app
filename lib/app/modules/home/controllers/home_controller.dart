import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lesto/app/data/Models/ingredient_model.dart';
import 'package:lesto/app/data/Models/menu_model.dart';
import 'package:lesto/app/data/Models/plat_model.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
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
  final Map<String, bool> shoppingItems = {
    'Champignons': false,
    'Tomates': false,
    'Courgettes': false,
    'Poivrons': false,
    'Riz pour risotto': false,
    'Pâtes': false,
    'Quinoa': false,
    'Sauce tomate': false,
    'Pâte de curry': false,
    'Parmesan': false,
    'Crème fraîche': false,
    'Lait de coco': false,
    'Basilic frais': false,
  };

  final List<String> days = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];

  final Map<String, List<Map<String, dynamic>>> weeklyMenus = {
    'Lun': [
      {
        'type': 'Déjeuner',
        'name': 'Risotto aux champignons',
        'cuisine': 'Italien',
        'regime': 'Végétarien',
        'duration': '30 min',
        'icon': Icons.menu_book,
      },
      {
        'type': 'Dîner',
        'name': 'Salade de quinoa aux légumes grillés',
        'cuisine': 'Méditerranéen',
        'regime': 'Végétarien',
        'duration': '20 min',
        'icon': Icons.menu_book,
      },
    ],
    'Mar': [
      {
        'type': 'Déjeuner',
        'name': 'Pasta à la carbonara',
        'cuisine': 'Italien',
        'regime': 'Standard',
        'duration': '25 min',
        'icon': Icons.menu_book,
      },
      {
        'type': 'Dîner',
        'name': 'Saumon grillé aux légumes',
        'cuisine': 'Français',
        'regime': 'Standard',
        'duration': '35 min',
        'icon': Icons.menu_book,
      },
    ],
    'Mer': [
      {
        'type': 'Déjeuner',
        'name': 'Salade César végétarienne',
        'cuisine': 'Américain',
        'regime': 'Végétarien',
        'duration': '15 min',
        'icon': Icons.menu_book,
      },
      {
        'type': 'Dîner',
        'name': 'Curry de légumes',
        'cuisine': 'Indien',
        'regime': 'Végétalien',
        'duration': '40 min',
        'icon': Icons.menu_book,
      },
    ],
    'Jeu': [
      {
        'type': 'Déjeuner',
        'name': 'Quiche aux épinards',
        'cuisine': 'Français',
        'regime': 'Végétarien',
        'duration': '45 min',
        'icon': Icons.menu_book,
      },
      {
        'type': 'Dîner',
        'name': 'Tacos aux haricots noirs',
        'cuisine': 'Mexicain',
        'regime': 'Végétarien',
        'duration': '30 min',
        'icon': Icons.menu_book,
      },
    ],
    'Ven': [
      {
        'type': 'Déjeuner',
        'name': 'Sushi végétarien',
        'cuisine': 'Japonais',
        'regime': 'Végétarien',
        'duration': '50 min',
        'icon': Icons.menu_book,
      },
      {
        'type': 'Dîner',
        'name': 'Pizza margherita',
        'cuisine': 'Italien',
        'regime': 'Végétarien',
        'duration': '25 min',
        'icon': Icons.menu_book,
      },
    ],
    'Sam': [
      {
        'type': 'Déjeuner',
        'name': 'Pancakes aux fruits',
        'cuisine': 'Américain',
        'regime': 'Végétarien',
        'duration': '20 min',
        'icon': Icons.menu_book,
      },
      {
        'type': 'Dîner',
        'name': 'Ratatouille',
        'cuisine': 'Français',
        'regime': 'Végétalien',
        'duration': '60 min',
        'icon': Icons.menu_book,
      },
    ],
    'Dim': [
      {
        'type': 'Déjeuner',
        'name': 'Brunch végétarien',
        'cuisine': 'International',
        'regime': 'Végétarien',
        'duration': '30 min',
        'icon': Icons.menu_book,
      },
      {
        'type': 'Dîner',
        'name': 'Soupe de légumes',
        'cuisine': 'Français',
        'regime': 'Végétalien',
        'duration': '45 min',
        'icon': Icons.menu_book,
      },
    ],
  };

  var platList = <Plat>[].obs;
  var platbyDay = <Plat>[].obs;
  var searchPlatList = <Plat>[].obs;
  var isloading = true.obs;
  var loading = true.obs;
  var dateDebut = "Date de début".obs;
  var dateFin = "Date de fin".obs;
  var generateMenu = <Dish>[].obs;
  var generateMenuStore = <Dish>[].obs;

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
    getPlat();
    getAllIngredients();
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
    final DateTime debut = DateTime.parse(dateDebut);
    final DateTime fin = DateTime.parse(dateFin);
    if (dateDebut == "Date de début" && dateFin == "Date de fin") {
      Get.snackbar('Date invalide', 'Selectionnez une date valide',
          backgroundColor: PrimaryColor.primary500, colorText: Colors.white);
      loading.value = false;
    } else {
      generateMenu.value = await MenuProvider().getMenu(id, debut, fin);
      storeMenu.write('menu', generateMenu);
      storeMenu.write('menuDate', DateTime.now());
      Get.toNamed(Routes.GENERATE_MENU);
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
