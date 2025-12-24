import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import 'package:lesto/app/routes/app_pages.dart';
import 'package:lesto/app/data/models/menu_model.dart';
import 'package:lesto/app/modules/home/controllers/home_controller.dart';

class MenuTab extends GetView<HomeController> {
  const MenuTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Mes Menus',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'GilroyBold',
            color: NeutralColor.neutral900,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.historyMenus.isEmpty) {
          return _buildEmptyState();
        }
        return ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: controller.historyMenus.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final menu = controller.historyMenus[index];
            return _buildMenuCard(menu);
          },
        );
      }),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(HugeIcons.strokeRoundedCalendar03,
              size: 64, color: Colors.grey.shade200),
          const SizedBox(height: 20),
          Text(
            'Aucun menu généré',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'GilroyBold',
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Générez votre premier menu pour commencer.',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Gilroy',
              color: Colors.grey.shade300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(List<Dish> menu) {
    // Determine date range if possible
    String dateRange = "Chargement...";
    if (menu.isNotEmpty) {
      final start = menu.first.date;
      final end = menu.last.date;
      dateRange =
          "${DateFormat('dd/MM').format(start)} - ${DateFormat('dd/MM').format(end)}";
    }

    return GestureDetector(
      onTap: () => Get.toNamed(Routes.GENERATE_MENU, arguments: menu),
      child: Container(
        padding: const EdgeInsets.all(20),
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
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: PrimaryColor.primary50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                HugeIcons.strokeRoundedCalendar01,
                color: PrimaryColor.primary600,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Menu de la semaine",
                    style: TextStyle(
                      fontFamily: 'GilroyBold',
                      fontSize: 16,
                      color: NeutralColor.neutral900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dateRange,
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
    );
  }
}
