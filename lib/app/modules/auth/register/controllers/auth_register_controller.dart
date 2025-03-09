// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lesto/app/data/Models/RegisterModel.dart';
import 'package:lesto/app/data/Models/country_model.dart';
import 'package:lesto/app/data/providers/auth_provider.dart';
import 'package:lesto/app/routes/app_pages.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:toastification/toastification.dart';

class AuthRegisterController extends GetxController {
  final search = TextEditingController();
  final userName = TextEditingController();
  final phone = TextEditingController();
  final box = GetStorage();
  final pageControl = PageController();
  final isSubmitingData = false.obs;
  final countryName = "".obs;
  final flagCountry = "".obs;
  final isLastPage = false.obs;
  final isFirstPage = true.obs;
  final currentPage = 0.obs;
  final otpPinFieldController = GlobalKey<OtpPinFieldState>();
  final isloading = true.obs;
  var countries = <Country>[].obs;
  var code = "".obs;

  @override
  void onInit() {
    super.onInit();
    getAllCountry();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void password(text) {
    code.value = text;
  }

  Future<void> getAllCountry() async {
    try {
      isloading.value = true;
      countries.value = await AuthProvider().getAllCountry();
    } finally {
      isloading.value = false;
    }
  }

  void nextPage() {
    phone.text != "" && userName.text != ""
        ? pageControl.nextPage(
            duration: const Duration(milliseconds: 500), curve: Curves.easeIn)
        : null;
  }

  void selectCountry(country) {
    countryName.value = country.name.common;
    flagCountry.value = country.flags.svg;
  }

  void inscription(RegisterModel registerRequest, context) async {
    try {
      isSubmitingData.value = true;
      var response = await AuthProvider().register(registerRequest);
      if (response['status'] == 'success') {
        box.write('id', response["data"]['id']);
        box.write('nom', response["data"]['nom']);
        box.write('prenoms', response["data"]['prenoms']);
        box.write('email', response["data"]['email']);
        box.write('telephone', response["data"]['telephone']);
        Get.offNamed(Routes.HOME);
      } else {
        toastification.show(
          context: context,
          type: ToastificationType.error,
          style: ToastificationStyle.flat,
          title: const Text(
            "Oops ! une erreur s'est produite.",
            style: TextStyle(fontFamily: 'GilroySemi', color: Colors.red),
          ),
          autoCloseDuration: const Duration(seconds: 3),
        );
        isSubmitingData.value = false;
      }
    } finally {
      isSubmitingData.value = false;
    }
  }
}
