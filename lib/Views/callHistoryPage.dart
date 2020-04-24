import 'package:finalLetsConnect/authentication/Phone_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finalLetsConnect/authentication/users.dart';
import 'package:finalLetsConnect/styles/appColors.dart';
import 'package:provider/provider.dart';

class CallHistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CallHistory();
  }
}

class _CallHistory extends State<CallHistoryPage> {
  User us;
  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser()==null?Phone_auth():Scaffold(
      backgroundColor: lightWhite,
      body: Container(
        color: lightWhite,
        // padding: EdgeInsets.only(left:30,right: 30),
        child: GridView.count(crossAxisCount: 1,
            // padding: EdgeInsets.all(20),
            children: <Widget>[
              callListView(context),
            ]),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;



  Widget callListView(BuildContext context) {
        final user = Provider.of<User>(context);
    final String usr = user.uid.toString();

    return StreamBuilder<QuerySnapshot>(
      // stream: Firestore.instance.collection('users').snapshots(),
      stream: Firestore.instance
          .collection('users')
          .document(usr)
          .collection('calls')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Text('Loading');

        final int messageCount = snapshot.data.documents.length;
        return ListView.builder(
            itemCount: messageCount,
            itemBuilder: (_, int index) {
              final DocumentSnapshot document = snapshot.data.documents[index];
              final dynamic model = document['model'];
              final dynamic issue = document['issue'];
              final dynamic iscomplete = document['isComplete'];
              // var a = Firestore.instance.collection('users').document(document.documentID).collection('complaints').snapshots();

              return ListTile(
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    //document.reference.updateData({'model':'safed condom'});
                     document.reference.delete();
                  },
                ),
                title: Text(model != null
                    ? model.toString() + "  " + issue.toString()
                    : 'No Message'),

                // subtitle: Text('Message ${index + 1} of $messageCount'),
              );
            });
      },
    );
  }
}
