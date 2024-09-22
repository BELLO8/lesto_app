// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lesto/app/components/TextField/custom_textfield.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Image/image_constant.dart';
import 'package:lesto/app/modules/home/controllers/home_controller.dart';

import '../../../data/constants/Colors/color_primary.dart';
import '../../../data/constants/Contents/modal_text_constant.dart';
import '../../Button/primary_button.dart';

class GenerateMenuContent extends StatelessWidget {
  const GenerateMenuContent({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    TextEditingController dateController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    final homeController = Get.find<HomeController>();

    List<Map<dynamic, dynamic>> time = [
      {
        'id': 1,
        'icon': ImageString.sun,
        'label': ModalText.MIDI,
      },
      {
        'id': 2,
        'icon': ImageString.moon,
        'label': ModalText.SOIR,
      },
    ];

    List<Map<dynamic, dynamic>> type = [
      {
        'id': 1,
        'icon': ImageString.fat,
        'label': ModalText.GRAS,
      },
      {
        'id': 2,
        'icon': ImageString.sugar,
        'label': ModalText.SUCRE,
      },
      {
        'id': 3,
        'icon': ImageString.salt,
        'label': ModalText.SALE,
      },
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              ModalText.MODAL_GENERATE_QUESTION_TEXT,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'GilroySemi',
                  color: Colors.black,
                  fontSize: 16,
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
                  fontFamily: 'GilroySemi',
                  color: Colors.black,
                  fontSize: 16,
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
            height: 18,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              ModalText.MODAL_GENERATE_QUESTION_TEXT_4,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'GilroySemi',
                  color: Colors.black,
                  fontSize: 16,
                  decoration: TextDecoration.none),
            ),
          ),
          Obx(
            () => Center(
              child: Row(
                children: [
                  DatePicker(
                    label: homeController.dateDebut.value,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now().subtract(Duration(days: 0)),
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        homeController.selectedDate(formattedDate);
                      }
                    },
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  DatePicker(
                    label: homeController.dateFin.value,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), //get today's date
                          firstDate: DateTime.now().subtract(Duration(days: 0)),
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        homeController.selectedDateFin(formattedDate);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          CustomTextField(
            label: ModalText.MODAL_GENERATE_QUESTION_TEXT_3,
            hintValue: 'Piment, tomate, etc..',
            fontSize: 16,
            borderColor: NeutralColor.neutral300,
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Center(
            child: PrimaryButton(
                styleText: TextStyle(
                    fontFamily: 'GilroyMedium',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: PrimaryColor.primary700),
                title: ModalText.MODAL_GENERATE_BUTTON_TEXT,
                press: () {
                  homeController.getMenu(1, homeController.dateDebut.value,
                      homeController.dateFin.value);
                 
                },
                color: PrimaryColor.primary100,
                width: size.width,
                height: 44),
          ),
        ],
      ),
    );
  }
}

class DatePicker extends StatelessWidget {
  const DatePicker({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(width: 1.5, color: NeutralColor.neutral300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            ImageString.calendar,
            color: PrimaryColor.primary700,
          ),
          InkWell(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "GilroyMedium",
                ),
              ),
            ),
          )
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
  final String icon;
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
            SvgPicture.asset(
              icon,
              color: PrimaryColor.primary700,
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
