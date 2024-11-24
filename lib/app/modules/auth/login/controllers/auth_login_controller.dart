// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lesto/app/data/Models/LoginModel.dart';
import 'package:lesto/app/data/providers/auth_provider.dart';
import 'package:lesto/app/routes/app_pages.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class AuthLoginController extends GetxController {
  final pageControl = PageController();
  final isLastPage = false.obs;
  final isFirstPage = true.obs;
  final currentPage = 0.obs;
  final phone = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final box = GetStorage();
  final loading = false.obs;
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

  void connexion(LoginModel loginRequest) async {
    loading.value = true;
    update();
    var loginResponse = await AuthProvider().login(loginRequest);
    if (loginResponse['status'] == "error") {
      loading.value = false;
      update();
      Get.snackbar(
        'Erreur',
        loginResponse['message'],
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        icon: const Icon(
          Icons.error,
          color: Colors.white,
        ),
      );
    } else if (loginResponse['status'] == "success") {
      loading.value = false;
      update();
      box.write('token', loginResponse['token']['token']);
      box.write('id', loginResponse["data"]['id']);
      box.write('nom', loginResponse["data"]['nom']);
      box.write('prenoms', loginResponse["data"]['prenoms']);
      box.write('email', loginResponse["data"]['email']);
      box.write('telephone', loginResponse["data"]['telephone']);
      Get.offAndToNamed(Routes.HOME);
    } else {}
  }
}
