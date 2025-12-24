import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lesto/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  final box = GetStorage();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  var userName = "".obs;
  var userEmail = "".obs;
  var userPhone = "".obs;
  var userAvatar = "".obs;
  var currentLanguage = "Français".obs;

  void changeLanguage(String lang) {
    currentLanguage.value = lang;
    box.write('language', lang);
    Get.back();
  }

  final List<String> avatars = [
    "assets/images/avatar.png",
    "assets/images/food1.png",
    "assets/images/food2.png",
    "assets/images/food3.png",
    "assets/images/imagePizza.png",
  ];

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    userName.value = box.read('nom') ?? "Lesto User";
    userEmail.value = box.read('email') ?? "email@example.com";
    userPhone.value = box.read('telephone') ?? "";
    userAvatar.value = box.read('avatar') ?? "assets/images/avatar.png";

    nameController.text = userName.value;
    emailController.text = userEmail.value;
    phoneController.text = userPhone.value;
  }

  void updateProfile() {
    // Logic to save updated info locally or via API
    box.write('nom', nameController.text);
    box.write('email', emailController.text);
    box.write('telephone', phoneController.text);

    userName.value = nameController.text;
    userEmail.value = emailController.text;
    userPhone.value = phoneController.text;

    Get.snackbar("Succès", "Profil mis à jour",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

  void changeAvatar(String avatarPath) {
    userAvatar.value = avatarPath;
    box.write('avatar', avatarPath);
    Get.back(); // Close modal
  }

  void logout() {
    box.erase(); // Clear all stored data
    Get.offAllNamed(Routes.AUTH_LOGIN); // Navigate to login and clear stack
  }
}
