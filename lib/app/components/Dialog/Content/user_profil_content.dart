// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/constants/Colors/color_neutral.dart';
import '../../../data/constants/Colors/color_primary.dart';
import '../../../data/constants/Image/image_constant.dart';
import '../../../routes/app_pages.dart';
import '../user_menu.dart';

class UserProfileContent extends StatelessWidget {
  const UserProfileContent({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {},
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: NeutralColor.neutral300, width: 1.5),
                ),
                child: Icon(Icons.edit_outlined),
              ),
            ),
          ),
          Row(children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image:
                      DecorationImage(image: AssetImage(ImageString.avatar))),
              height: size.height * 0.1,
              width: size.height * 0.1,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bello Kader",
                      style: TextStyle(
                          fontFamily: 'GilroyBold',
                          fontSize: 20,
                          letterSpacing: -1),
                    ),
                    Text(
                      "bellokader8@gmail.com ",
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
                    )
                  ]),
            )
          ]),
          SizedBox(
            height: 38,
          ),
          Column(
            children: [
              UserProfilMenu(
                  title: "A propos de l’application",
                  icon: Icon(Icons.info_rounded),
                  onPressed: () {}),
              UserProfilMenu(
                  title: "Partager l’application",
                  icon: Icon(Icons.share_outlined),
                  onPressed: () {}),
              UserProfilMenu(
                title: "Souscription à Lesto ",
                icon: Icon(Icons.money),
                onPressed: () {},
              ),
              UserProfilMenu(
                title: "Supprimer mon compte",
                icon: Icon(Icons.abc),
              ),
            ],
          ),
          Spacer(),
          InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () {
              Get.offNamed(Routes.AUTH_LOGIN);
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 12),
              margin: EdgeInsets.only(bottom: 13),
              height: 48,
              width: 285,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: PrimaryColor.primary600, width: 1.5),
              ),
              child: Text(
                "Déconnexion",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: PrimaryColor.primary600),
              ),
            ),
          )
        ],
      ),
    );
  }
}
