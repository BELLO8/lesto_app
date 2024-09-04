import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesto/app/data/Models/plat_model.dart';
import 'package:lesto/app/data/providers/plat_provider.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final search = TextEditingController();
  final prohibition = TextEditingController();
  var platList = <Plat>[].obs;
  var searchPlatList = <Plat>[].obs;
  var isloading = true.obs;
  var loading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getPlat();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getPlat() async {
    try {
      loading.value = true;
      platList.value = await PlatProvider().getPlats();
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
}
