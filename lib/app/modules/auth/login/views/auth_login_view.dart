import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesto/app/data/models/login_model.dart';
import 'package:lesto/app/data/constants/colors/color_neutral.dart';
import 'package:lesto/app/data/constants/colors/color_primary.dart';
import 'package:lesto/app/routes/app_pages.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lesto/app/modules/auth/login/controllers/auth_login_controller.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class AuthLoginView extends GetView<AuthLoginController> {
  const AuthLoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Obx(() => controller.currentPageLogin.value > 0
            ? IconButton(
                onPressed: () => controller.pageControllerLogin.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                ),
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: NeutralColor.neutral800, size: 20),
              )
            : IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close_rounded,
                    color: NeutralColor.neutral800),
              )),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.pageControllerLogin,
                onPageChanged: (index) {
                  controller.currentPageLogin.value = index;
                  controller.isFirstPageLogin.value = index == 0;
                  controller.isLastPageLogin.value = index == 1;
                },
                children: [
                  _buildPhonePage(context),
                  _buildOtpPage(context),
                ],
              ),
            ),
            _buildBottomSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPhonePage(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Bon retour parmi nous !",
            style: TextStyle(
              fontFamily: 'GilroyBold',
              fontSize: 28,
              color: NeutralColor.neutral900,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Connectez-vous pour retrouver vos menus personnalisés.",
            style: TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 15,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 48),
          const Text(
            "Numéro de téléphone",
            style: TextStyle(
              fontFamily: 'GilroySemi',
              fontSize: 14,
              color: NeutralColor.neutral700,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: TextField(
              controller: controller.phone,
              keyboardType: TextInputType.phone,
              style: const TextStyle(
                fontFamily: 'GilroySemi',
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: "01 23 45 67 89",
                hintStyle: TextStyle(color: Colors.grey.shade300),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                border: InputBorder.none,
                prefixIcon: const Icon(HugeIcons.strokeRoundedSmartPhone01,
                    size: 20, color: PrimaryColor.primary600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpPage(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Vérification",
            style: TextStyle(
              fontFamily: 'GilroyBold',
              fontSize: 28,
              color: NeutralColor.neutral900,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Entrez le code de vérification envoyé sur votre mobile.",
            style: TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 15,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 48),
          Center(
            child: OtpPinField(
              fieldWidth: 60,
              fieldHeight: 60,
              key: controller.otpPinFieldController,
              autoFillEnable: true,
              otpPinFieldDecoration: OtpPinFieldDecoration.custom,
              otpPinFieldStyle: OtpPinFieldStyle(
                fieldBorderWidth: 1.5,
                defaultFieldBorderColor: Colors.grey.shade100,
                activeFieldBorderColor: PrimaryColor.primary600,
                fieldBorderRadius: 16,
                textStyle: const TextStyle(
                  fontFamily: 'GilroyBold',
                  fontSize: 24,
                  color: PrimaryColor.primary600,
                ),
              ),
              onChange: (text) {},
              maxLength: 4,
              onSubmit: (String pin) {
                controller.password(pin);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: Obx(() => ElevatedButton(
                  onPressed: () {
                    if (controller.isLastPageLogin.value) {
                      controller.connexion(
                        LoginModel(
                          telephone: controller.phone.text,
                          password: controller.code.value,
                        ),
                        context,
                      );
                    } else {
                      controller.nextPage();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PrimaryColor.primary600,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    controller.isLastPageLogin.value
                        ? 'Se connecter'
                        : 'Suivant',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'GilroyBold',
                    ),
                  ),
                )),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Pas encore de compte ?",
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
              ),
              TextButton(
                onPressed: () => Get.toNamed(Routes.AUTH_REGISTER),
                child: const Text(
                  "S'inscrire",
                  style: TextStyle(
                    fontFamily: 'GilroyBold',
                    fontSize: 14,
                    color: PrimaryColor.primary600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
