// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lesto/app/data/Models/plat_model.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import 'package:lesto/app/data/constants/Image/image_constant.dart';

import '../../../routes/app_pages.dart';
import '../controllers/generate_menu_controller.dart';

class GenerateMenuView extends GetView<GenerateMenuController> {
  const GenerateMenuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: PrimaryColor.primary600,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: _buildMenusContent(),
    );
  }

  Widget _buildMenusContent() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Menu de la semaine',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: PrimaryColor.primary600.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Pour ${controller.numberOfPeople.value} personnes',
                  style: const TextStyle(
                    color: PrimaryColor.primary700,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: 68,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 16),
            scrollDirection: Axis.horizontal,
            children: controller.generateMenu.asMap().entries.map((day) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: PrimaryColor.primary600,
                ),
                child: InkWell(
                  radius: 10,
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      day.value.name,
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

        // Liste des repas
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: _buildMealsList(),
            ),
          ),
        ),

        // Bouton Voir ma liste de courses
        Container(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: PrimaryColor.primary600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Voir ma liste de courses',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildMealsList() {
    final meals = controller.weeklyMenus[controller.selectedDay.value] ?? [];
    List<Widget> widgets = [];

    for (int i = 0; i < meals.length; i++) {
      final meal = meals[i];

      widgets.add(
        Padding(
          padding: EdgeInsets.only(top: i == 0 ? 0 : 24, bottom: 12),
          child: Row(
            children: [
              Text(
                meal['type'] as String? ?? 'Type inconnu',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      );

      // Carte du plat
      widgets.add(
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: PrimaryColor.primary600.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: PrimaryColor.primary600.withOpacity(0.1)),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: PrimaryColor.primary600.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  meal['icon'] as IconData? ?? Icons.help_outline,
                  color: PrimaryColor.primary600,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal['name'] as String? ?? 'Plat inconnu',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${meal['cuisine'] as String? ?? 'N/A'} • ${meal['regime'] as String? ?? 'N/A'} • ${meal['duration'] as String? ?? 'N/A'}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return widgets;
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
    required this.id,
  });
  final int id;
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
                id: id,
                nom: title,
                duree: time,
                level: period,
                image: image,
                idType: 0,
                description: description));
      },
      child: Container(
        width: 338,
        height: 142,
        margin: EdgeInsets.symmetric(horizontal: 15),
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
                image: image != ""
                    ? DecorationImage(
                        image: NetworkImage(image), fit: BoxFit.cover)
                    : DecorationImage(
                        image: AssetImage(ImageString.defaultImage),
                        fit: BoxFit.cover),
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
                            color: PrimaryColor.primary600,
                            fontSize: 15,
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
