// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lesto/app/data/Models/RegisterModel.dart';
import 'package:lesto/app/data/providers/auth_provider.dart';
import 'package:lesto/app/routes/app_pages.dart';

class AuthRegisterController extends GetxController {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phone = TextEditingController();
  final country = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final fKey = GlobalKey<FormState>();
  final box = GetStorage();
  final countryLabel = "".obs;
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
