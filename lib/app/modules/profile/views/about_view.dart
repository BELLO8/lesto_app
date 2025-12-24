import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeutralColor.neutral50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: NeutralColor.neutral800, size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'À propos de Lesto',
          style: TextStyle(
            color: NeutralColor.neutral900,
            fontFamily: 'GilroyBold',
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Center(
              child: Container(
                width: 100,
                height: 100,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: PrimaryColor.primary50,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(HugeIcons.strokeRoundedChefHat,
                    color: PrimaryColor.primary600, size: 60),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Lesto",
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'GilroyBold',
                color: NeutralColor.neutral900,
              ),
            ),
            const Text(
              "Version 4.0.0",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Gilroy',
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 48),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    "Notre Mission",
                    "Lesto simplifie votre quotidien culinaire en vous aidant à planifier vos repas de manière intelligente et saine. Notre objectif est de réduire le stress des courses et de la préparation des repas.",
                  ),
                  const SizedBox(height: 32),
                  _buildSection(
                    "Fonctionnalités Clés",
                    "• Génération de menus hebdomadaires personnalisés\n• Calculateur de prix des ingrédients\n• Gestion intelligente de l'inventaire\n• Recettes exclusives de chefs locaux",
                  ),
                  const SizedBox(height: 32),
                  _buildSection(
                    "Contact & Support",
                    "Une question ou une suggestion ? Contactez-nous à support@lestoapp.com ou suivez-nous sur nos réseaux sociaux @lesto_app.",
                  ),
                  const SizedBox(height: 40),
                  const Divider(),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      "© 2024 Lesto App. Tous droits réservés.",
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'GilroyBold',
            color: NeutralColor.neutral900,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'Gilroy',
            color: NeutralColor.neutral700,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
