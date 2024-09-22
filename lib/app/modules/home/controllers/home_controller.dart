import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lesto/app/data/Models/menu_model.dart';
import 'package:lesto/app/data/Models/plat_model.dart';
import 'package:lesto/app/data/providers/menu_provider.dart';
import 'package:lesto/app/data/providers/plat_provider.dart';
import 'package:lesto/app/routes/app_pages.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final search = TextEditingController();
  final prohibition = TextEditingController();
  final storeMenu = GetStorage();

  var platList = <Plat>[].obs;
  var searchPlatList = <Plat>[].obs;
  var isloading = true.obs;
  var loading = true.obs;
  var dateDebut = "Date de debut".obs;
  var dateFin = "Date de fin".obs;
  var generateMenu = <Dish>[].obs;

  @override
  void onInit() {
    super.onInit();
    getPlat();
  }

  Future<void> getPlat() async {
    try {
      loading.value = true;
      platList.value = await PlatProvider().getPlats();
    } finally {
      loading.value = false;
    }
  }

  Future<void> getMenu(int id, String dateDebut, String dateFin) async {
    loading.value = true;

    if (dateDebut == "Date de debut" && dateFin == "Date de fin") {
      Get.snackbar('Date invalide', 'Selectionnez une date valide',
          backgroundColor: Colors.red);
    } else {
      generateMenu.value = await MenuProvider().getMenu(id, dateDebut, dateFin);
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
}
