// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import 'package:lesto/app/data/constants/Image/image_constant.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimaryColor.primary600,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageString.backgroundSplashImage),
                fit: BoxFit.cover)),
        child: Center(
          child: Image.asset(
            ImageString.logo,
            width: 154,
            height: 97,
          ),
        ),
      ),
    );
  }
}
