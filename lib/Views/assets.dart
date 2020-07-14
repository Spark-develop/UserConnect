import 'package:flutter/material.dart';
import 'package:finalLetsConnect/authentication/authservices.dart';
import 'package:finalLetsConnect/styles/appColors.dart';
import 'package:finalLetsConnect/styles/apptext.dart';

Widget defaultAppBar(context) {
  return AppBar(
    centerTitle: true,
    automaticallyImplyLeading: false,
    title: Text(
      'LetsConnect',
      style: mainTitle,
    ),
    backgroundColor: lightblue,
    elevation: 0,
    // leading:,
    iconTheme: IconThemeData(color: lightWhite),
  );
}
