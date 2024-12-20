import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodDetailController extends GetxController {
  //TODO: Implement FoodDetailController
  // Plat argumentData = Get.arguments;
  var argumentData = Get.arguments;
  final count = 0.obs;
  final pageController = PageController();
  List ingredients = [
    {'id': 1, 'name': "Semoule d'attiéké", 'quantity': '1.5kg'},
    {'id': 2, 'name': "Poisson entier ", 'quantity': '1.5kg'},
    {'id': 3, 'name': "Huile", 'quantity': '1.5L'},
    {'id': 4, 'name': "Tomates fraiches", 'quantity': '3'},
    {'id': 6, 'name': 'Oignons', 'quantity': '4'},
    {'id': 7, 'name': "Sel", 'quantity': '5g'},
    {'id': 8, 'name': "Vinaigre", 'quantity': '1/2L'},
  ];

  void increment() => count.value++;
}
