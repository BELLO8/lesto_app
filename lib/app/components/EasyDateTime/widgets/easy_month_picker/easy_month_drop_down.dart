// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../../data/constants/Colors/color_primary.dart';
import '../../models/easy_month.dart';
import '../../utils/utils.dart';

/// A widget that displays a drop-down list of months.
class EasyMonthDropDown extends StatelessWidget {
  const EasyMonthDropDown({
    super.key,
    this.value,
    this.onMonthChange,
    required this.locale,
    this.style,
  });

  /// The currently selected month.
  final EasyMonth? value;

  /// A callback function that is called when the selected month changes.
  final void Function(EasyMonth? month)? onMonthChange;

  /// A `String` that represents the locale code to use for formatting the month names in the drop-down list.
  final String locale;

  /// The text style applied to the month string.
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        height: 80,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 16),
          scrollDirection: Axis.horizontal,
          children:
              EasyDateUtils.getYearMonths(DateTime.now(), locale).map((month) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: value!.name == month.name
                      ? PrimaryColor.primary600
                      : PrimaryColor.primary100),
              child: InkWell(
                radius: 10,
                onTap: () {
                  onMonthChange!.call(month);
                },
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(month.name,
                        style: TextStyle(
                            fontFamily: 'GilroyMedium',
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: value!.name == month.name
                                ? Color(0xFFFFFFFF)
                                : PrimaryColor.primary600))),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
