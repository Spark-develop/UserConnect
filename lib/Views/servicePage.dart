import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalLetsConnect/Views/mydesktopPage.dart';
import 'package:finalLetsConnect/authentication/Phone_auth.dart';
import 'package:finalLetsConnect/authentication/test.dart';
import 'package:finalLetsConnect/styles/network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:finalLetsConnect/styles/appColors.dart';
import 'package:finalLetsConnect/styles/apptext.dart';
import 'package:googleapis/firebasedynamiclinks/v1.dart';

import 'formPage.dart';

class Service extends StatefulWidget {
  @override
  _ServicePage createState() => _ServicePage();
}

class _ServicePage extends State<Service> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightWhite,
        appBar: AppBar(
          backgroundColor: lightblue,
          elevation: 0,
          leading: MyButton(context),
        ),
        body: card(context));
  }
}

Widget MyButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.pop(context);
    },
    child: CircleAvatar(
      child: Icon(Icons.arrow_back_ios, color: Colors.white),
      backgroundColor: Colors.transparent,
    ),
  );
}

Widget card(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection('ServicePage').snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData) return const Text('Loading');
      final int messageCount = snapshot.data.documents.length;
      return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: messageCount,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 0.75,
            crossAxisSpacing: 0,
            crossAxisCount: 2,
            childAspectRatio: 1,
          ),
          itemBuilder: (_, int index) {
            final DocumentSnapshot document = snapshot.data.documents[index];
            final dynamic subject = document['subject'];
            final dynamic icon = document['icon'];
            final int cost = document['cost'];
            final int discount = document['discount'];
            final dynamic promo = document['promo'];
            final String bgcolor = document['color'];
            Color convertToColor(String color, {String opacity = 'ff'}) {
              return Color(int.parse('$opacity$color', radix: 16));
            }

            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: GestureDetector(
                onTap: () {
                  if (subject == 'Desktop') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyDesktopPage()));
                  } else
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FormPage(
                                  itemCost: cost,
                                  initial: icon,
                                  subject: subject,
                                )));
                },
                child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: new BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10.0,
                            offset: Offset(0, 0))
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: convertToColor(bgcolor),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              child: PNetworkImage(
                                icon,
                              ),
                              height: MediaQuery.of(context).size.height / 8,
                              width: MediaQuery.of(context).size.width / 5),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Text(
                              subject,
                              style: darkFont,
                            ),
                          )
                        ])),
              ),
            );
          });
    },
  );
}
