// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lesto/app/data/constants/Colors/color_primary.dart';
import 'package:lesto/app/data/constants/Image/image_constant.dart';

class HomeSilverBar extends StatelessWidget {
  const HomeSilverBar({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SliverAppBar(
      expandedHeight: size.height * 0.27,
      floating: false,
      toolbarHeight: 68,
      automaticallyImplyLeading: false,
      pinned: true,
      shadowColor: Color.fromRGBO(169, 169, 150, 0.13),
      backgroundColor: PrimaryColor.primary600,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: PrimaryColor.primary600,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
      flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        double height = constraints.biggest.height - 100;

        return FlexibleSpaceBar(
          centerTitle: true,
          background: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImageString.food3), fit: BoxFit.cover)),
          ),
          titlePadding: EdgeInsets.zero,
          title: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: 1.0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: height > 0 ? 10 : 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[],
                      )),
                  if (height - 60 > 0)
                    SizedBox(
                      height: height - 207 > 0 ? height - 207 : 0,
                    ),
                  if (height > 20)
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      width: size.width,
                      height: size.height / 12,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Container(
                              width: size.width,
                              height: 72,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  end: Alignment.topCenter,
                                  begin: Alignment.bottomCenter,
                                  colors: [
                                    Colors.white,
                                    const Color.fromARGB(194, 255, 255, 255),
                                    Color.fromARGB(255, 255, 255, 255)
                                        .withOpacity(0.0)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ]),
          ),
        );
      }),
    );
  }
}
