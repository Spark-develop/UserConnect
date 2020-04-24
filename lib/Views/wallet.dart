import 'package:finalLetsConnect/authentication/test.dart';
import 'package:flutter/material.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Center(child: Column(
        children: <Widget>[
          Text(UserDetail.tokenz),
          Text(UserDetail.address),
        ],
      ),)
    );
  }
}