// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lesto/app/components/Dialog/Content/search_content.dart';
import 'package:lesto/app/components/Dialog/bottom_sheet_dialog.dart';
import 'package:lesto/app/data/models/register_model.dart';
import 'package:lesto/app/data/constants/colors/color_neutral.dart';
import 'package:lesto/app/data/constants/colors/color_primary.dart';
import 'package:lesto/app/routes/app_pages.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:lesto/app/modules/auth/register/controllers/auth_register_controller.dart';

class AuthRegisterView extends GetView<AuthRegisterController> {
  const AuthRegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Obx(() => IconButton(
              onPressed: () {
                if (controller.currentPage.value == 0) {
                  Get.back();
                } else {
                  controller.pageControl.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                }
              },
              icon: Icon(
                controller.currentPage.value == 0
                    ? Icons.close_rounded
                    : Icons.arrow_back_ios_new_rounded,
                color: NeutralColor.neutral800,
                size: 20,
              ),
            )),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.pageControl,
                onPageChanged: (index) {
                  controller.currentPage.value = index;
                  controller.isFirstPage.value = index == 0;
                  controller.isLastPage.value = index == 2;
                },
                children: [
                  _buildPersonalInfoPage(context),
                  _buildCountryPage(context),
                  _buildOtpVerificationPage(context),
                ],
              ),
            ),
            _buildBottomSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoPage(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Créez votre compte",
            style: TextStyle(
              fontFamily: 'GilroyBold',
              fontSize: 28,
              color: NeutralColor.neutral900,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Rejoignez Lesto pour simplifier votre cuisine quotidienne.",
            style: TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 15,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 40),
          _buildInputField(
            label: "Nom d'utilisateur",
            controller: controller.userName,
            hint: "Comment devrions-nous vous appeler ?",
            icon: HugeIcons.strokeRoundedUser,
          ),
          const SizedBox(height: 24),
          _buildInputField(
            label: "Numéro de téléphone",
            controller: controller.phone,
            hint: "01 23 45 67 89",
            icon: HugeIcons.strokeRoundedSmartPhone01,
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }

  Widget _buildCountryPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Où habitez-vous ?",
            style: TextStyle(
              fontFamily: 'GilroyBold',
              fontSize: 28,
              color: NeutralColor.neutral900,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Cela nous aide à vous proposer des ingrédients locaux.",
            style: TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 15,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 48),
          const Text(
            "Pays de résidence",
            style: TextStyle(
              fontFamily: 'GilroySemi',
              fontSize: 14,
              color: NeutralColor.neutral700,
            ),
          ),
          const SizedBox(height: 12),
          Obx(() => GestureDetector(
                onTap: () => _showCountryPicker(context),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  child: Row(
                    children: [
                      if (controller.countryName.value.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: SvgPicture.network(
                            controller.flagCountry.value,
                            width: 20,
                            height: 15,
                          ),
                        )
                      else
                        const Icon(HugeIcons.strokeRoundedGlobal,
                            size: 20, color: PrimaryColor.primary600),
                      if (controller.countryName.value.isEmpty)
                        const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          controller.countryName.value.isEmpty
                              ? "Sélectionnez votre pays"
                              : controller.countryName.value,
                          style: TextStyle(
                            fontFamily: 'GilroySemi',
                            fontSize: 16,
                            color: controller.countryName.value.isEmpty
                                ? Colors.grey.shade400
                                : NeutralColor.neutral900,
                          ),
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down_rounded,
                          color: Colors.grey),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildOtpVerificationPage(BuildContext context) {
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

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
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
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(
              fontFamily: 'GilroySemi',
              fontSize: 16,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade300),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              border: InputBorder.none,
              prefixIcon: Icon(icon, size: 20, color: PrimaryColor.primary600),
            ),
          ),
        ),
      ],
    );
  }

  void _showCountryPicker(BuildContext context) {
    bottomSheetDialog(
      context,
      SearchContent(
        controller: controller.search,
        onChanged: (value) {},
        child: Obx(() {
          if (controller.isloading.value) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: CircularProgressIndicator(),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 10),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.countries.length,
            separatorBuilder: (context, index) =>
                Divider(height: 1, color: Colors.grey.shade100),
            itemBuilder: (context, index) {
              final country = controller.countries[index];
              return ListTile(
                onTap: () {
                  controller.selectCountry(country);
                  Navigator.pop(context);
                },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: SvgPicture.network(
                    country.flags.svg,
                    width: 24,
                    height: 18,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  country.name.common,
                  style: const TextStyle(
                    fontFamily: 'GilroySemi',
                    fontSize: 15,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right_rounded, size: 20),
              );
            },
          );
        }),
      ),
      MediaQuery.of(context).size.height * 0.8,
      () => controller.countries.value = [],
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
                    if (controller.isLastPage.value) {
                      controller.inscription(
                        RegisterModel(
                          nom: controller.userName.text,
                          prenom: controller.userName.text,
                          password: controller.code.value,
                          number: controller.phone.text,
                          email: '${controller.userName.text}@gmail.com',
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
                    controller.isLastPage.value
                        ? 'Créer mon compte'
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
                "Déjà un compte ?",
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
              ),
              TextButton(
                onPressed: () => Get.toNamed(Routes.LOGIN),
                child: const Text(
                  "Se connecter",
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
