import 'package:finalLetsConnect/authentication/Phone_auth.dart';
import 'package:finalLetsConnect/authentication/login2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:finalLetsConnect/styles/appColors.dart';
import 'package:finalLetsConnect/styles/apptext.dart';

import 'formPage.dart';

class Service extends StatefulWidget {
  @override
  _ServicePage createState() => _ServicePage();
}

class _ServicePage extends State<Service> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightWhite,
        elevation: 0,
        leading: MyButton(context),
      ),
      body: Container(
        color: lightWhite,
        // padding: EdgeInsets.only(left:30,right: 30),
        child: GridView.count(
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            padding: EdgeInsets.only(bottom: 20, right: 20, left: 20),
            children: <Widget>[
              card(context, 1),
              card(context, 2),
              card(context, 3),
              card(context, 4),
              card(context, 5),
              card(context, 6),
            ]),
      ),
    );
  }
}

Widget MyButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.pop(context);
    },
    child: CircleAvatar(
      child: Icon(
        Icons.arrow_back_ios,
        color: lightblue,
      ),
      backgroundColor: Colors.transparent,
    ),
  );
}

Widget card(
  BuildContext context,
  int tab,
) {
  Color _bgcolor = Colors.white;
  String _imageIcon = "";
  String _tabName = "";
  if (tab == 1) {
    _imageIcon = 'images/PC.png';
    _tabName = "DeskTop";
    _bgcolor = tabColor1;
  }
  if (tab == 2) {
    _imageIcon = 'images/laptop.png';
    _tabName = "Laptop";
    _bgcolor = tabColor2;
  }
  if (tab == 3) {
    _imageIcon = 'images/router.png';
    _tabName = "Routers";
    _bgcolor = tabColor3;
  }
  if (tab == 4) {
    _imageIcon = 'images/cctv.png';
    _tabName = "CCTV";
    _bgcolor = tabColor4;
  }
  if (tab == 5) {
    _imageIcon = 'images/bio.png';
    _tabName = "Biomatrix";
    _bgcolor = tabColor5;
  }
  if (tab == 6) {
    _imageIcon = 'images/tablets.png';
    _tabName = "Tablets";
    _bgcolor = tabColor6;
  }

  if (tab % 2 == 0) {
    return InkResponse(
      enableFeedback: true,
      onTap: () {
        print(tab);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormPage(),
            ));
      },
      child: Container(
          //  color: _bgcolor,
          margin: EdgeInsets.all(10),
          // padding: EdgeInsets.all(20),
          decoration: new BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 10.0, offset: Offset(0, 0))
            ],
            borderRadius: BorderRadius.all(Radius.circular(25)),
            color: _bgcolor,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: Image.asset(
                      _imageIcon,
                      fit: BoxFit.fill,
                      alignment: Alignment.topCenter,
                    ),
                    height: MediaQuery.of(context).size.height / 8,
                    width: MediaQuery.of(context).size.width / 5),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    _tabName,
                    style: darkFont,
                  ),
                )
              ])),
    );
  } else {
    return InkResponse(
      enableFeedback: true,
      onTap: () {
        if (FirebaseAuth.instance.currentUser() == null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Phone_auth()));
        } else {
          print(tab);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormPage(),
              ));
        }
      },
      child: Container(
          margin: EdgeInsets.all(10),
          // padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height / 8,
          decoration: new BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 10.0, offset: Offset(0, 0))
            ],
            borderRadius: BorderRadius.all(Radius.circular(25)),
            color: _bgcolor,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: Image.asset(
                      _imageIcon,
                      fit: BoxFit.fill,
                      alignment: Alignment.topCenter,
                    ),
                    height: MediaQuery.of(context).size.height / 8,
                    width: MediaQuery.of(context).size.width / 5),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    _tabName,
                    style: darkFont,
                  ),
                )
              ])),
    );
  }
}