// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesto/app/routes/app_pages.dart';

import '../../../data/constants/Colors/color_primary.dart';
import '../../../data/constants/Contents/modal_text_constant.dart';
import '../../Button/primary_button.dart';

class GenerateMenuContent extends StatelessWidget {
  const GenerateMenuContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryButton(
            styleText: TextStyle(
                fontFamily: 'GilroyMedium',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: PrimaryColor.primary700),
            title: ModalText.MODAL_GENERATE_BUTTON_TEXT,
            press: () {
              Get.toNamed(Routes.GENERATE_MENU);
            },
            color: PrimaryColor.primary100,
            width: 274,
            height: 44),
      ],
    );
  }
}
