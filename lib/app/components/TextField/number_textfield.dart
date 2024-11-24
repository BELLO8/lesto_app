// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';

class NumberTextField extends StatelessWidget {
  const NumberTextField({
    Key? key,
    this.controller,
    required this.hintValue,
    this.validate,
    this.typeInput,
    this.fontSize,
    this.borderColor,
  }) : super(key: key);

  final TextEditingController? controller;
  final String hintValue;
  final String? Function(String?)? validate;
  final TextInputType? typeInput;
  final double? fontSize;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              width: 1.5, color: borderColor ?? PrimaryColor.primary200),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(vertical: 7),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                child: Row(
                  children: [
                    SvgPicture.network(
                      height: 15,
                      width: 15,
                      "https://flagcdn.com/ci.svg",
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "225",
                      style: TextStyle(
                          fontFamily: 'GilroySemi',
                          fontSize: 14,
                          decoration: TextDecoration.none),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Icon(Icons.keyboard_arrow_down)
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 230,
              child: TextFormField(
                controller: controller,
                validator: validate,
                keyboardType: TextInputType.phone,
                style: TextStyle(
                  fontFamily: "Poppins",
                ),
                decoration: InputDecoration(
                  filled: true,
                  border: InputBorder.none,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 14.0, horizontal: 13),
                  hintStyle: TextStyle(
                      color: NeutralColor.neutral500,
                      fontSize: 17.0,
                      fontFamily: "Gilroy"),
                  hintText: hintValue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
