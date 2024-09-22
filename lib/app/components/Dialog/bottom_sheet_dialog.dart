// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void bottomSheetDialog(
    BuildContext ctx, Widget child, double height, Function() action) {
  Size size = MediaQuery.of(ctx).size;
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: ctx,
      isScrollControlled: true,
      builder: (ctx) => Padding(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: height,
                    decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    alignment: Alignment.center,
                    child: child,
                  ),
                ],
              ),
            ),
          )).whenComplete(action);
}
