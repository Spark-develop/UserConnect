import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalLetsConnect/Views/formPage.dart';
import 'package:finalLetsConnect/authentication/Phone_auth.dart';
import 'package:finalLetsConnect/styles/appColors.dart';
import 'package:finalLetsConnect/styles/apptext.dart';
import 'package:finalLetsConnect/styles/network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDesktopPage extends StatefulWidget {
  @override
  _MyDesktopPageState createState() => _MyDesktopPageState();
}

class _MyDesktopPageState extends State<MyDesktopPage> {
  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser() == null
        ? Phone_auth()
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: lightblue,
              title: Text(
                'Desktop',
                style: mainTitle,
              ),
              elevation: 0,
              leading: MyButton(context),
            ),
            backgroundColor: lightWhite,
            body: Container(
              child: callListView(context),
            ),
          );
  }

  Widget MyButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: CircleAvatar(
        child: Icon(
          Icons.arrow_back_ios,
          color: lightWhite,
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  onListTapped(BuildContext context, int index, subject, icons, cost) {
    Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (BuildContext context) => FormPage(
            subject: subject,
            initial: icons,
            itemCost: cost,
          ),
        ));
  }

  Widget callListView(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("desktop").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Text('Loading');
        final int messageCount = snapshot.data.documents.length;
        print(messageCount);
        return Column(
          children: [
            Flexible(
              child: ListView.builder(
                  itemCount: messageCount,
                  itemBuilder: (_, int index) {
                    final DocumentSnapshot document =
                        snapshot.data.documents[index];
                    final dynamic subject = document['subject'];
                    final dynamic cost = document['cost'];
                    final int discount = document['discount'];
                    final dynamic icons = document['icon'];
                    return GestureDetector(
                      onTap: () {
                        onListTapped(context, index, subject, icons, cost);
                      },
                      child: Card(
                        child: ListTile(
                          leading: Container(
                            width: 80,
                            child: PNetworkImage(icons),
                          ),
                          contentPadding:
                              EdgeInsets.only(top: 20, bottom: 20, left: 10),
                          dense: true,
                          title: Text(
                            subject,
                            style: TextStyle(
                                fontFamily: "Avenir",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: darkGray,
                                letterSpacing: -1.0,
                                wordSpacing: 3.0),
                          ),
                          subtitle: discount != 0
                              ? Text(
                                  "$discount%",
                                  style: TextStyle(
                                      fontFamily: "Avenir",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: darkGray,
                                      letterSpacing: -1.0,
                                      wordSpacing: 3.0),
                                )
                              : null,
                          trailing: SizedBox(
                            width: 50,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        );
      },
    );
  }
}
