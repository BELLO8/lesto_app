// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesto/app/components/Button/primary_button.dart';
import 'package:lesto/app/components/TextField/number_textfield.dart';
import 'package:lesto/app/data/Models/LoginModel.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import 'package:lesto/app/data/constants/Contents/auth_constant.dart';
import 'package:lesto/app/data/constants/Image/image_constant.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

import '../controllers/auth_login_controller.dart';

class AuthLoginView extends GetView<AuthLoginController> {
  const AuthLoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.5,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.pageControllerLogin,
              onPageChanged: (index) {
                controller.currentPageLogin.value = index;
                controller.isFirstPageLogin.value = index == 0;
                controller.isLastPageLogin.value = index == 1;
              },
              children: [
                Stack(
                  children: [
                    Image.asset(ImageString.loginImage),
                    Positioned(
                      top: 140,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          child: Column(children: [
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 13),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AuthText.LOGIN_TEXT,
                                            style: TextStyle(
                                                letterSpacing: -1.5,
                                                fontFamily: 'GilroyBold',
                                                fontSize: 32,
                                                color: PrimaryColor.primary500),
                                          ),
                                          Text(
                                            AuthText.LOGIN_TEXT_INFO,
                                            style: TextStyle(
                                                fontFamily: 'Gilroy',
                                                fontSize: 14,
                                                color: NeutralColor.neutral600),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.03,
                                          ),
                                          NumberTextField(
                                            controller: controller.phone,
                                            hintValue: 'Numero de telephone',
                                          )
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Stack(
                      children: [
                        Image.asset(ImageString.loginImage),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 25),
                          child: IconButton(
                              onPressed: () => {
                                    controller.currentPageLogin.value == 0
                                        ? Get.back()
                                        : controller.pageControllerLogin
                                            .previousPage(
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                curve: Curves.easeIn)
                                  },
                              icon: const Icon(Icons.arrow_back,
                                  color: PrimaryColor.primary600)),
                        ),
                        Positioned(
                          top: 140,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              child: Column(children: [
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 13),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                AuthText.VERFICATION_OTP_TEXT,
                                                style: TextStyle(
                                                    letterSpacing: -1.5,
                                                    fontFamily: 'GilroyBold',
                                                    fontSize: 32,
                                                    color: PrimaryColor
                                                        .primary500),
                                              ),
                                              Text(
                                                AuthText.ENTER_OTP_CODE_TEXT,
                                                style: TextStyle(
                                                    fontFamily: 'Gilroy',
                                                    fontSize: 14,
                                                    color: NeutralColor
                                                        .neutral600),
                                              ),
                                              SizedBox(
                                                width: 250,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 12),
                                                  child: OtpPinField(
                                                    fieldWidth: 52,
                                                    fieldHeight: 54,
                                                    key: controller
                                                        .otpPinFieldController,
                                                    autoFillEnable: true,
                                                    otpPinFieldDecoration:
                                                        OtpPinFieldDecoration
                                                            .custom,
                                                    otpPinFieldStyle: OtpPinFieldStyle(
                                                        fieldBorderWidth: 1,
                                                        defaultFieldBorderColor:
                                                            PrimaryColor
                                                                .primary200,
                                                        fieldBorderRadius: 10,
                                                        textStyle: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 22,
                                                            color: PrimaryColor
                                                                .primary500)),
                                                    onChange: (text) {
                                                      print(
                                                          'Enter on change pin is $text');
                                                    },
                                                    maxLength: 4,
                                                    onSubmit: (String pin) {
                                                      controller.password(pin);
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          Obx(
            () => Container(
              margin: EdgeInsets.symmetric(horizontal: 13),
              child: Column(children: [
                PrimaryButton(
                    styleText: TextStyle(
                        fontFamily: 'GilroySemi',
                        fontSize: 14,
                        color: NeutralColor.neutral100),
                    title: controller.isLastPageLogin.value
                        ? 'Valider'
                        : 'Suivant',
                    press: () {
                      controller.isLastPageLogin.value
                          ? controller.connexion(
                              LoginModel(
                                  telephone: controller.phone.text,
                                  password: controller.code.value),
                              context)
                          : controller.nextPage();
                    },
                    color: PrimaryColor.primary500,
                    width: 372,
                    height: 56),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
