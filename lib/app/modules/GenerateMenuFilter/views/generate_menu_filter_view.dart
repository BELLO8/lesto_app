import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesto/app/components/Button/primary_button.dart';
import 'package:lesto/app/components/Dialog/Content/generate_menu_content.dart';
import 'package:lesto/app/components/Dialog/bottom_sheet_dialog.dart';
import 'package:lesto/app/components/TextField/lesto_textfield%20copy.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import 'package:lesto/app/data/constants/Image/image_constant.dart';

import '../controllers/generate_menu_filter_controller.dart';

class GenerateMenuFilterView extends GetView<GenerateMenuFilterController> {
  const GenerateMenuFilterView({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
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
                    controller.isLastPage.value = index == 2;
                  },
                  children: [
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
                            InkWell(
                              onTap: () {
                                bottomSheetDialog(context, Container(),
                                    size.height * 0.92, () => {});
                              },
                              child: Container(
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
                                      width: size.width * 0.02,
                                    ),
                                    const Text("Rechercher un ingrédients",
                                        style: TextStyle(
                                            color: PrimaryColor.primary500,
                                            fontSize: 14,
                                            fontFamily: 'Gilroy'))
                                  ],
                                ),
                              ),
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
                            SizedBox(
                              height: 500,
                              child: GridView.extent(
                                mainAxisSpacing: 8,
                                childAspectRatio: (3),
                                maxCrossAxisExtent: 150.0,
                                children: controller.type.map((period) {
                                  return CustomRadioButton(
                                    size: size,
                                    icon: period['icon'],
                                    label: period['label'],
                                    onPressed: () {},
                                  );
                                }).toList(),
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
                      controller.isLastPage.value
                          ? const AlertDialog()
                          : controller.pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
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
