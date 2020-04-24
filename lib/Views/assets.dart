import 'package:flutter/material.dart';
import 'package:finalLetsConnect/authentication/authservices.dart';
import 'package:finalLetsConnect/styles/appColors.dart';
import 'package:finalLetsConnect/styles/apptext.dart';

Widget defaultAppBar(context) {
  final AuthService _authService = AuthService();
  return AppBar(
    centerTitle: true,
    title: Text(
      'LetsConnect',
      style: mainTitle,
    ),
    backgroundColor: lightblue,
    elevation: 0,
    // leading:,
    actions: <Widget>[
      GestureDetector(
        onTap: () async {
          _authService.signOut();
        },
        child: Padding(
          padding:EdgeInsets.all(10),
          child: Icon(
            Icons.power_settings_new,
          ),
        ),
      ),
    ],
    iconTheme: IconThemeData(color: lightWhite),
  );
}
