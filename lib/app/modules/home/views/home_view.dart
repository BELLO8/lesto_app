// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lesto/app/components/Dialog/Content/generate_menu_content.dart';
import 'package:lesto/app/components/Dialog/bottom_sheet_dialog.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import 'package:lesto/app/data/constants/Contents/homescreen_text_constant.dart';
import 'package:lesto/app/data/constants/Image/image_constant.dart';
import 'package:lesto/app/routes/app_pages.dart';

import '../../../components/Dialog/Content/search_content.dart';
import '../../../components/Dialog/Content/user_profil_content.dart';
import '../../../components/EasyDateTime/easy_date_timeline.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final box = GetStorage();
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
                              text: box.read('prenoms'),
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
                              size.height * 0.67,
                              () => {});
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
                            color: PrimaryColor.primary900,
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
                            onChanged: (value) {
                              controller.searchPlat(value);
                            },
                            child: Center(
                              child: Obx(
                                () => controller.isloading.value
                                    ? Center(
                                        child:
                                            const CircularProgressIndicator())
                                    : SizedBox(
                                        child: ListView(
                                          scrollDirection: Axis.vertical,
                                          children: controller.searchPlatList
                                              .map((plat) {
                                            return InkWell(
                                              onTap: () {
                                                Get.toNamed(Routes.FOOD_DETAIL,
                                                    arguments: plat);
                                              },
                                              child: Container(
                                                width: 338,
                                                height: 118,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 5, vertical: 4),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1.2,
                                                        color: PrimaryColor
                                                            .primary200),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: PrimaryColor
                                                        .transparent),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  plat.image),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 8,
                                                              horizontal: 8),
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  size.width *
                                                                      0.5,
                                                              child: Text(
                                                                plat.nom,
                                                                softWrap: true,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: PrimaryColor
                                                                        .primary900,
                                                                    fontSize:
                                                                        18,
                                                                    fontFamily:
                                                                        'GilroySemi'),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  size.width *
                                                                      0.5,
                                                              child: Text(
                                                                plat.description,
                                                                maxLines: 2,
                                                                softWrap: true,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        13,
                                                                    fontFamily:
                                                                        'GilroyRegular'),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              child: Row(
                                                                  children: [
                                                                    Container(
                                                                      margin: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              5),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.timer,
                                                                            color:
                                                                                PrimaryColor.primary500,
                                                                            size:
                                                                                18,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                3,
                                                                          ),
                                                                          Text(
                                                                            plat.duree,
                                                                            style: TextStyle(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize: 13,
                                                                                fontFamily: 'GilroyRegular'),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      margin: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              5,
                                                                          horizontal:
                                                                              8),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.wb_sunny_rounded,
                                                                            color:
                                                                                PrimaryColor.primary500,
                                                                            size:
                                                                                20,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                3,
                                                                          ),
                                                                          Text(
                                                                            plat.level,
                                                                            style: TextStyle(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize: 13,
                                                                                fontFamily: 'GilroyRegular'),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ]),
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
                              ),
                            ),
                          ),
                          size.height * 0.92,
                          () => {controller.searchPlatList.value = []});
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
                                  color: NeutralColor.neutral300,
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
                        height: size.height * 0.2,
                        width: size.width,
                        decoration: BoxDecoration(
                            color: PrimaryColor.primary100,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Créez des menus',
                                      style: TextStyle(
                                          color: PrimaryColor.primary900,
                                          fontSize: 22,
                                          fontFamily: 'GilroyBold')),
                                  TextSpan(
                                      text: ' qui',
                                      style: TextStyle(
                                          color: PrimaryColor.primary900,
                                          fontSize: 16,
                                          fontFamily: 'Gilroy')),
                                  TextSpan(
                                      text: '\n reflètent votre',
                                      style: TextStyle(
                                          color: PrimaryColor.primary900,
                                          fontSize: 16,
                                          fontFamily: 'Gilroy')),
                                  TextSpan(
                                      text: ' style de vie .',
                                      style: TextStyle(
                                          color: PrimaryColor.primary900,
                                          fontSize: 19,
                                          fontFamily: 'GilroyBold')),
                                ]),
                              ),
                            ),
                            Container(
                              height: size.height * 0.05,
                              width: size.width * 0.55,
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
                                    box.read('menu') == null
                                        ? bottomSheetDialog(
                                            context,
                                            GenerateMenuContent(
                                              controller:
                                                  controller.prohibition,
                                            ),
                                            size.height * 0.67,
                                            () => {})
                                        : Get.toNamed(Routes.GENERATE_MENU);
                                  },
                                  child: Row(
                                    children: [
                                      box.read('menu') == null
                                          ? Image.asset(
                                              ImageString.spinner,
                                              width: 21,
                                              height: 20,
                                            )
                                          : Text(""),
                                      SizedBox(
                                        width: size.width * 0.01,
                                      ),
                                      Text(
                                          // ignore: unnecessary_null_comparison
                                          box.read('menu') == null
                                              ? HomeText.HOMESCREEN_BUTTON_TEXT
                                              : 'Afficher le menu géneré',
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
                        top: 35,
                        bottom: 0,
                        right: 0,
                        child: Image.asset(
                          ImageString.food,
                          width: 110,
                          height: 110,
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
                              color: PrimaryColor.primary900,
                              fontSize: 19,
                              fontFamily: 'GilroyBold')),
                      Spacer(),
                      // LinkButton(
                      //   title: 'Voir plus',
                      //   press: () {},
                      //   width: 105,
                      //   height: 30,
                      // ),
                    ]),
                  ),
                  SizedBox(
                    height: size.height * 0.25,
                    child: Obx(
                      () => controller.loading.value
                          ? const Center(child: CircularProgressIndicator())
                          : controller.platList.isNotEmpty
                              ? ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: controller.platList.map((menu) {
                                    return InkWell(
                                      borderRadius: BorderRadius.circular(15),
                                      onTap: () {
                                        Get.toNamed(Routes.FOOD_DETAIL,
                                            arguments: menu);
                                      },
                                      child: Container(
                                        width: size.width * 0.5,
                                        height: 184,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 12),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: PrimaryColor.primary100),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 117,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        menu.image),
                                                    fit: BoxFit.cover),
                                              ),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 10),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  alignment: Alignment.center,
                                                  width: size.width * 0.24,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.timer,
                                                        color: PrimaryColor
                                                            .primary500,
                                                        size: 18,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text(menu.duree,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: PrimaryColor
                                                                  .primary900,
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'GilroyRegular')),
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
                                                  child: Text(menu.nom,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: PrimaryColor
                                                              .primary1000,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'GilroySemi')),
                                                ),
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                      "Difficultés: ${menu.level}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: PrimaryColor
                                                              .primary600,
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'GilroyRegular')),
                                                ),
                                              ]),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                )
                              : Container(
                                  margin: EdgeInsets.symmetric(vertical: 40),
                                  child: Column(children: [
                                    Image.asset(
                                      ImageString.noMenu,
                                      width: 100,
                                    ),
                                    Text(
                                      "Aucune recommandation de plats",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'GilroyRegular',
                                      ),
                                    ),
                                  ]),
                                ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(HomeText.HOMESCREEN_planification_TEXT,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: PrimaryColor.primary900,
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
                          color: isSelected ? PrimaryColor.primary600 : null,
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
                                    : PrimaryColor.primary600,
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
                                    : PrimaryColor.primary600,
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
                      // SizedBox(
                      //   width: 355,
                      //   height: 165,
                      //   child: Stack(
                      //     children: <Widget>[
                      //       Container(
                      //         width: 355,
                      //         height: 165,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(20),
                      //           image: DecorationImage(
                      //               image: AssetImage(ImageString.food2),
                      //               fit: BoxFit.cover),
                      //         ),
                      //       ),
                      //       Container(
                      //         padding: const EdgeInsets.all(5.0),
                      //         alignment: Alignment.bottomCenter,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(20),
                      //           gradient: LinearGradient(
                      //             begin: Alignment.topCenter,
                      //             end: Alignment.bottomCenter,
                      //             colors: <Color>[
                      //               Color(0x1F825221),
                      //               Color(0xAF301902),
                      //             ],
                      //           ),
                      //         ),
                      //         child: Align(
                      //           alignment: Alignment.topRight,
                      //           child: Container(
                      //             margin: EdgeInsets.symmetric(
                      //                 horizontal: 8, vertical: 10),
                      //             padding: EdgeInsets.symmetric(horizontal: 5),
                      //             alignment: Alignment.center,
                      //             width: 114,
                      //             height: 30,
                      //             decoration: BoxDecoration(
                      //                 color: Colors.white,
                      //                 borderRadius: BorderRadius.circular(50)),
                      //             child: Row(
                      //               children: [
                      //                 Icon(
                      //                   Icons.timer,
                      //                   color: PrimaryColor.primary500,
                      //                   size: 18,
                      //                 ),
                      //                 SizedBox(
                      //                   width: 4,
                      //                 ),
                      //                 Text("15-18 mins",
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                         fontWeight: FontWeight.w600,
                      //                         color: Color(0xFF381712),
                      //                         fontSize: 15,
                      //                         fontFamily: 'GilroyRegular')),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
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
