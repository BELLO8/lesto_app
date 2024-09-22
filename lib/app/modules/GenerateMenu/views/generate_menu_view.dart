// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lesto/app/components/Button/primary_button.dart';
import 'package:lesto/app/data/Models/plat_model.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import 'package:lesto/app/data/constants/Image/image_constant.dart';

import '../../../routes/app_pages.dart';
import '../controllers/generate_menu_controller.dart';

class GenerateMenuView extends GetView<GenerateMenuController> {
  const GenerateMenuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: PrimaryButton(
        title: "Génerer la liste des courses",
        press: () {},
        color: PrimaryColor.primary600,
        width: size.width * 0.6,
        height: size.height * 0.042,
        styleText: TextStyle(
            fontFamily: 'GilroyMedium',
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: PrimaryColor.primary600),
        title: const Text(
          'Menu de la semaine',
          style: TextStyle(
              fontFamily: 'GilroyMedium',
              fontWeight: FontWeight.w600,
              fontSize: 14),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 68,
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 16),
              scrollDirection: Axis.horizontal,
              children: controller.generateMenu.asMap().entries.map((days) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xFFD98B65),
                  ),
                  child: InkWell(
                    radius: 10,
                    onTap: () {
                      controller.scrollController.animateTo(days.key * 350.0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        days.value.name,
                        style: TextStyle(
                            fontFamily: 'GilroyMedium',
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Colors.white),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
              child: Obx(
            () => controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    controller: controller.scrollController,
                    children: controller.generateMenu.map((menu) {
                      return SizedBox(
                        height: 350,
                        child: Column(
                          children: [
                            Container(
                              color: PrimaryColor.primary700,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              height: 38,
                              child: Row(
                                children: [
                                  Text(
                                    "${menu.name}${" "}${DateFormat('dd MMMM yyyy', 'fr_FR').format(menu.date)}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontFamily: 'GilroyMedium'),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.autorenew,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Column(
                                children: menu.plats
                                    .asMap()
                                    .entries
                                    .map<Widget>((entry) {
                                  int index = entry.key;
                                  var dish = entry.value;
                                  return GenerateFoodWidget(
                                    size: size,
                                    borderWidth: 0,
                                    borderColor: Colors.transparent,
                                    backgroundColor: Colors.white,
                                    image: dish.image,
                                    title: dish.libelle,
                                    description: dish.description,
                                    time: dish.duree,
                                    period: index == 0 ? 'Midi' : 'Soir',
                                    icon: index == 0
                                        ? ImageString.sun
                                        : ImageString.moon,
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
          )),
        ],
      ),
    );
  }
}

class GenerateFoodWidget extends StatelessWidget {
  const GenerateFoodWidget({
    super.key,
    required this.size,
    required this.borderWidth,
    required this.borderColor,
    required this.backgroundColor,
    required this.image,
    required this.title,
    required this.description,
    required this.time,
    required this.period,
    required this.icon,
  });

  final Size size;
  final double borderWidth;
  final Color borderColor;
  final Color backgroundColor;
  final String image;
  final String title;
  final String description;
  final String time;
  final String period;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.FOOD_DETAIL,
            arguments: Plat(
                id: 2,
                nom: title,
                duree: time,
                level: period,
                image: image,
                idType: 5,
                description: description));
      },
      child: Container(
        width: 338,
        height: 142,
        margin: EdgeInsets.symmetric(horizontal: 30),
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            border: Border.all(width: borderWidth, color: borderColor),
            borderRadius: BorderRadius.circular(15),
            color: backgroundColor),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.5,
                      child: Text(
                        title,
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: PrimaryColor.primary900,
                            fontSize: 18,
                            fontFamily: 'GilroySemi'),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.5,
                      child: Text(
                        description,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            fontFamily: 'GilroyRegular'),
                      ),
                    ),
                    SizedBox(
                      child: Row(children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.timer,
                                color: PrimaryColor.primary500,
                                size: 20,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                time,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    fontFamily: 'GilroyRegular'),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                icon,
                                color: PrimaryColor.primary700,
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                period,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    fontFamily: 'GilroyRegular'),
                              )
                            ],
                          ),
                        )
                      ]),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
