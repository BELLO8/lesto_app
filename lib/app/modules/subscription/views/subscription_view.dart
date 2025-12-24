import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import '../controllers/subscription_controller.dart';

class SubscriptionView extends GetView<SubscriptionController> {
  const SubscriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeutralColor.neutral50,
      appBar: AppBar(
        backgroundColor: PrimaryColor.primary600,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white, size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Passer au Premium',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'GilroyBold',
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildPlanSelection(),
            const SizedBox(height: 32),
            _buildFeatures(),
            const SizedBox(height: 32),
            _buildPaymentMethods(),
            const SizedBox(height: 40),
            _buildSubscribeButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            PrimaryColor.primary600,
            PrimaryColor.primary600.withOpacity(0.8)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Column(
        children: [
          Icon(HugeIcons.strokeRoundedCircleArrowDown01,
              size: 64, color: Colors.white),
          SizedBox(height: 24),
          Text(
            "Libérez tout le potentiel de Lesto",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'GilroyBold',
              fontSize: 24,
            ),
          ),
          SizedBox(height: 12),
          Text(
            "Gérez vos repas sans limites et accédez à des recettes exclusives.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontFamily: 'Gilroy',
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Choisissez un forfait",
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'GilroyBold',
              color: NeutralColor.neutral900,
            ),
          ),
          const SizedBox(height: 16),
          Obx(() => Row(
                children: [
                  Expanded(
                    child: _buildPlanItem(
                      title: "Mensuel",
                      price: "1 500 FCFA",
                      subtitle: "/ mois",
                      index: 0,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildPlanItem(
                      title: "Annuel",
                      price: "15 000 FCFA",
                      subtitle: "/ an",
                      index: 1,
                      isBestValue: true,
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildPlanItem({
    required String title,
    required String price,
    required String subtitle,
    required int index,
    bool isBestValue = false,
  }) {
    bool isSelected = controller.selectedPlan.value == index;

    return GestureDetector(
      onTap: () => controller.selectPlan(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? PrimaryColor.primary50 : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                isSelected ? PrimaryColor.primary600 : NeutralColor.neutral200,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: PrimaryColor.primary600.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Column(
          children: [
            if (isBestValue)
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: PrimaryColor.primary600,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "ÉCONOMISEZ 16%",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontFamily: 'GilroyBold',
                  ),
                ),
              ),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'GilroySemi',
                color: isSelected
                    ? PrimaryColor.primary700
                    : NeutralColor.neutral600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              price,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'GilroyBold',
                color: isSelected
                    ? PrimaryColor.primary900
                    : NeutralColor.neutral900,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Gilroy',
                color: NeutralColor.neutral500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatures() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Avantages Premium",
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'GilroyBold',
              color: NeutralColor.neutral900,
            ),
          ),
          const SizedBox(height: 16),
          _buildFeatureItem(HugeIcons.strokeRoundedCircleArrowDown01,
              "Génération de menus illimitée"),
          _buildFeatureItem(HugeIcons.strokeRoundedCrown,
              "Recettes exclusives de chefs locaux"),
          _buildFeatureItem(HugeIcons.strokeRoundedFileDownload,
              "Exportation des listes de courses en PDF"),
          _buildFeatureItem(
              HugeIcons.strokeRoundedRemove02, "Aucune publicité intrusive"),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: PrimaryColor.primary50,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 16, color: PrimaryColor.primary600),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 14,
                color: NeutralColor.neutral800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Modes de paiement sécurisés",
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'GilroyBold',
              color: NeutralColor.neutral900,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPaymentIcon(
                "Wave",
                "https://play-lh.googleusercontent.com/B2sfLVgRWgV_bk5rtF51w6AieJWXc0qWbyWoaA8pMNp-is41AmvhJYVr95Dq9hT97Es=w240-h480-rw",
              ),
              _buildPaymentIcon(
                "Orange Money",
                "https://play-lh.googleusercontent.com/AlHlWVHGr3yfwKMlCSkN38H_TPJ3Hsmqa8Ddiq06Qgq68e4iIOIxrfpWlcd-l8wYxHs",
              ),
              _buildPaymentIcon(
                "Moov Money",
                "https://www.lafermeeliel.com/wp-content/uploads/2024/10/payment-methods-moov-money.f34903fd.png",
              ),
              _buildPaymentIcon(
                "Carte Bancaire",
                "https://cdn-icons-png.flaticon.com/512/6963/6963703.png", // Using a generic valid card icon as placeholder/fallback or just keeping it
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentIcon(String label, String imageUrl) {
    return Column(
      children: [
        Container(
          width: 55,
          height: 55,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: NeutralColor.neutral200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(HugeIcons.strokeRoundedCreditCard, size: 24),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontFamily: 'GilroySemi',
            color: NeutralColor.neutral600,
          ),
        ),
      ],
    );
  }

  Widget _buildSubscribeButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => controller.subscribe(),
          style: ElevatedButton.styleFrom(
            backgroundColor: PrimaryColor.primary600,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: const Text(
            "S'abonner maintenant",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'GilroyBold',
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
