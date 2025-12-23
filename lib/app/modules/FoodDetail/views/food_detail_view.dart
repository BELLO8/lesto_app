import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lesto/app/components/Video/VideoPlayer.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import '../controllers/food_detail_controller.dart';

class FoodDetailView extends GetView<FoodDetailController> {
  const FoodDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _buildSliverAppBar(context),
              SliverToBoxAdapter(
                child: _buildContent(context),
              ),
              SliverToBoxAdapter(
                child: const SizedBox(height: 100),
              ),
            ],
          ),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      expandedHeight: size.height * 0.35,
      backgroundColor: Colors.white,
      elevation: 0,
      pinned: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Center(
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: NeutralColor.neutral900, size: 18),
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            const VideoApp(),
            // Gradient overlay
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.transparent,
                    Colors.black.withOpacity(0.05),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  controller.argumentData.nom,
                  style: const TextStyle(
                    fontFamily: 'GilroyBold',
                    fontSize: 24,
                    color: NeutralColor.neutral900,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: PrimaryColor.primary50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        size: 14, color: PrimaryColor.primary600),
                    const SizedBox(width: 4),
                    const Text(
                      "4.8",
                      style: TextStyle(
                        fontFamily: 'GilroyBold',
                        fontSize: 12,
                        color: PrimaryColor.primary700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildInfoTag(HugeIcons.strokeRoundedClock01,
                  controller.argumentData.duree),
              const SizedBox(width: 12),
              _buildInfoTag(
                  Icons.bar_chart_rounded, controller.argumentData.level),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            "Description",
            style: TextStyle(
              fontFamily: 'GilroyBold',
              fontSize: 18,
              color: NeutralColor.neutral900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            controller.argumentData.description,
            style: TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 14,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          _buildTabs(),
          const SizedBox(height: 24),
          _buildTabContent(),
        ],
      ),
    );
  }

  Widget _buildInfoTag(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade400),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'GilroySemi',
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Obx(() => Row(
            children: [
              Expanded(
                child: _buildTabItem(
                  "Ingrédients",
                  controller.currentTab.value == 0,
                  () => controller.changeTab(0),
                ),
              ),
              Expanded(
                child: _buildTabItem(
                  "Préparation",
                  controller.currentTab.value == 1,
                  () => controller.changeTab(1),
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildTabItem(String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: isSelected ? 'GilroyBold' : 'GilroySemi',
              fontSize: 14,
              color:
                  isSelected ? NeutralColor.neutral900 : Colors.grey.shade400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    return Obx(() {
      if (controller.currentTab.value == 0) {
        return _buildIngredientsList();
      } else {
        return _buildPreparationMode();
      }
    });
  }

  Widget _buildIngredientsList() {
    return Obx(() {
      if (controller.loading.value) {
        return const Center(
          child: CircularProgressIndicator(color: PrimaryColor.primary600),
        );
      }
      if (controller.ingredients.isEmpty) {
        return const Center(
          child: Text("Aucun ingrédient pour ce plat"),
        );
      }
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.ingredients.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final item = controller.ingredients[index];
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: PrimaryColor.primary50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(HugeIcons.strokeRoundedApple,
                      size: 20, color: PrimaryColor.primary600),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    item.nom,
                    style: const TextStyle(
                      fontFamily: 'GilroySemi',
                      fontSize: 15,
                      color: NeutralColor.neutral900,
                    ),
                  ),
                ),
                Text(
                  '${item.quantite} ${item.unite}',
                  style: TextStyle(
                    fontFamily: 'GilroyBold',
                    fontSize: 14,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Widget _buildPreparationMode() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Mode de préparation",
          style: TextStyle(
            fontFamily: 'GilroyBold',
            fontSize: 16,
            color: NeutralColor.neutral900,
          ),
        ),
        SizedBox(height: 12),
        Text(
          "Les étapes de préparation seront bientôt disponibles ici.",
          style: TextStyle(
            fontFamily: 'Gilroy',
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Coût estimé",
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
                const Text(
                  "0 Fcfa",
                  style: TextStyle(
                    fontFamily: 'GilroyBold',
                    fontSize: 18,
                    color: NeutralColor.neutral900,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 24),
            Expanded(
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
                child: const Text(
                  "Calculer le prix",
                  style: TextStyle(
                    fontFamily: 'GilroyBold',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
