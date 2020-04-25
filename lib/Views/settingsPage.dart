import 'dart:io';
import 'package:finalLetsConnect/authentication/test.dart';
import 'package:finalLetsConnect/authentication/users.dart';
import 'package:finalLetsConnect/styles/appColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static File _image;
  String textEdit;

  StorageTaskSnapshot taskSnapshot;
  final databaseReference = Firestore.instance;
  final List<Map> setList = [
    {
      "Logo": Icons.mail,
      "type": UserDetail.email == null ? "Email" : UserDetail.email,
      "text_type": TextInputType.emailAddress,
      "Form": GlobalKey<FormState>(),
      "boolText": false,
    },
    {
      "Logo": Icons.person_outline,
      "type": "User Name",
      "text_type": TextInputType.text,
      "Form": GlobalKey<FormState>(),
      "boolText": false
    },
    {
      "Logo": Icons.phone,
      "type": UserDetail.mob == null ? "Number" : UserDetail.mob,
      "text_type": TextInputType.phone,
      "Form": GlobalKey<FormState>(),
      "boolText": false
    },
    {
      "Logo": Icons.my_location,
      "type": UserDetail.address ==null? "Address" :UserDetail.address,
      "text_type": TextInputType.text,
      "Form": GlobalKey<FormState>(),
      "boolText": false
    },
  ];

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future uploadPic(BuildContext context, String userOne) async {
    String fileName = basename(_image.path);
    StorageReference firebaseStorage =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadtask = firebaseStorage.putFile(_image);
    taskSnapshot = await uploadtask.onComplete;
    final imageUrl = await firebaseStorage.getDownloadURL();
    await databaseReference.collection("users").document(userOne).setData({
      'ProfilePic': imageUrl,
    });
    setState(() {
      Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.greenAccent,
        content: Text("Profile changed succesfully"),
      ));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Expanded(
                  child: ListView(
            children: <Widget>[
              setPage(context)
            ],
          ),
        ),
        padding: EdgeInsets.only(bottom: 0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [lightblue, darkblue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
      ),
    );
  }

  Widget setPage(BuildContext context) {
    final user = Provider.of<User>(context);
    final String usr = user.uid.toString();
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      right: 10.0, left: 10, bottom: 10, top: 20),
                  child: GestureDetector(
                    onTap: () {
                      return getImage();
                    },
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Color(0xfff0f0f0),
                      child: Stack(children: <Widget>[
                        ClipOval(
                          child: Container(
                            width: 400,
                            height: 400,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff7c94b6),
                                image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.white.withOpacity(0.4),
                                      BlendMode.dstATop),
                                  image: _image == null
                                      ? NetworkImage(
                                          'https://firebasestorage.googleapis.com/v0/b/otpauth-1-d.appspot.com/o/boss.png?alt=media&token=3e580742-325a-4cd3-9c1a-4a971191a4fa')
                                      : FileImage(_image),
                                ),
                              ),
                              // child: Image.network(
                              //     "'https://firebasestorage.googleapis.com/v0/b/otpauth-1-d.appspot.com/o/imgmy1.jpg?alt=media&token=569c3a97-a62c-4396-9c02-c68b40be9ca5'",fit: BoxFit.fill,),
                            ),
                          ),
                        ),
                        Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Upload a Image",
                                style: TextStyle(
                                    color: Colors.white60,
                                    backgroundColor: Colors.transparent)),
                            Icon(
                              Icons.camera,
                              color: Colors.white60,
                            )
                          ],
                        )),
                      ]),
                    ),
                  ),
                  // child: _image == null
                  //     ? Text('No image selected.')
                  //     : Image.file(_image),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      saveButton(context, usr),
                      cancelButton(context)
                    ]),
              ]),
          Padding(
            padding: const EdgeInsets.only(right: 25.0, left: 25.0, top: 40),
            child: buildList(context, user),
          ),
        ],
      ),
    );
  }

  Widget saveButton(BuildContext context, String userer) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton.extended(
        onPressed: () async {
          return _image == null
              ? Scaffold.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.redAccent,
                  content: Text("No Profile Picture was set!")))
              : uploadPic(context, userer);
        },
        backgroundColor: Color(0xfff0f0f0),
        label: Text(
          "SAVE",
          style: TextStyle(color: lightblue),
        ),
      ),
    );
  }

  Widget cancelButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton.extended(
        backgroundColor: Color(0xfff0f0f0),
        label: Text(
          "CANCEL",
          style: TextStyle(color: lightblue),
        ),
        onPressed: () {
          setState(() {
            _image = null;
          });
        },
      ),
    );
  }

  Widget buildList(BuildContext context, User uuser) {
    return Container(
      height: 300,
      padding: EdgeInsets.only(top:20,left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Color(0xfff0f0f0),
      ),
      margin: EdgeInsets.only(bottom: 1),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: setList.length,
          itemBuilder: (BuildContext context, int index) {
            return buildCard(context, index, uuser);
          }),
    );
  }

  Widget buildCard(BuildContext context, int index, User uuser) {
    return Card(
      elevation: 0,
      color: Color(0xfff0f0f0),
      child: Form(
        key: setList[index]['Form'],
        child: ListTile(
          leading: Icon(setList[index]['Logo']),
          title: setList[index]['boolText'] == true
              ? TextFormField(
                  validator: (val) => val.isEmpty ? "input empty" : null,
                  onChanged: (val) =>
                      setState(() => setList[index]["type"] = val),
                  keyboardType: setList[index]['text_type'],
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Open Sans',
                  ),
                )
              : Text(
                  setList[index]['type'],
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Open Sans',
                  ),
                ),
          trailing: GestureDetector(
              onTap: () {
                setState(() {
                  setList[index]['Logo'] == Icons.my_location
                      ? UserDetail.address = setList[index]['type']
                      : null;
                  setList[index]['boolText'] = !setList[index]['boolText'];
                });
                var n = setList.length;

                for (int i = 0; i < n; i++) {
                  if (i != index) {
                    if (setList[i]['boolText'] == true) {
                      setList[i]['boolText'] = !setList[i]['boolText'];
                    }
                  }
                }
              },
              child: setList[index]['boolText'] == false
                  ? Icon(Icons.edit)
                  : Icon(Icons.save)),
        ),
      ),
    );
  }
}
