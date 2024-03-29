// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesto/app/components/Button/link_button.dart';
import 'package:lesto/app/components/Button/primary_button.dart';
import 'package:lesto/app/components/Container/container_image.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import 'package:lesto/app/data/constants/Contents/auth_constant.dart';
import 'package:lesto/app/data/constants/Contents/text_constant.dart';
import 'package:lesto/app/routes/app_pages.dart';

import '../../../data/constants/Image/image_constant.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: ImageContainer(
        size: size,
        backgroundImage: ImageString.onboardingImage,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: size.height * 0.40,
            child: Column(children: [
              Image.asset(
                ImageString.logoPrimary,
                width: 163,
              ),
              const Text(
                OtherText.ONBOARDING_TEXT_1,
                style: TextStyle(fontFamily: 'GilroySemi', fontSize: 18),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const Text(
                      OtherText.ONBOARDING_TEXT_2,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontFamily: 'Gilroy', fontSize: 22),
                    ),
                    PrimaryButton(
                      styleText: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: NeutralColor.neutral100),
                      title: AuthText.REGISTER_BUTTON_TEXT,
                      press: () {
                        Get.toNamed(Routes.AUTH_REGISTER);
                      },
                      color: PrimaryColor.primary500,
                      width: 373,
                      height: 56,
                    ),
                    LinkButton(
                      title: AuthText.LOGIN_BUTTON_TEXT,
                      press: () {
                        Get.toNamed(Routes.AUTH_LOGIN);
                      },
                      width: 300,
                      height: 30,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
