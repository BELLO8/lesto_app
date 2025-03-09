// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
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
        child: SizedBox(
          width: 230,
          child: TextFormField(
            controller: controller,
            validator: validate,
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
      ),
    );
  }
}
