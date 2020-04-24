import 'package:finalLetsConnect/styles/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [lightblue, darkblue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Center(
          child: SpinKitFadingCube(
        color: Colors.orangeAccent,
        size: 50.0,
      )),
    );
  }
}
