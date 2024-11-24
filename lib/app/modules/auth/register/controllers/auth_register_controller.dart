// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lesto/app/data/Models/RegisterModel.dart';
import 'package:lesto/app/data/providers/auth_provider.dart';
import 'package:lesto/app/routes/app_pages.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class AuthRegisterController extends GetxController {
  final userName = TextEditingController();
  final phone = TextEditingController();
  final box = GetStorage();
  final pageControl = PageController();
  final isLastPage = false.obs;
  final isFirstPage = true.obs;
  final currentPage = 0.obs;
  final otpPinFieldController = GlobalKey<OtpPinFieldState>();

  var isOscure = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void obscure() {
    isOscure.value = !isOscure.value;
  }

  void inscription(RegisterModel registerRequest) async {
    var response = await AuthProvider().register(registerRequest);
    if (response['status'] == 'success') {
      box.write('id', response["data"]['id']);
      box.write('nom', response["data"]['nom']);
      box.write('prenoms', response["data"]['prenoms']);
      box.write('email', response["data"]['email']);
      box.write('telephone', response["data"]['telephone']);

      Get.snackbar('Succès', response['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          icon: const Icon(
            Icons.check,
            color: Colors.white,
          ));
      Get.offNamed(Routes.HOME);
    }
  }
}
