import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lesto/app/data/Models/menu_model.dart';
import 'package:lesto/app/data/providers/menu_provider.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final search = TextEditingController();
  final prohibition = TextEditingController();
  var menuList = <Menu>[].obs;
  var loading = false.obs;
  

  @override
  void onInit() {
    super.onInit();
    getMenu();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getMenu() async {
    try {
      loading.value = true;
      menuList.value = await MenuProvider().getMenu(1);
    } finally {
      loading.value = false;
    }
  }
}
