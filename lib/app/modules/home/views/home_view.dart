import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import 'package:lesto/app/modules/home/views/GenerateRecipe.dart';
import 'package:lesto/app/modules/ui_v2/Livraison/livraison.dart';
import 'package:lesto/app/modules/home/views/tabs/menu_tab.dart';
import 'package:lesto/app/modules/home/views/tabs/courses_tab.dart';
import 'package:lesto/app/routes/app_pages.dart';
import 'package:lesto/app/modules/home/views/components/shimmer_loading.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: NeutralColor.neutral50,
          appBar: controller.currentIndex.value == 0 ? _buildAppBar() : null,
          body: controller.loading.value
              ? _buildLoadingState()
              : IndexedStack(
                  index: controller.currentIndex.value,
                  children: [
                    GenerateRecipe(),
                    const MenuTab(),
                    const CoursesTab(),
                    DeliveryScreen(),
                  ],
                ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.fromLTRB(
                24, 0, 24, MediaQuery.of(context).padding.bottom + 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 20,
                  offset: const Offset(0, -8),
                ),
              ],
            ),
            child: Container(
              height: 72,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: NeutralColor.neutral900,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: NeutralColor.neutral900.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, HugeIcons.strokeRoundedHome01, 'Accueil'),
                  _buildNavItem(1, HugeIcons.strokeRoundedDish01, 'Menus'),
                  _buildNavItem(
                      2, HugeIcons.strokeRoundedShoppingBasket01, 'Courses'),
                  _buildNavItem(
                      3, HugeIcons.strokeRoundedDeliveryTruck01, 'Livraison'),
                ],
              ),
            ),
          ),
        ));
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: PrimaryColor.primary600,
      elevation: 0,
      centerTitle: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bonjour Lesto 👋",
              style: TextStyle(
                fontFamily: 'GilroyBold',
                fontSize: 20,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              "Prêt pour votre prochain délicieux repas ?",
              style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 13,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => Get.toNamed(Routes.NOTIFICATIONS),
          icon: const Icon(HugeIcons.strokeRoundedNotification03,
              color: Colors.white, size: 22),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () => Get.toNamed(Routes.PROFILE),
          child: Container(
            margin: const EdgeInsets.only(right: 20),
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2),
              border:
                  Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
            ),
            child: const Icon(HugeIcons.strokeRoundedUser,
                color: Colors.white, size: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = controller.currentIndex.value == index;
    return GestureDetector(
      onTap: () => controller.currentIndex.value = index,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.white.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : NeutralColor.neutral500,
              size: 24,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: PrimaryColor.primary500,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerLoading.rectangular(height: 180),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerLoading.rectangular(height: 24, width: Get.width * 0.4),
              ShimmerLoading.rectangular(height: 24, width: Get.width * 0.2),
            ],
          ),
          const SizedBox(height: 20),
          _buildShimmerItem(),
          const SizedBox(height: 16),
          _buildShimmerItem(),
          const SizedBox(height: 16),
          _buildShimmerItem(),
          const SizedBox(height: 32),
          ShimmerLoading.rectangular(height: 24, width: Get.width * 0.5),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  3,
                  (index) => Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: const ShimmerLoading.rectangular(
                            height: 120, width: 120),
                      )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerItem() {
    return Row(
      children: [
        const ShimmerLoading.circular(width: 50, height: 50),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerLoading.rectangular(height: 16, width: Get.width * 0.6),
              const SizedBox(height: 8),
              ShimmerLoading.rectangular(height: 12, width: Get.width * 0.4),
            ],
          ),
        ),
      ],
    );
  }
}
