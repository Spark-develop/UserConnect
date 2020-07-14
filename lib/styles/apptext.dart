import 'package:flutter/material.dart';
import 'package:finalLetsConnect/styles/appColors.dart';

TextStyle mainTitle = new TextStyle(
    fontFamily: "Open Sans",
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: lightWhite,
    letterSpacing: -1.0,
    wordSpacing: 3.0);

TextStyle cardTitleService = new TextStyle(
    fontFamily: "Open Sans",
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: serviceColor,
    letterSpacing: -1.0,
    wordSpacing: 3.0);

TextStyle bodyHeadline1 = new TextStyle(
    fontFamily: "Open Sans",
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: lightWhite,
    letterSpacing: -1.0,
    wordSpacing: 3.0);

TextStyle cardTitleAccesories = new TextStyle(
    fontFamily: "Open Sans",
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: accesoriesColor,
    letterSpacing: -1.0,
    wordSpacing: 3.0);

TextStyle subTitle = new TextStyle(
    fontFamily: "Avenir",
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: lightGray);

TextStyle userIntroName = new TextStyle(
    fontFamily: "Open Sans",
    fontSize: 26,
    fontWeight: FontWeight.w300,
    color: lightWhite);

TextStyle userIntroDes = new TextStyle(
    fontFamily: "Open Sans",
    fontSize: 14,
    fontWeight: FontWeight.w100,
    color: lightWhite);

TextStyle homePageTime = new TextStyle(
    fontFamily: "Open Sans",
    fontSize: 10,
    fontWeight: FontWeight.w900,
    color: lightWhite);

TextStyle darkFont = new TextStyle(
    fontFamily: "Open Sans",
    fontSize: 15,
    fontWeight: FontWeight.w900,
    color: lightGray);

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
