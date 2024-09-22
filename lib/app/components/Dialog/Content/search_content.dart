// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesto/app/modules/home/controllers/home_controller.dart';

import '../../../data/constants/Colors/color_primary.dart';
import '../../../data/constants/Image/image_constant.dart';

class SearchContent extends StatelessWidget {
  const SearchContent({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.child,
  });
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final homeController = Get.put(HomeController());
    return Container(
      margin: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: Column(children: [
        Container(
          height: 46,
          width: size.width * 0.9,
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(width: 1.2, color: PrimaryColor.primary400)),
          child: Row(
            children: [
              Image.asset(ImageString.search),
              SizedBox(
                width: size.width * 0.02,
              ),
              SizedBox(
                width: size.width * 0.7,
                child: TextFormField(
                  onChanged: onChanged,
                  cursorColor: PrimaryColor.primary600,
                  controller: controller,
                  style: TextStyle(
                    fontFamily: "Poppins",
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    border: InputBorder.none,
                    fillColor: PrimaryColor.transparent,
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: PrimaryColor.primary200,
                        fontSize: 16,
                        fontFamily: 'Gilroy'),
                    hintText: "Rechercher un plat",
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
        // Align(
        //     alignment: Alignment.topLeft,
        //     child: Obx(
        //       () => Text(
        //         "${homeController.searchPlatList.length} élements trouvés",
        //         style: TextStyle(
        //             fontWeight: FontWeight.w600,
        //             fontSize: 18,
        //             fontFamily: 'GilroySemi'),
        //       ),
        //     )),
        SizedBox(
          height: size.height * 0.78,
          child: child,
        )
      ]),
    );
  }
}
