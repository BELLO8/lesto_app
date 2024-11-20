import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenerateMenuFilterController extends GetxController {
  //TODO: Implement GenerateMenuFilterController
  final pageController = PageController();
  final count = 0.obs;
  final isLastPage = false.obs;
  final isFirstPage = true.obs;
  final currentPage = 0.obs;
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
