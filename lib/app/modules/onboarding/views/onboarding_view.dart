import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import 'package:lesto/app/data/constants/Contents/auth_constant.dart';
import 'package:lesto/app/data/constants/Contents/text_constant.dart';

import '../../../data/constants/Image/image_constant.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(ImageString.onboardingImage),
        )),
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
                      title: AuthText.REGISTER_BUTTON_TEXT,
                      press: () {},
                      color: PrimaryColor.primary500,
                      textColor: NeutralColor.neutral100,
                      width: 373,
                      height: 56,
                    ),
                    LinkButton(
                      title: AuthText.LOGIN_BUTTON_TEXT,
                      press: () {},
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

class LinkButton extends StatelessWidget {
  const LinkButton({
    super.key,
    required this.title,
    required this.press,
  });
  final String title;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          fixedSize: const Size(240, 56),
        ),
        onPressed: press,
        child: Text(title,
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: PrimaryColor.primary700)));
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    required this.press,
    required this.textColor,
    required this.color,
    required this.width,
    required this.height,
  });
  final String title;
  final VoidCallback press;
  final Color textColor;
  final Color color;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 26, bottom: 8),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: color),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            fixedSize: Size(width, height),
          ),
          onPressed: press,
          child: Text(title,
              style: TextStyle(
                  fontFamily: 'Poppins', fontSize: 16, color: textColor))),
    );
  }
}
