// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';

class LestoTextField extends StatelessWidget {
  const LestoTextField({
    Key? key,
    this.controller,
    required this.hintValue,
    this.validate,
    this.typeInput,
    required this.label,
    this.fontSize,
    this.borderColor,
  }) : super(key: key);

  final TextEditingController? controller;
  final String hintValue;
  final String? Function(String?)? validate;
  final TextInputType? typeInput;
  final String label;
  final double? fontSize;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
                width: 1.5, color: borderColor ?? PrimaryColor.primary200),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 7),
          child: TextFormField(
            controller: controller,
            validator: validate,
            keyboardType: typeInput,
            style: TextStyle(
              fontFamily: "Poppins",
            ),
            decoration: InputDecoration(
              filled: true,
              border: InputBorder.none,
              fillColor: Colors.transparent,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 13),
              hintStyle: TextStyle(
                  color: NeutralColor.neutral500,
                  fontSize: 17.0,
                  fontFamily: "Gilroy"),
              hintText: hintValue,
            ),
          ),
        ),
      ],
    );
  }
}
