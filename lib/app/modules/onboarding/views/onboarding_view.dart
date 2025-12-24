// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/routes/app_pages.dart';

import '../../../data/constants/Image/image_constant.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // Background Image with Gradient Overlay
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageString.onboardingImage),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    ImageString.logoPrimary, // Fallback to path if needed
                    width: 140,
                    // color: PrimaryColor.primary600, // Removed white color filter to show original colors or use a dark one
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Cuisinez ce que vous aimez, simplement.",
                    style: TextStyle(
                      fontFamily: 'GilroyBold',
                      fontSize: 32,
                      color: NeutralColor.neutral900,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Lesto vous accompagne dans la préparation de vos repas quotidiens avec des recettes personnalisées.",
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 16,
                      color: NeutralColor.neutral700,
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Buttons
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.toNamed(Routes.AUTH_REGISTER),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PrimaryColor.primary600,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Créer un compte",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'GilroyBold',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => Get.toNamed(Routes.AUTH_LOGIN),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                      ),
                      child: const Text(
                        "Se connecter",
                        style: TextStyle(
                          color: NeutralColor.neutral900,
                          fontSize: 16,
                          fontFamily: 'GilroySemi',
                        ),
                      ),
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
