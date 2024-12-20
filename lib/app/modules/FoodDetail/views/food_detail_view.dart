// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesto/app/components/Video/VideoPlayer.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';

import '../../../components/Button/primary_button.dart';
import '../../../data/constants/Colors/color_primary.dart';
import '../../../data/constants/Contents/text_constant.dart';
import '../controllers/food_detail_controller.dart';

class FoodDetailView extends GetView<FoodDetailController> {
  const FoodDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 18),
        height: 73,
        child: Row(
          children: [
            Text(
              '0 Fcfa',
              style: TextStyle(
                fontFamily: 'GilroyBold',
                fontSize: 14,
              ),
            ),
            Spacer(),
            PrimaryButton(
                styleText: TextStyle(
                    fontFamily: 'GilroyMedium',
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: NeutralColor.neutral100),
                title: OtherText.CALCULATE_BUTTON_TEXT,
                press: () {},
                color: PrimaryColor.primary500,
                width: 224,
                height: 44),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: PrimaryColor.primary600),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                height: size.height * 0.25,
                child: VideoApp(),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.argumentData['nom'],
                      style: TextStyle(
                          fontFamily: 'GilroySemi',
                          fontSize: 26,
                          color: PrimaryColor.primary500,
                          letterSpacing: -2),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: PrimaryColor.primary600,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          controller.argumentData['duree'],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'GilroyBold'),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          '| Difficultés: ${controller.argumentData['level']}',
                          style: TextStyle(
                              color: NeutralColor.neutral400,
                              fontSize: 14,
                              fontFamily: 'GilroyBold'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Description",
                      style: TextStyle(
                        fontFamily: 'GilroyBold',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: PrimaryColor.primary900,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                      child: Text(
                        controller.argumentData["description"],
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            fontFamily: 'GilroyRegular'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 36,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonOptionTab(
                          size: size,
                          label: 'Ingredients',
                          onPressed: () {
                            controller.pageController.animateToPage(0,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          },
                          color: PrimaryColor.primary500),
                      ButtonOptionTab(
                          size: size,
                          label: 'Mode de préparation',
                          onPressed: () {
                            controller.pageController.animateToPage(1,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          },
                          color: PrimaryColor.primary500),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                height: size.height * 0.7,
                child: PageView(
                  controller: controller.pageController,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: SingleChildScrollView(
                        child: Column(
                            children: controller.ingredients.map((item) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 4),
                            child: IngredientWidget(
                              size: size,
                              name: item['name'],
                              quantity: item['quantity'],
                            ),
                          );
                        }).toList()),
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            child: Text(
                              'Mode de preparation',
                              style: TextStyle(
                                  fontFamily: 'GilroySemi', fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IngredientWidget extends StatelessWidget {
  const IngredientWidget({
    super.key,
    required this.size,
    required this.name,
    required this.quantity,
  });

  final Size size;
  final String name;
  final String quantity;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: PrimaryColor.primary100),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: size.width * 0.75,
          child: Row(
            children: [
              Text(
                name,
                style: TextStyle(fontFamily: 'GilroyBold', fontSize: 15),
              ),
              Spacer(),
              Text(
                quantity,
                style: TextStyle(fontFamily: 'GilroyBold', fontSize: 15),
              )
            ],
          ),
        )
      ],
    );
  }
}

class ButtonOptionTab extends StatelessWidget {
  const ButtonOptionTab(
      {super.key,
      required this.size,
      required this.label,
      required this.onPressed,
      required this.color});
  final String label;
  final Size size;
  final void Function() onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 10,
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
        height: size.height * 0.04,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: color,
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Text(
          label,
          style: TextStyle(
              fontFamily: 'GilroyMedium',
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: Colors.white),
        ),
      ),
    );
  }
}
