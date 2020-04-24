import 'package:finalLetsConnect/authentication/test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finalLetsConnect/authentication/users.dart';
import 'package:finalLetsConnect/styles/appColors.dart';
import 'package:provider/provider.dart';

class FormPage extends StatefulWidget {
  final String subject;
  const FormPage({Key key, this.subject}) : super(key: key);
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  // final CallDes cs ;
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightblue,
        elevation: 0,
        leading: MyButton(context),
      ),
      body: mainForm(context),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   child: Container(child: const Icon(Icons.add),width:200 ,),
      //   onPressed: () {},
      // ),
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

  Widget mainForm(BuildContext context) {
    final user = Provider.of<User>(context);
    final String usr = user.uid.toString();
    // final String usr = "SDFSDDSRFGDRERT";
    final _model = TextEditingController();
    final _issue = TextEditingController();
    final _subject = TextEditingController();
    final String sub="";
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget.subject != null
              ? TextFormField(
                  initialValue: widget.subject,
                  onChanged: (val) =>
                      setState(() => sub == val),
                  decoration: new InputDecoration(
                    labelText: "Subject",
                    hintText: widget.subject,
                    fillColor: lightWhite,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: lightblue, width: 2.0),
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "Subject can't be Empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                )
              : TextFormField(
                  controller: _subject,
                  decoration: new InputDecoration(
                    labelText: "Subject",
                    fillColor: lightWhite,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: lightblue, width: 2.0),
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "Subject can't be Empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new TextFormField(
            controller: _model,
            decoration: new InputDecoration(
              labelText: "Model No.",
              fillColor: lightWhite,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: lightblue, width: 2.0),
                borderRadius: new BorderRadius.circular(25.0),
              ),
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(),
              ),
              //fillColor: Colors.green
            ),
            validator: (val) {
              if (val.length == 0) {
                return "Model can't be Empty";
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.emailAddress,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new TextFormField(
            controller: _issue,
            decoration: new InputDecoration(
              labelText: "Issues",
              fillColor: lightWhite,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: lightblue, width: 2.0),
                borderRadius: new BorderRadius.circular(25.0),
              ),
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(),
              ),
              //fillColor: Colors.green
            ),
            validator: (val) {
              if (val.length == 0) {
                return "Describe Issue..";
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.emailAddress,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
        ),
        ButtonBar(
          mainAxisSize: MainAxisSize.max,
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Icon(Icons.add),
              onPressed: () {
                if (_issue.text.isNotEmpty && _model.text.isNotEmpty) {
                  if (widget.subject.isNotEmpty) {
                    addcall(widget.subject, _model.text, _issue.text, usr);
                  } else if (_subject.text.isNotEmpty) {
                    addcall(_subject.text, _model.text, _issue.text, usr);
                  } else {
                    Scaffold.of(context).showBottomSheet(
                        (context) => Text("Subject Not defined!"));
                  }
                }
              },
            )
          ],
        )
      ],
    );
  }

  final databaseReference = Firestore.instance;
  final FirebaseAuth _firebase = FirebaseAuth.instance;
  void addcall(String sub, String modelNo, String issues, String usrer) async {
    await databaseReference
        .collection("users")
        .document(usrer)
        .collection('calls')
        .document()
        .setData({
      'model': modelNo,
      'issue': issues,
      'subject': sub,
      'isAssigned': false,
      'isComplete': false
    });
    Navigator.pushNamed(context, '/callHistory');
  }
}
//https://github.com/Spark-develop/Systech.git