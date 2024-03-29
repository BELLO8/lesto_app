import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import 'package:lesto/app/data/constants/Image/image_constant.dart';

import '../controllers/generate_menu_controller.dart';

class GenerateMenuView extends GetView<GenerateMenuController> {
  const GenerateMenuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: PrimaryColor.primary500,
          onPressed: () {},
          child: Image.asset(ImageString.whiteSpinner)),
      appBar: AppBar(
        title: const Text(
          'Menu de la semaine',
          style: TextStyle(
              fontFamily: 'GilroyMedium',
              fontWeight: FontWeight.w600,
              fontSize: 14),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          '',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
