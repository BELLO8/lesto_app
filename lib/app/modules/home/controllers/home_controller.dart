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

  List recommandation = [
    {
      "id": 20,
      "nom": "La sauce gombo",
      "duree": "01:15:00",
      "level": "facile",
      "image":
          "http://img.taste.com.au/UZVXAdo7/taste/2016/11/chinese-egg-noodle-and-vegetable-stir-fry-94186-1.jpeg",
      "id_type": 2,
      "description":
          "Sauce épaisse à base de gombo, servie avec du riz ou du foufou en Côte d’Ivoire."
    },
    {
      "id": 9,
      "nom": "Kedjenou de poulet",
      "duree": "01:15:00",
      "level": "moyen",
      "image":
          "http://img.taste.com.au/UZVXAdo7/taste/2016/11/chinese-egg-noodle-and-vegetable-stir-fry-94186-1.jpeg",
      "id_type": 2,
      "description":
          "Plat de poulet mijoté avec des légumes et des épices ivoiriennes."
    },
    {
      "id": 16,
      "nom": "Le Soupe Kandja",
      "duree": "01:15:00",
      "level": "facile",
      "image":
          "http://img.taste.com.au/UZVXAdo7/taste/2016/11/chinese-egg-noodle-and-vegetable-stir-fry-94186-1.jpeg",
      "id_type": 2,
      "description":
          "Une soupe épicée à base de gombo et de viande, courante en Côte d’Ivoire."
    },
    {
      "id": 18,
      "nom": "Sauce arachide",
      "duree": "01:15:00",
      "level": "facile",
      "image":
          "http://img.taste.com.au/UZVXAdo7/taste/2016/11/chinese-egg-noodle-and-vegetable-stir-fry-94186-1.jpeg",
      "id_type": 2,
      "description":
          "Une sauce épaisse à base d’arachides, souvent servie avec du riz ou du foufou en Côte d’Ivoire."
    },
    {
      "id": 30,
      "nom": "Aboboi",
      "duree": "01:15:00",
      "level": "moyen",
      "image":
          "http://img.taste.com.au/UZVXAdo7/taste/2016/11/chinese-egg-noodle-and-vegetable-stir-fry-94186-1.jpeg",
      "id_type": 3,
      "description":
          "Ragoût de maïs et de haricots, souvent servi avec du poisson ou de la viande au Ghana."
    },
    {
      "id": 21,
      "nom": "Attiéké aux crevettes",
      "duree": "01:15:00",
      "level": "moyen",
      "image":
          "http://img.taste.com.au/UZVXAdo7/taste/2016/11/chinese-egg-noodle-and-vegetable-stir-fry-94186-1.jpeg",
      "id_type": 2,
      "description":
          "Couscous de manioc fermenté servi avec des crevettes, populaire en Côte d’Ivoire."
    },
    {
      "id": 37,
      "nom": "Brochettes de viande",
      "duree": "01:15:00",
      "level": "facile",
      "image":
          "http://img.taste.com.au/UZVXAdo7/taste/2016/11/chinese-egg-noodle-and-vegetable-stir-fry-94186-1.jpeg",
      "id_type": 4,
      "description":
          "Des brochettes de viande grillées, populaires dans toute l’Afrique centrale."
    },
    {
      "id": 38,
      "nom": "Poulet DG",
      "duree": "01:15:00",
      "level": "moyen",
      "image":
          "http://img.taste.com.au/UZVXAdo7/taste/2016/11/chinese-egg-noodle-and-vegetable-stir-fry-94186-1.jpeg",
      "id_type": 4,
      "description":
          "Poulet sauté avec des légumes, typique de la cuisine camerounaise."
    },
    {
      "id": 43,
      "nom": "Nkui",
      "duree": "01:15:00",
      "level": "facile",
      "image":
          "http://img.taste.com.au/UZVXAdo7/taste/2016/11/chinese-egg-noodle-and-vegetable-stir-fry-94186-1.jpeg",
      "id_type": 4,
      "description":
          "Un plat camerounais à base de feuilles de njama njama, souvent servi avec du poisson ou de la viande."
    },
    {
      "id": 7,
      "nom": "Foutou banane",
      "duree": "01:15:00",
      "level": "facile",
      "image":
          "http://img.taste.com.au/UZVXAdo7/taste/2016/11/chinese-egg-noodle-and-vegetable-stir-fry-94186-1.jpeg",
      "id_type": 2,
      "description":
          "Banane plantain pilée, souvent servie avec une sauce ou un ragoût."
    }
  ];

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
