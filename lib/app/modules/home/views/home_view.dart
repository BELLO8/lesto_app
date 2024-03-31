// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesto/app/components/Button/link_button.dart';
import 'package:lesto/app/components/Dialog/bottom_sheet_dialog.dart';
import 'package:lesto/app/components/Dialog/modal_dialog.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import 'package:lesto/app/data/constants/Contents/homescreen_text_constant.dart';
import 'package:lesto/app/data/constants/Image/image_constant.dart';
import 'package:lesto/app/routes/app_pages.dart';

import '../../../components/Dialog/Content/generate_menu_content.dart';
import '../../../components/Dialog/Content/search_content.dart';
import '../../../components/Dialog/Content/user_profil_content.dart';
import '../../../components/EasyDateTime/easy_date_timeline.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 17),
              padding: EdgeInsets.symmetric(vertical: 47),
              child: Column(
                children: [
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: '👋 Salut,',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'GilroySemi')),
                          TextSpan(
                              text: ' Bello',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 27,
                                  fontFamily: 'GilroyBold')),
                          TextSpan(
                              text: ' !',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontFamily: 'GilroySemi')),
                        ]),
                      ),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 1, color: PrimaryColor.primary300)),
                        height: size.height * 0.05,
                        width: size.height * 0.05,
                        child: Image.asset(ImageString.crown),
                      ),
                      SizedBox(
                        width: size.width * 0.06,
                      ),
                      InkWell(
                        radius: 50,
                        onTap: () {
                          bottomSheetDialog(
                              context,
                              UserProfileContent(
                                size: size,
                              ),
                              size.height * 0.67);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                  image: AssetImage(ImageString.avatar))),
                          height: size.height * 0.06,
                          width: size.height * 0.06,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(HomeText.HOMESCREEN_TEXT,
                        style: TextStyle(
                            color: Color(0xFF381712),
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Gilroy')),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  InkWell(
                    onTap: () {
                      bottomSheetDialog(
                          context,
                          SearchContent(
                            controller: controller.search,
                          ),
                          size.height * 0.94);
                    },
                    child: Container(
                      height: 46,
                      width: size.width * 0.9,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(
                              width: 1.5, color: PrimaryColor.primary1000)),
                      child: Row(
                        children: [
                          Image.asset(ImageString.search),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          Text("Rechercher un plat",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFD5C2B9),
                                  fontSize: 16,
                                  fontFamily: 'Gilroy'))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        height: size.height * 0.18,
                        width: size.width,
                        decoration: BoxDecoration(
                            color: PrimaryColor.primary100,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 28),
                              child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Créez des menus',
                                      style: TextStyle(
                                          color: Color(0xFF693025),
                                          fontSize: 22,
                                          fontFamily: 'GilroyBold')),
                                  TextSpan(
                                      text: ' qui',
                                      style: TextStyle(
                                          color: Color(0xFF693025),
                                          fontSize: 16,
                                          fontFamily: 'Gilroy')),
                                  TextSpan(
                                      text: '\n reflètent votre',
                                      style: TextStyle(
                                          color: Color(0xFF693025),
                                          fontSize: 16,
                                          fontFamily: 'Gilroy')),
                                  TextSpan(
                                      text: ' style de vie .',
                                      style: TextStyle(
                                          color: Color(0xFF693025),
                                          fontSize: 19,
                                          fontFamily: 'GilroyBold')),
                                ]),
                              ),
                            ),
                            Container(
                              height: size.height * 0.05,
                              width: size.width * 0.51,
                              margin: const EdgeInsets.only(top: 13, bottom: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.5, color: PrimaryColor.primary800),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  onPressed: () {
                                    showAlert(
                                        context,
                                        GenerateMenuContent(
                                          controller: controller.prohibition,
                                        ),
                                        size.width * 0.85,
                                        size.height * 0.47,
                                        true);
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        ImageString.spinner,
                                        width: 21,
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.01,
                                      ),
                                      Text(HomeText.HOMESCREEN_BUTTON_TEXT,
                                          style: TextStyle(
                                              fontFamily: 'GilroySemi',
                                              fontSize: 14,
                                              color: PrimaryColor.primary800)),
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        right: 0,
                        child: Image.asset(
                          ImageString.food,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 26),
                    child: Row(children: [
                      Text(HomeText.HOMESCREEN_RECOMMANDATION_TEXT,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF381712),
                              fontSize: 19,
                              fontFamily: 'GilroyBold')),
                      Spacer(),
                      LinkButton(
                        title: 'Voir plus',
                        press: () {},
                        width: 105,
                        height: 30,
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: size.height * 0.23,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: controller.menus.map((menu) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            Get.toNamed(Routes.FOOD_DETAIL);
                          },
                          child: Container(
                            width: 180,
                            height: 184,
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: PrimaryColor.primary100),
                            child: Column(
                              children: [
                                Container(
                                  height: 117,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          image: AssetImage(menu['img']),
                                          fit: BoxFit.cover)),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 10),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      alignment: Alignment.center,
                                      width: 114,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.timer,
                                            color: PrimaryColor.primary500,
                                            size: 18,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(menu['timing'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF381712),
                                                  fontSize: 15,
                                                  fontFamily: 'GilroyRegular')),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  child: Column(children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(menu['foodName'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: PrimaryColor.primary1000,
                                              fontSize: 14,
                                              fontFamily: 'GilroySemi')),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("Difficultés: Moyen",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: PrimaryColor.primary600,
                                              fontSize: 12,
                                              fontFamily: 'GilroyRegular')),
                                    ),
                                  ]),
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(HomeText.HOMESCREEN_planification_TEXT,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF381712),
                            fontSize: 19,
                            fontFamily: 'GilroySemi')),
                  ),
                  EasyDateTimeLine(
                    locale: "fr",
                    initialDate: DateTime.now(),
                    onDateChange: (selectedDate) {
                      //`selectedDate` the new date selected.
                    },
                    dayProps: const EasyDayProps(
                      height: 100.0,
                      // You must specify the width in this case.
                      width: 124.0,
                    ),
                    headerProps: const EasyHeaderProps(
                      showSelectedDate: false,
                    ),
                    itemBuilder: (BuildContext context, String dayNumber,
                        dayName, monthName, fullDate, isSelected) {
                      return Container(
                        width: 60.0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 18),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFD06E3F) : null,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              dayNumber,
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'GilroySemi',
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xffD06E3F),
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              dayName,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'GilroyRegular',
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xffD06E3F),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 12),
                    child: Column(children: [
                      Image.asset(
                        ImageString.noMenu,
                        width: 160,
                      ),
                      Text(
                        "Aucun menu généré pour le moment",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'GilroyRegular',
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
