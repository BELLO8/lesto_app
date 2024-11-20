import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lesto/app/data/constants/Colors/color_neutral.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    super.key,
    required this.size,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final Size size;
  final String label;
  final String icon;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: size.width * 0.24,
        height: size.height * 0.05,
        margin: EdgeInsets.symmetric(horizontal: 2),
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1.5, color: NeutralColor.neutral300),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: PrimaryColor.primary700,
            ),
            SizedBox(
              width: size.width * 0.01,
            ),
            Text(
              label,
              style: TextStyle(
                  fontFamily: 'GilroyMedium',
                  color: Colors.black,
                  fontSize: 14,
                  decoration: TextDecoration.none),
            ),
          ],
        ),
      ),
    );
  }
}
