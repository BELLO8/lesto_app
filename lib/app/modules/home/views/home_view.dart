import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lesto/app/data/constants/colors/color_neutral.dart';
import 'package:lesto/app/data/constants/colors/color_primary.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                  color: NeutralColor.neutral900,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "Prêt pour votre prochain délicieux repas ?",
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 13,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.NOTIFICATIONS),
            icon: const Icon(HugeIcons.strokeRoundedNotification03,
                color: NeutralColor.neutral800, size: 22),
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
                color: Colors.grey.shade50,
                border: Border.all(color: Colors.grey.shade100, width: 1.5),
              ),
              child: const Icon(HugeIcons.strokeRoundedUser,
                  color: PrimaryColor.primary600, size: 18),
            ),
          ),
        ],
      ),
      body: Obx(() {
        return controller.loading.value
            ? _buildLoadingState()
            : IndexedStack(
                index: controller.currentIndex.value,
                children: [
                  GenerateRecipe(),
                  const MenuTab(),
                  const CoursesTab(),
                  DeliveryScreen(),
                ],
              );
      }),
      bottomNavigationBar: Obx(() => Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: NeutralColor.neutral900,
                borderRadius: BorderRadius.circular(30),
              ),
              child: BottomNavigationBar(
                currentIndex: controller.currentIndex.value,
                onTap: (index) {
                  controller.currentIndex.value = index;
                },
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                elevation: 0,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey.shade500,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(HugeIcons.strokeRoundedHome01),
                    activeIcon: Icon(HugeIcons.strokeRoundedHome01,
                        color: Colors.white),
                    label: 'Accueil',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(HugeIcons.strokeRoundedDish01),
                    activeIcon: Icon(HugeIcons.strokeRoundedDish01,
                        color: Colors.white),
                    label: 'Menus',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(HugeIcons.strokeRoundedShoppingBasket01),
                    activeIcon: Icon(HugeIcons.strokeRoundedShoppingBasket01,
                        color: Colors.white),
                    label: 'Courses',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(HugeIcons.strokeRoundedDeliveryTruck01),
                    activeIcon: Icon(HugeIcons.strokeRoundedDeliveryTruck01,
                        color: Colors.white),
                    label: 'Livraison',
                  ),
                ],
              ),
            ),
          )),
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
