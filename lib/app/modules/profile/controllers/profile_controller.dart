import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final box = GetStorage();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  var userName = "".obs;
  var userEmail = "".obs;
  var userPhone = "".obs;
  var userAvatar = "".obs;

  final List<String> avatars = [
    "assets/images/avatar.png",
    // Add more avatar paths if available, otherwise we will use modern colors/icons
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
}
