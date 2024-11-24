// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesto/app/components/Button/primary_button.dart';
import 'package:lesto/app/components/TextField/number_textfield.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import 'package:lesto/app/data/constants/Contents/auth_constant.dart';
import 'package:lesto/app/data/constants/Image/image_constant.dart';
import 'package:lesto/app/routes/app_pages.dart';
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
            height: size.height * 0.8,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.pageControl,
              onPageChanged: (index) {
                controller.currentPage.value = index;
                controller.isFirstPage.value = index == 0;
                controller.isLastPage.value = index == 1;
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
                                              Text(
                                                controller.phone.text,
                                                style: TextStyle(
                                                    fontFamily: 'GilroyBold',
                                                    fontSize: 14,
                                                    color: PrimaryColor
                                                        .primary500),
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
                    OtpPinField(
                      fieldWidth: 52,
                      fieldHeight: 54,
                      key: controller.otpPinFieldController,
                      autoFillEnable: true,
                      otpPinFieldDecoration: OtpPinFieldDecoration.custom,
                      otpPinFieldStyle: OtpPinFieldStyle(
                          fieldBorderWidth: 1,
                          defaultFieldBorderColor: PrimaryColor.primary200,
                          fieldBorderRadius: 10,
                          textStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              color: PrimaryColor.primary500)),
                      onChange: (text) {
                        print('Enter on change pin is $text');
                      },
                      maxLength: 4,
                      onSubmit: (String pin) {
                        print("OTP Entered: $pin");
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Je n'ai pas reçu,",
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 13,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              "Renvoyer le code",
                              style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: 13,
                                  color: PrimaryColor.primary500),
                            ),
                          ),
                        ),
                      ],
                    )
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
                    title: controller.isLastPage.value ? 'Valider' : 'Suivant',
                    press: () {
                      controller.isLastPage.value
                          ? Get.offAndToNamed(Routes.HOME)
                          // ? showAlert(
                          //     context,
                          //     Container(
                          //       padding: EdgeInsets.symmetric(horizontal: 35),
                          //       child: Row(children: [
                          //         CircularProgressIndicator(
                          //           color: PrimaryColor.primary400,
                          //         ),
                          //         SizedBox(
                          //           width: 14,
                          //         ),
                          //         Text(
                          //           ModalText.MODAL_CONNEXION_TEXT,
                          //           style: TextStyle(
                          //               decoration: TextDecoration.none,
                          //               fontFamily: 'Gilroy',
                          //               fontSize: 14,
                          //               color: Colors.black),
                          //         )
                          //       ]),
                          //     ),
                          //     size.width * 0.85,
                          //     size.height * 0.11,
                          //     false)
                          : controller.phone.text != ""
                              ? controller.pageControl.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn)
                              : null;
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
