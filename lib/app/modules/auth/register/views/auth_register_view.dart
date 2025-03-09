// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lesto/app/components/Button/primary_button.dart';
import 'package:lesto/app/components/Dialog/Content/search_content.dart';
import 'package:lesto/app/components/Dialog/bottom_sheet_dialog.dart';
import 'package:lesto/app/components/Dialog/modal_dialog.dart';
import 'package:lesto/app/components/TextField/input_textfield.dart';
import 'package:lesto/app/components/TextField/number_textfield.dart';
import 'package:lesto/app/data/Models/RegisterModel.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import 'package:lesto/app/data/constants/Contents/auth_constant.dart';
import 'package:lesto/app/data/constants/Image/image_constant.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

import '../controllers/auth_register_controller.dart';

class AuthRegisterView extends GetView<AuthRegisterController> {
  const AuthRegisterView({Key? key}) : super(key: key);
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
                controller.isLastPage.value = index == 2;
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
                                            AuthText.REGISTER_TEXT,
                                            style: TextStyle(
                                                letterSpacing: -1.5,
                                                fontFamily: 'GilroyBold',
                                                fontSize: 32,
                                                color: PrimaryColor.primary500),
                                          ),
                                          Text(
                                            AuthText.REGISTER_TEXT_INFO,
                                            style: TextStyle(
                                                fontFamily: 'Gilroy',
                                                fontSize: 14,
                                                color: NeutralColor.neutral600),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.02,
                                          ),
                                          InputTextField(
                                            controller: controller.userName,
                                            hintValue: "Nom d'utilisateur",
                                          ),
                                          NumberTextField(
                                            controller: controller.phone,
                                            hintValue: 'Numero de telephone',
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
                                                "Selectionnez votre pays",
                                                style: TextStyle(
                                                    letterSpacing: -1.5,
                                                    fontFamily: 'GilroyBold',
                                                    fontSize: 32,
                                                    color: PrimaryColor
                                                        .primary500),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Obx(
                                                () => InkWell(
                                                  onTap: () {
                                                    bottomSheetDialog(
                                                        context,
                                                        SearchContent(
                                                          controller:
                                                              controller.search,
                                                          onChanged: (value) {},
                                                          child: Center(
                                                            child: controller
                                                                    .isloading
                                                                    .value
                                                                ? Center(
                                                                    child:
                                                                        const CircularProgressIndicator())
                                                                : SizedBox(
                                                                    child:
                                                                        ListView(
                                                                      scrollDirection:
                                                                          Axis.vertical,
                                                                      children: controller
                                                                          .countries
                                                                          .map(
                                                                              (country) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            controller.selectCountry(country);
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: 15),
                                                                            margin:
                                                                                EdgeInsets.only(bottom: 20),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                SvgPicture.network(
                                                                                  country.flags.svg,
                                                                                  height: 15,
                                                                                  width: 15,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 14,
                                                                                ),
                                                                                Text(
                                                                                  country.name.common,
                                                                                  softWrap: true,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }).toList(),
                                                                    ),
                                                                  ),
                                                          ),
                                                        ),
                                                        size.height * 0.92,
                                                        () => {
                                                              controller
                                                                  .countries
                                                                  .value = []
                                                            });
                                                  },
                                                  child: Container(
                                                    height: 46,
                                                    width: size.width * 0.9,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(13),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: PrimaryColor
                                                                .primary200)),
                                                    child: Row(
                                                      children: [
                                                        controller.countryName
                                                                    .value !=
                                                                ""
                                                            ? SvgPicture.network(
                                                                height: 14,
                                                                width: 14,
                                                                controller
                                                                    .flagCountry
                                                                    .value)
                                                            : Image.asset(
                                                                ImageString
                                                                    .search),
                                                        SizedBox(
                                                          width:
                                                              size.width * 0.02,
                                                        ),
                                                        Text(
                                                            controller.countryName.value !=
                                                                    ""
                                                                ? controller
                                                                    .countryName
                                                                    .value
                                                                : "Selectionnez un pays",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: NeutralColor
                                                                    .neutral800,
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'Gilroy'))
                                                      ],
                                                    ),
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
                      maxLength: 4,
                      onChange: (text) => {},
                      onSubmit: (String pin) {
                        controller.password(pin);
                      },
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
                    title: controller.isLastPage.value
                        ? 'Valider et creer le compte'
                        : 'Suivant',
                    press: () {
                      controller.isLastPage.value
                          ? controller.inscription(
                              RegisterModel(
                                  nom: controller.userName.text,
                                  prenom: controller.userName.text,
                                  password: controller.code.value,
                                  number: controller.phone.text,
                                  email:
                                      '${controller.userName.text}@gmail.com'),
                              context)
                          : controller.nextPage();
                      controller.isSubmitingData.value
                          ? showAlert(
                              context,
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 35),
                                child: Row(children: [
                                  CircularProgressIndicator(
                                    color: PrimaryColor.primary400,
                                  ),
                                  SizedBox(
                                    width: 14,
                                  ),
                                  Text(
                                    "Création de compte en cours",
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontFamily: 'Gilroy',
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
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
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
