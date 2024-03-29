// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void showAlert(BuildContext context, Widget widget, double width, double height,
    bool barrierDismissible) {
  showDialog(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (context) {
      return Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          width: width,
          height: height,
          padding: EdgeInsets.symmetric(vertical: 16),
          child: widget,
        ),
      );
    },
  );
}
