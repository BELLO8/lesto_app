// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/constants/Colors/color_neutral.dart';

class UserProfilMenu extends StatelessWidget {
  const UserProfilMenu({
    super.key,
    this.onPressed,
    required this.icon,
    required this.title,
  });
  final void Function()? onPressed;
  final String icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        margin: EdgeInsets.only(bottom: 13),
        height: 48,
        width: 285,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: NeutralColor.neutral200, width: 0.8),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              width: 24,
              height: 24,
              icon,
            ),
            Spacer(),
            Text(
              title,
              style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
            ),
            Spacer(),
            Icon(Icons.keyboard_arrow_right_sharp),
          ],
        ),
      ),
    );
  }
}
