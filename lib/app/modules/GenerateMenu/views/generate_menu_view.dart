import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';

import 'package:lesto/app/data/models/menu_model.dart';
import 'package:lesto/app/routes/app_pages.dart';
import '../controllers/generate_menu_controller.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class GenerateMenuView extends GetView<GenerateMenuController> {
  const GenerateMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeutralColor.neutral50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: NeutralColor.neutral800, size: 20),
        ),
        title: const Text(
          "Menu de la semaine",
          style: TextStyle(
            fontFamily: 'GilroyBold',
            fontSize: 20,
            color: NeutralColor.neutral900,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.PROFILE),
            icon: const Icon(HugeIcons.strokeRoundedUser,
                color: NeutralColor.neutral800, size: 22),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildDaySelector(),
            Expanded(
              child: _buildMealsContent(),
            ),
            _buildBottomAction(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDaySelector() {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Obx(() => ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            scrollDirection: Axis.horizontal,
            itemCount: controller.generateMenu.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final day = controller.generateMenu[index];

              return Obx(() {
                bool isSelected = controller.selectedDay.value == day.name;
                return GestureDetector(
                  onTap: () => controller.selectedDay.value = day.name,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color:
                          isSelected ? PrimaryColor.primary600 : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? PrimaryColor.primary600
                            : NeutralColor.neutral200,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: PrimaryColor.primary600.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              )
                            ]
                          : [],
                    ),
                    child: Center(
                      child: Text(
                        day.name,
                        style: TextStyle(
                          fontFamily: isSelected ? 'GilroyBold' : 'GilroySemi',
                          fontSize: 14,
                          color: isSelected
                              ? Colors.white
                              : NeutralColor.neutral500,
                        ),
                      ),
                    ),
                  ),
                );
              });
            },
          )),
    );
  }

  Widget _buildMealsContent() {
    return Obx(() {
      final meals = controller.selectedDayPlats;
      if (meals.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(HugeIcons.strokeRoundedDish01,
                  size: 48, color: Colors.grey.shade200),
              const SizedBox(height: 16),
              Text(
                "Aucun plat pour ce jour",
                style: TextStyle(
                  fontFamily: 'GilroyBold',
                  fontSize: 16,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        );
      }
      return ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: meals.length,
        separatorBuilder: (context, index) => const SizedBox(height: 24),
        itemBuilder: (context, index) {
          final meal = meals[index];
          return _buildMealItem(meal, index);
        },
      );
    });
  }

  Widget _buildMealItem(PlatMenu meal, int index) {
    String period = index == 0 ? "MIDI" : "SOIR";
    IconData periodIcon = index == 0
        ? HugeIcons.strokeRoundedSun03
        : HugeIcons.strokeRoundedMoon02;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: PrimaryColor.primary50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(periodIcon, size: 14, color: PrimaryColor.primary700),
                  const SizedBox(width: 6),
                  Text(
                    period,
                    style: const TextStyle(
                      fontFamily: 'GilroyBold',
                      fontSize: 10,
                      color: PrimaryColor.primary700,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.FOOD_DETAIL, arguments: meal);
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: NeutralColor.neutral200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: (!meal.image.startsWith('http'))
                      ? Container(
                          width: 64,
                          height: 64,
                          color: PrimaryColor.primary50,
                          child: const Icon(HugeIcons.strokeRoundedDish01,
                              color: PrimaryColor.primary600, size: 28),
                        )
                      : Image.network(
                          meal.image,
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            width: 64,
                            height: 64,
                            color: PrimaryColor.primary50,
                            child: const Icon(HugeIcons.strokeRoundedDish01,
                                color: PrimaryColor.primary600, size: 28),
                          ),
                        ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.libelle,
                        style: const TextStyle(
                          fontFamily: 'GilroyBold',
                          fontSize: 16,
                          color: NeutralColor.neutral900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${meal.level} • ${meal.duree}',
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 13,
                          color: NeutralColor.neutral600,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded,
                    color: NeutralColor.neutral400),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                controller.aggregateIngredients();
                _showShoppingListModal(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: PrimaryColor.primary600,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(HugeIcons.strokeRoundedShoppingBasket02,
                      size: 20, color: Colors.white),
                  SizedBox(width: 12),
                  Text(
                    'Voir ma liste de courses',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'GilroyBold',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showShoppingListModal(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Ma Liste de Courses",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'GilroyBold',
                    color: NeutralColor.neutral900,
                  ),
                ),
                IconButton(
                  onPressed: () => _printShoppingList(),
                  icon: const Icon(HugeIcons.strokeRoundedPrinter,
                      color: PrimaryColor.primary600, size: 24),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.isAggregating.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                        color: PrimaryColor.primary600),
                  );
                }
                if (controller.shoppingList.isEmpty) {
                  return const Center(
                    child: Text("Votre liste est vide"),
                  );
                }
                return ListView.separated(
                  itemCount: controller.shoppingList.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1, color: NeutralColor.neutral100),
                  itemBuilder: (context, index) {
                    final item = controller.shoppingList[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: PrimaryColor.primary50,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(HugeIcons.strokeRoundedApple,
                            size: 16, color: PrimaryColor.primary600),
                      ),
                      title: Text(
                        item.nom,
                        style: const TextStyle(
                          fontFamily: 'GilroySemi',
                          fontSize: 15,
                          color: NeutralColor.neutral800,
                        ),
                      ),
                      trailing: Text(
                        "${item.quantite} ${item.unite}",
                        style: const TextStyle(
                          fontFamily: 'GilroyBold',
                          fontSize: 14,
                          color: NeutralColor.neutral500,
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PrimaryColor.primary600,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Fermer",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'GilroyBold',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Future<void> _printShoppingList() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Text("Liste de Courses Lesto",
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 20),
              ...controller.shoppingList.map((item) {
                return pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 4),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(item.nom),
                      pw.Text("${item.quantite} ${item.unite}"),
                    ],
                  ),
                );
              }).toList(),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
