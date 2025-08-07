import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lesto/app/data/Models/menu_model.dart';

class GenerateMenuController extends GetxController {
  final argumentData = GetStorage();
  var generateMenu = <Dish>[].obs;
  var isLoading = true.obs;
  var selectedDay = 'Lun'.obs;
  var numberOfPeople = 2.obs;

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

  @override
  void onInit() {
    super.onInit();
    getMenu();
  }

  void getMenu() {
    isLoading.value = false;
    generateMenu.value = argumentData.read("menu");
  }
}
