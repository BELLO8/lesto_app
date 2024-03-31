// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/routes/app_pages.dart';

import '../../../data/constants/Colors/color_primary.dart';
import '../../../data/constants/Contents/modal_text_constant.dart';
import '../../Button/primary_button.dart';
import '../modal_dialog.dart';

class GenerateMenuContent extends StatelessWidget {
  const GenerateMenuContent({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Map<String, dynamic>> time = [
      {
        'id': 1,
        'icon': Icons.sunny,
        'label': ModalText.MIDI,
      },
      {
        'id': 2,
        'icon': Icons.dark_mode_sharp,
        'label': ModalText.SOIR,
      },
    ];

    List<Map<String, dynamic>> type = [
      {
        'id': 1,
        'icon': Icons.oil_barrel_rounded,
        'label': ModalText.GRAS,
      },
      {
        'id': 2,
        'icon': Icons.dark_mode_sharp,
        'label': ModalText.SUCRE,
      },
      {
        'id': 3,
        'icon': TablerIcons.salt,
        'label': ModalText.SALE,
      },
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              ModalText.MODAL_GENERATE_QUESTION_TEXT,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'GilroyMedium',
                  color: Colors.black,
                  fontSize: 14,
                  decoration: TextDecoration.none),
            ),
          ),
          SizedBox(
            height: size.height * 0.017,
          ),
          SizedBox(
            height: size.height * 0.054,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: time.map((period) {
                return CustomRadioButton(
                  size: size,
                  icon: period['icon'],
                  label: period['label'],
                  onPressed: () {},
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: size.height * 0.026,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              ModalText.MODAL_GENERATE_QUESTION_TEXT_2,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'GilroyMedium',
                  color: Colors.black,
                  fontSize: 14,
                  decoration: TextDecoration.none),
            ),
          ),
          SizedBox(
            height: size.height * 0.017,
          ),
          SizedBox(
            height: size.height * 0.054,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: type.map((period) {
                return CustomRadioButton(
                  size: size,
                  icon: period['icon'],
                  label: period['label'],
                  onPressed: () {},
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              ModalText.MODAL_GENERATE_QUESTION_TEXT_3,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'GilroyMedium',
                  color: Colors.black,
                  fontSize: 14,
                  decoration: TextDecoration.none),
            ),
          ),
          SizedBox(
            height: size.height * 0.017,
          ),
          Material(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(width: 1.5, color: NeutralColor.neutral300),
              ),
              width: size.width * 0.77,
              child: TextFormField(
                cursorColor: PrimaryColor.primary600,
                controller: controller,
                style: TextStyle(
                  fontFamily: "Poppins",
                ),
                decoration: InputDecoration(
                  filled: true,
                  border: InputBorder.none,
                  fillColor: Colors.transparent,
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      fontFamily: 'Gilroy'),
                  hintText: "Piments, tomate,...etc",
                ),
              ),
            ),
          ),
          Spacer(),
          PrimaryButton(
              styleText: TextStyle(
                  fontFamily: 'GilroyMedium',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: PrimaryColor.primary700),
              title: ModalText.MODAL_GENERATE_BUTTON_TEXT,
              press: () {
                showAlert(
                    context,
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Row(children: [
                        CircularProgressIndicator(
                          color: PrimaryColor.primary400,
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Text(
                          ModalText.MODAL_GENERATE_TEXT,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: 'Gilroy',
                              fontSize: 14,
                              color: Colors.black),
                        )
                      ]),
                    ),
                    size.width * 0.85,
                    size.height * 0.11,
                    false);
                Future.delayed(const Duration(seconds: 5), () {
                  Get.toNamed(Routes.GENERATE_MENU);
                });
              },
              color: PrimaryColor.primary100,
              width: 274,
              height: 44),
        ],
      ),
    );
  }
}

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    super.key,
    required this.size,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final Size size;
  final String label;
  final IconData icon;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: size.width * 0.24,
        height: size.height * 0.05,
        margin: EdgeInsets.symmetric(horizontal: 2),
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1.5, color: NeutralColor.neutral300),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: PrimaryColor.primary800,
            ),
            SizedBox(
              width: size.width * 0.01,
            ),
            Text(
              label,
              style: TextStyle(
                  fontFamily: 'GilroyMedium',
                  color: Colors.black,
                  fontSize: 14,
                  decoration: TextDecoration.none),
            ),
          ],
        ),
      ),
    );
  }
}
