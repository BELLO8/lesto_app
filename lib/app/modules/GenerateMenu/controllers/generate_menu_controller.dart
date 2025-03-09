import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lesto/app/data/Models/menu_model.dart';

import '../../../data/constants/Image/image_constant.dart';

class GenerateMenuController extends GetxController {
  final argumentData = GetStorage();
  final scrollController = ScrollController();
  var generateMenu = <Dish>[].obs;
  var isLoading = true.obs;
  Map<int, String> dayOfWeek = {
    1: 'Lundi',
    2: 'Mardi',
    3: 'Mercredi',
    4: 'Jeudi',
    5: 'Vendredi',
    6: 'Samedi',
    7: 'Dimanche',
  };

  List<Map<String, dynamic>> menusGenerate = [
    {
      'id': 1,
      'day': 'Lundi',
      'menu': [
        {
          'img': ImageString.food2,
          'timing': '2 h 30 min',
          'time': 'midi',
          'foodName': 'Sauce gouagouassou',
          'level': 'Difficultés: Moyen',
          'description':
              'Oignons frais, daurades fraîches à couper en 2 morceaux égaux...'
        },
        {
          'img': ImageString.food3,
          'timing': '1 h 50 min',
          'time': 'midi',
          'foodName': 'Placali sauce gombo',
          'level': 'Difficultés: Moyen',
          'description':
              'Placez les morceaux de gombos dans un mixeur et réduisez-les en petits'
        },
      ]
    },
    {
      'id': 2,
      'day': 'Mardi',
      'menu': [
        {
          'img': ImageString.food2,
          'timing': '2 h 30 min',
          'time': 'midi',
          'foodName': 'Sauce gouagouassou',
          'level': 'Difficultés: Moyen',
          'description':
              'Oignons frais, daurades fraîches à couper en 2 morceaux égaux...'
        },
        {
          'img': ImageString.food3,
          'timing': '1 h 50 min',
          'time': 'midi',
          'foodName': 'Placali sauce gombo',
          'level': 'Difficultés: Moyen',
          'description':
              'Placez les morceaux de gombos dans un mixeur et réduisez-les en petits'
        },
      ]
    },
    {
      'id': 3,
      'day': 'Mercredi',
      'menu': [
        {
          'img': ImageString.food2,
          'timing': '2 h 30 min',
          'time': 'midi',
          'foodName': 'Sauce gouagouassou',
          'level': 'Difficultés: Moyen',
          'description':
              'Oignons frais, daurades fraîches à couper en 2 morceaux égaux...'
        },
        {
          'img': ImageString.food3,
          'timing': '1 h 50 min',
          'time': 'midi',
          'foodName': 'Placali sauce gombo',
          'level': 'Difficultés: Moyen',
          'description':
              'Placez les morceaux de gombos dans un mixeur et réduisez-les en petits'
        },
      ]
    },
  ];
  List days = [
    {'day': 'Lundi', 'index': 1},
    {'day': 'Mardi', 'index': 2},
    {'day': 'Mercredi', 'index': 3},
    {'day': 'Jeudi', 'index': 4},
    {'day': 'Vendredi', 'index': 5},
    {'day': 'Samedi', 'index': 6},
    {'day': 'Dimanche', 'index': 7},
  ];

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
