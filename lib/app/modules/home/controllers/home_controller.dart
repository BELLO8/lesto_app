import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/constants/Image/image_constant.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  final search = TextEditingController();
  final prohibition = TextEditingController();
  List<Map<String, dynamic>> menus = [
    {
      'img': ImageString.food1,
      'timing': '15-20 Mins',
      'foodName': 'Foutou sauce claire',
      'level': 'Difficultés: Moyen'
    },
    {
      'img': ImageString.food2,
      'timing': '1-2 heures',
      'foodName': 'Tchep poulet',
      'level': 'Difficultés: Moyen'
    },
    {
      'img': ImageString.food3,
      'timing': '50-60 Mins',
      'foodName': 'Gouagouassou',
      'level': 'Difficultés: Moyen'
    },
  ];
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
