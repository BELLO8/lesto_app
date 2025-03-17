// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lesto/app/components/Button/primary_button.dart';
import 'package:lesto/app/components/Dialog/Content/generate_menu_content.dart';
import 'package:lesto/app/components/TextField/lesto_textfield%20copy.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import 'package:lesto/app/data/constants/Contents/modal_text_constant.dart';
import 'package:lesto/app/data/constants/Image/image_constant.dart';
import 'package:lesto/app/modules/home/controllers/home_controller.dart';
import 'package:toastification/toastification.dart';

import '../controllers/generate_menu_filter_controller.dart';

class GenerateMenuFilterView extends GetView<GenerateMenuFilterController> {
  const GenerateMenuFilterView({super.key});
  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => {
                  controller.currentPage.value == 0
                      ? Get.back()
                      : controller.pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn)
                },
            icon: const Icon(Icons.arrow_back, color: PrimaryColor.primary600)),
      ),
      body: SizedBox(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.8,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller.pageController,
                  onPageChanged: (index) {
                    controller.currentPage.value = index;
                    controller.isFirstPage.value = index == 0;
                    controller.isLastPage.value = index == 3;
                  },
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text(
                                ModalText.MODAL_GENERATE_QUESTION_TEXT_4,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'GilroySemi',
                                    color: Colors.black,
                                    fontSize: 21,
                                    decoration: TextDecoration.none),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 18),
                                child: Obx(
                                  () => Center(
                                    child: Row(
                                      children: [
                                        DatePicker(
                                          label: homeController.dateDebut.value,
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now()
                                                        .subtract(
                                                            Duration(days: 0)),
                                                    lastDate: DateTime(2101));

                                            if (pickedDate != null) {
                                              String formattedDate =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(pickedDate);
                                              homeController
                                                  .selectedDate(formattedDate);
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        DatePicker(
                                          label: homeController.dateFin.value,
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime
                                                        .now(), //get today's date
                                                    firstDate: DateTime.now()
                                                        .subtract(
                                                            Duration(days: 0)),
                                                    lastDate: DateTime(2101));

                                            if (pickedDate != null) {
                                              String formattedDate =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(pickedDate);
                                              homeController.selectedDateFin(
                                                  formattedDate);
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Center(
                        child: Column(
                          children: [
                            const Text(
                              'Maison',
                              style: TextStyle(
                                  fontSize: 26, fontFamily: "GilroySemi"),
                            ),
                            const SizedBox(
                              width: 250,
                              child: Text(
                                textAlign: TextAlign.center,
                                'Pour combien de personnes réalisez vous les menus?',
                                style: TextStyle(
                                    fontSize: 18, fontFamily: "Gilroy"),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.5,
                                        color: PrimaryColor.primary200),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    "Adulte",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: PrimaryColor.primary500,
                                        fontFamily: 'Gilroy'),
                                  ),
                                ),
                                const LestoTextField(
                                    hintValue: "Nombre de personne", label: ""),
                                const SizedBox(
                                  height: 12,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.5,
                                        color: PrimaryColor.primary200),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    "Enfant",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: PrimaryColor.primary500,
                                        fontFamily: 'Gilroy'),
                                  ),
                                ),
                                const LestoTextField(
                                    hintValue: "Nombre de personne", label: "")
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Center(
                        child: Column(
                          children: [
                            const Text(
                              'Aliments',
                              style: TextStyle(
                                  fontSize: 26, fontFamily: "GilroySemi"),
                            ),
                            const SizedBox(
                              width: 250,
                              child: Text(
                                textAlign: TextAlign.center,
                                'Avez-vous des ingrédients que vous ne désirez pas (interdits)?',
                                style: TextStyle(
                                    fontSize: 18, fontFamily: "Gilroy"),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Container(
                              height: 46,
                              width: size.width * 0.6,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  border: Border.all(
                                      width: 1,
                                      color: PrimaryColor.primary200)),
                              child: Row(
                                children: [
                                  Image.asset(ImageString.search),
                                  SizedBox(
                                    width: size.width * 0.47,
                                    child: TextFormField(
                                      cursorColor: PrimaryColor.primary600,
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                      decoration: InputDecoration(
                                        filled: true,
                                        border: InputBorder.none,
                                        fillColor: PrimaryColor.transparent,
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: PrimaryColor.primary500,
                                            fontSize: 16,
                                            fontFamily: 'Gilroy'),
                                        hintText: "Rechercher un ingredient",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Obx(() => SizedBox(
                                  height: size.height * 0.55,
                                  child: GridView.extent(
                                    mainAxisSpacing: 14,
                                    childAspectRatio: (4),
                                    maxCrossAxisExtent: 190.0,
                                    children: controller.ingredientListe
                                        .map((ingredient) {
                                      return CustomRadioButtonIngredient(
                                        state: controller.arraySelectItem
                                            .contains(ingredient.nom),
                                        size: size,
                                        label: ingredient.nom,
                                        onPressed: () {
                                          controller.selectItem.value =
                                              ingredient.nom;
                                          controller.checked();
                                        },
                                      );
                                    }).toList(),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Center(
                        child: Column(
                          children: [
                            const Text(
                              'Cuisine',
                              style: TextStyle(
                                  fontSize: 26, fontFamily: "GilroySemi"),
                            ),
                            const SizedBox(
                              width: 280,
                              child: Text(
                                textAlign: TextAlign.center,
                                'Quels sont les équipements disponibles dans votre cuisine ?',
                                style: TextStyle(
                                    fontSize: 18, fontFamily: "Gilroy"),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Obx(
                              () => SizedBox(
                                height: 500,
                                child: GridView.extent(
                                  mainAxisSpacing: 8,
                                  childAspectRatio: (3),
                                  maxCrossAxisExtent: 150.0,
                                  children: controller.type.map((period) {
                                    return CustomRadioButton(
                                      state: controller.arrayKitchen
                                          .contains(period['label']),
                                      size: size,
                                      icon: period['icon'],
                                      label: period['label'],
                                      onPressed: () {
                                        controller.selectItem.value =
                                            period['label'];
                                        controller.checkedKitchenItem();
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => PrimaryButton(
                    styleText: const TextStyle(
                        fontFamily: 'GilroyMedium',
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: NeutralColor.neutral100),
                    title: controller.isLastPage.value ? 'Valider' : 'Suivant',
                    press: () {
                      if (homeController.dateDebut.value == "Date de debut" &&
                          homeController.dateFin.value == "Date de fin") {
                        toastification.show(
                          context: context,
                          type: ToastificationType.error,
                          style: ToastificationStyle.simple,
                          title: Text(
                            "Selectionnez une date valide",
                            style: const TextStyle(
                                fontFamily: 'GilroySemi', color: Colors.red),
                          ),
                          autoCloseDuration: const Duration(seconds: 3),
                        );
                      } else {
                        controller.isLastPage.value
                            ? homeController.getMenu(
                                1,
                                homeController.dateDebut.value,
                                homeController.dateFin.value)
                            : controller.pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                      }
                    },
                    color: PrimaryColor.primary500,
                    width: 424,
                    height: 44),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
