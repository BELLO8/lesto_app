// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintValue,
    this.validate,
    this.typeInput,
    required this.label,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintValue;
  final String? Function(String?)? validate;
  final TextInputType? typeInput;
  final String label;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * 0.03),
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontFamily: "GilroyMedium",
              ),
            )),
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1.5, color: PrimaryColor.primary900),
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
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 13),
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
