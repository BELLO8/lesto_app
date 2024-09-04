// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesto/app/components/Button/link_button.dart';
import 'package:lesto/app/components/Button/primary_button.dart';
import 'package:lesto/app/components/Container/container_image.dart';
import 'package:lesto/app/components/Dialog/modal_dialog.dart';
import 'package:lesto/app/components/TextField/custom_textfield.dart';
import 'package:lesto/app/components/TextField/custom_textfield_password.dart';
import 'package:lesto/app/data/Models/LoginModel.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import 'package:lesto/app/data/constants/Contents/auth_constant.dart';
import 'package:lesto/app/data/constants/Contents/label_constant.dart';
import 'package:lesto/app/data/constants/Contents/modal_text_constant.dart';
import 'package:lesto/app/data/constants/Image/image_constant.dart';
import 'package:lesto/app/routes/app_pages.dart';

import '../controllers/auth_login_controller.dart';

class AuthLoginView extends GetView<AuthLoginController> {
  const AuthLoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: ImageContainer(
            size: size,
            backgroundImage: ImageString.loginImage,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: size.height * 0.67,
                child: Column(children: [
                  Form(
                    key: controller.formKey,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 13),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AuthText.LOGIN_TEXT,
                                      style: TextStyle(
                                          letterSpacing: -1.5,
                                          fontFamily: 'GilroyBold',
                                          fontSize: 35,
                                          color: PrimaryColor.primary900),
                                    ),
                                    Text(
                                      AuthText.LOGIN_TEXT_INFO,
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          color: PrimaryColor.primary900),
                                    )
                                  ]),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 13),
                            child: Column(children: [
                              CustomTextField(
                                validate: (telephone) {
                                  if (telephone == null || telephone.isEmpty) {
                                    return 'Le mot de passe ne peut être vide';
                                  }
                                  if (telephone.length != 10) {
                                    return "Telephone doit être egale a 10 chiffres";
                                  }
                                  return null;
                                },
                                controller: controller.phone,
                                hintValue: AuthText.LOGIN_LABEL_PHONE,
                                label: AuthText.LOGIN_LABEL_PHONE,
                              ),
                              Obx(() => CustomTextfieldPassWord(
                                    validate: (password) {
                                      if (password == null ||
                                          password.isEmpty) {
                                        return 'Le mot de passe ne peut être vide';
                                      }
                                      if (password.length < 8) {
                                        return 'Mot de passe trop court 8 caractères au minimum';
                                      }
                                      return null;
                                    },
                                    controller: controller.password,
                                    hintValue: 'Mot de passe',
                                    isObscure: controller.isOscure.value,
                                    label: LabelText.LABEL_PASSWORD,
                                    callback: () {
                                      controller.obscure();
                                    },
                                  )),
                              Align(
                                alignment: Alignment.topRight,
                                child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Mot de passe oublié ?',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          color: PrimaryColor.primary900),
                                    )),
                              ),
                              PrimaryButton(
                                  styleText: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      color: NeutralColor.neutral100),
                                  title: AuthText.LOGIN_TEXT,
                                  press: () {
                                    if (controller.formKey.currentState!
                                        .validate()) {
                                      controller.connexion(LoginModel(
                                          telephone: controller.phone.text,
                                          password: controller.password.text));
                                    }
                                    controller.loading.value
                                        ? showAlert(
                                            context,
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 35),
                                              child: Row(children: [
                                                CircularProgressIndicator(
                                                  color:
                                                      PrimaryColor.primary400,
                                                ),
                                                SizedBox(
                                                  width: 14,
                                                ),
                                                Text(
                                                  ModalText
                                                      .MODAL_CONNEXION_TEXT,
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontFamily: 'Gilroy',
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                )
                                              ]),
                                            ),
                                            size.width * 0.85,
                                            size.height * 0.11,
                                            false)
                                        : null;
                                  },
                                  color: PrimaryColor.primary500,
                                  width: 372,
                                  height: 56),
                              LinkButton(
                                title: AuthText.ALREADY_CONNECT,
                                press: () {
                                  Get.offNamed(Routes.AUTH_REGISTER);
                                },
                                width: 300,
                                height: 30,
                              ),
                            ]),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            )));
  }
}
