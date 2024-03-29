// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';

import '../../../data/constants/Colors/color_primary.dart';
import '../../../data/constants/Image/image_constant.dart';

class SearchContent extends StatelessWidget {
  const SearchContent({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Map<String, dynamic>> menus = [
      {
        'img': ImageString.food2,
        'timing': '2 h 30 min',
        'time': 'midi',
        'foodName': 'Sauce gouagouassou',
        'level': 'Difficultés: Moyen',
        'description':
            'Oignons frais, daurades fraîches à couper en 2 morceaux égaux...'
      },
      {
        'img': ImageString.food3,
        'timing': '1 h 50 min',
        'time': 'midi',
        'foodName': 'Placali sauce gombo',
        'level': 'Difficultés: Moyen',
        'description':
            'Placez les morceaux de gombos dans un mixeur et réduisez-les en petits'
      },
    ];
    return Container(
      margin: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      child: Column(children: [
        Container(
          height: 46,
          width: size.width * 0.9,
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(width: 1.2, color: PrimaryColor.primary400)),
          child: Row(
            children: [
              Image.asset(ImageString.search),
              SizedBox(
                width: size.width * 0.02,
              ),
              SizedBox(
                width: size.width * 0.77,
                child: TextFormField(
                  cursorColor: PrimaryColor.primary600,
                  controller: controller,
                  style: TextStyle(
                    fontFamily: "Poppins",
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    border: InputBorder.none,
                    fillColor: Colors.transparent,
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD5C2B9),
                        fontSize: 16,
                        fontFamily: 'Gilroy'),
                    hintText: "Rechercher un plat",
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "2 élements trouvés",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                fontFamily: 'GilroySemi'),
          ),
        ),
        SizedBox(
          height: size.height * 0.78,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: menus.map((menu) {
              return Container(
                width: 338,
                height: 142,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                    border:
                        Border.all(width: 1.2, color: PrimaryColor.primary200),
                    borderRadius: BorderRadius.circular(15),
                    color: PrimaryColor.primary100),
                child: Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: AssetImage(menu['img']),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              menu['foodName'],
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: PrimaryColor.primary900,
                                  fontSize: 18,
                                  fontFamily: 'GilroySemi'),
                            ),
                            SizedBox(
                              width: size.width * 0.5,
                              child: Text(
                                menu['description'],
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    fontFamily: 'GilroyRegular'),
                              ),
                            ),
                            SizedBox(
                              child: Row(children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.timer,
                                        color: PrimaryColor.primary500,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        menu['timing'],
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
                                      vertical: 5, horizontal: 8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.wb_sunny_rounded,
                                        color: PrimaryColor.primary500,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        menu['time'],
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
              );
            }).toList(),
          ),
        )
      ]),
    );
  }
}
