import 'package:flutter/material.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';

class LinkButton extends StatelessWidget {
  const LinkButton({
    super.key,
    required this.title,
    required this.press,
    required this.width,
    required this.height,
  });
  final String title;
  final VoidCallback press;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          fixedSize: Size(width, height),
        ),
        onPressed: press,
        child: Text(title,
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: PrimaryColor.primary500)));
  }
}
