import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    required this.press,
    required this.color,
    required this.width,
    required this.height,
    required this.styleText,
  });
  final String title;
  final VoidCallback press;
  final Color color;
  final double width;
  final double height;
  final TextStyle styleText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: color),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            fixedSize: Size(width, height),
          ),
          onPressed: press,
          child: Text(title, style: styleText)),
    );
  }
}
