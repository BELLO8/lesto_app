// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesto/app/components/Button/link_button.dart';
import 'package:lesto/app/components/Button/primary_button.dart';
import 'package:lesto/app/components/TextField/custom_textfield.dart';
import 'package:lesto/app/components/TextField/custom_textfield_password.dart';
import 'package:lesto/app/data/Models/RegisterModel.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import 'package:lesto/app/data/constants/Contents/auth_constant.dart';
import 'package:lesto/app/data/constants/Contents/label_constant.dart';
import 'package:lesto/app/data/constants/Image/image_constant.dart';
import 'package:lesto/app/routes/app_pages.dart';

import '../controllers/auth_register_controller.dart';

class AuthRegisterView extends GetView<AuthRegisterController> {
  const AuthRegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              ImageString.registerImage,
              width: 230,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Form(
              key: controller.formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 13),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AuthText.REGISTER_TEXT,
                        style: TextStyle(
                            letterSpacing: -1.5,
                            fontFamily: 'GilroyBold',
                            fontSize: 35,
                            color: PrimaryColor.primary900),
                      ),
                      Text(
                        AuthText.REGISTER_TEXT_INFO,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: PrimaryColor.primary900),
                      )
                    ]),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 13),
            child: Column(children: [
              CustomTextField(
                controller: controller.firstName,
                hintValue: LabelText.LABEL_NAME,
                label: 'Nom',
              ),
              CustomTextField(
                controller: controller.lastName,
                hintValue: LabelText.LABEL_LASTNAME,
                label: 'Prenoms',
              ),
              CustomTextField(
                controller: controller.phone,
                hintValue: LabelText.LABEL_PHONE,
                typeInput: TextInputType.phone,
                label: 'Téléphone',
              ),
              CustomTextField(
                controller: controller.country,
                hintValue: LabelText.LABEL_COUNTRY,
                label: 'Nationalité',
              ),
              CustomTextField(
                controller: controller.email,
                typeInput: TextInputType.emailAddress,
                hintValue: LabelText.LABEL_EMAIL,
                label: 'Email',
              ),
              Obx(() => CustomTextfieldPassWord(
                    controller: controller.password,
                    hintValue: 'Mot de passe',
                    isObscure: controller.isOscure.value,
                    label: LabelText.LABEL_PASSWORD,
                    callback: () {
                      controller.obscure();
                    },
                  )),
              SizedBox(
                height: size.height * 0.04,
              ),
              PrimaryButton(
                  styleText: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: NeutralColor.neutral100),
                  title: AuthText.SIGNUP_BUTTON_TEXT,
                  press: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.inscription(RegisterModel(
                          nom: controller.firstName.text,
                          prenoms: controller.lastName.text,
                          password: controller.password.text,
                          telephone: controller.phone.text,
                          email: controller.email.text));
                    }
                  },
                  color: PrimaryColor.primary500,
                  width: 372,
                  height: 56),
              LinkButton(
                title: AuthText.LOGIN_BUTTON_TEXT,
                press: () {
                  Get.offNamed(Routes.LOGIN);
                },
                width: 300,
                height: 30,
              ),
            ]),
          )
        ],
      ),
    ));
  }
}
