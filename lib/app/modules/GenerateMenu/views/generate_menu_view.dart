import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import 'package:lesto/app/routes/app_pages.dart';
import '../controllers/generate_menu_controller.dart';

class GenerateMenuView extends GetView<GenerateMenuController> {
  const GenerateMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            _buildBottomAction(),
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
              bool isSelected = controller.selectedDay.value == day.name;
              return GestureDetector(
                onTap: () => controller.selectedDay.value = day.name,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? NeutralColor.neutral900
                        : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? NeutralColor.neutral800
                          : Colors.grey.shade100,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      day.name,
                      style: TextStyle(
                        fontFamily: isSelected ? 'GilroyBold' : 'GilroySemi',
                        fontSize: 14,
                        color: isSelected ? Colors.white : Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }

  Widget _buildMealsContent() {
    return Obx(() {
      final meals = controller.weeklyMenus[controller.selectedDay.value] ?? [];
      if (meals.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(
            color: PrimaryColor.primary600,
          ),
        );
      }
      return ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: meals.length,
        separatorBuilder: (context, index) => const SizedBox(height: 24),
        itemBuilder: (context, index) {
          final meal = meals[index];
          return _buildMealItem(meal);
        },
      );
    });
  }

  Widget _buildMealItem(Map<String, dynamic> meal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: PrimaryColor.primary50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                (meal['type'] as String? ?? '').toUpperCase(),
                style: const TextStyle(
                  fontFamily: 'GilroyBold',
                  fontSize: 10,
                  color: PrimaryColor.primary700,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () {
            // Navigation vers le détail (à implémenter si besoin via arguments)
            if (meal['plat'] != null) {
              Get.toNamed(Routes.FOOD_DETAIL, arguments: meal['plat']);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.grey.shade100),
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
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: PrimaryColor.primary50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    meal['icon'] as IconData? ?? HugeIcons.strokeRoundedDish01,
                    color: PrimaryColor.primary600,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal['name'] as String? ?? 'Plat inconnu',
                        style: const TextStyle(
                          fontFamily: 'GilroyBold',
                          fontSize: 16,
                          color: NeutralColor.neutral900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${meal['cuisine'] ?? ''} • ${meal['duration'] ?? ''}',
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 13,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: Colors.grey.shade300),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomAction() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
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
}
