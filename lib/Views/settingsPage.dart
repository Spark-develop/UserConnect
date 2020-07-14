import 'dart:io';
import 'package:finalLetsConnect/authentication/authservices.dart';
import 'package:finalLetsConnect/authentication/test.dart';
import 'package:finalLetsConnect/authentication/users.dart';
import 'package:finalLetsConnect/styles/appColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalLetsConnect/styles/apptext.dart';
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
  final _email1 = TextEditingController();
  final _username1 = TextEditingController();
  final _address1 = TextEditingController();
  final _mobile1 = TextEditingController();
  final _formEmailKey = GlobalKey<FormState>();
  static String email, mobile, username, address;
  bool _emailSet = false,
      _mobileSet = false,
      _usernameSet = false,
      _addressSet = false;
  static File _image;
  StorageTaskSnapshot taskSnapshot;
  final databaseReference = Firestore.instance;

  @override
  void initState() {
    super.initState();
    Firestore.instance
        .collection("users")
        .document(UserDetail.uid)
        .get()
        .then((value) {
      setState(() {
        email = value.data['Email'].toString();
        username = value.data['Username'].toString();
        mobile = value.data['Mobile'].toString();
        address = value.data['Address'].toString();
      });
    });
  }

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
    await databaseReference.collection("users").document(userOne).updateData({
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
    final AuthService _authService = AuthService();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Settings',
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
              padding: EdgeInsets.only(top: 10, bottom: 10, right: 15),
              child: Icon(
                Icons.power_settings_new,
              ),
            ),
          ),
        ],
        iconTheme: IconThemeData(color: lightWhite),
      ),
      body: Container(
        child: SafeArea(
          child: ListView(
            children: <Widget>[setPage(context)],
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
        label: Text("SAVE PROFILE PIC",
            style: TextStyle(
                fontFamily: "Open Sans",
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: lightblue,
                letterSpacing: -1.5,
                wordSpacing: 2.0)),
      ),
    );
  }

  Widget cancelButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton.extended(
        backgroundColor: Color(0xfff0f0f0),
        label: Text(
          "REMOVE",
          style: TextStyle(
              fontFamily: "Open Sans",
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: lightblue,
              letterSpacing: -1.5,
              wordSpacing: 2.0),
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
      height: MediaQuery.of(context).size.height / 2.1,
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Color(0xfff0f0f0),
      ),
      child: buildCard(context),
    );
  }

  Widget buildCard(BuildContext context) {
    return Form(
      key: _formEmailKey,
      child: Column(
        children: [
          //_emailSet
          Card(
            elevation: 0,
            color: Color(0xfff0f0f0),
            child: ListTile(
              leading: Icon(Icons.email),
              title: _emailSet == true
                  ? UserDetail.email != null
                      ? TextFormField(
                          controller: _email1,
                          autofocus: false,
                          validator: (_email1) {
                            if (_email1.length == 0) {
                              return "Model can't be Empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "Open Sans",
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              letterSpacing: -1.5,
                              wordSpacing: 2.0))
                      : Text(UserDetail.email,
                          style: TextStyle(
                              fontFamily: "Open Sans",
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              letterSpacing: -1.5,
                              wordSpacing: 2.0))
                  : Text(
                      UserDetail.email == "null" ||
                              UserDetail.email == null ||
                              UserDetail.email == ""
                          ? email == "" || email == "null" || email == null
                              ? "Email"
                              : email
                          : UserDetail.email,
                      style: TextStyle(
                          fontFamily: "Open Sans",
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          letterSpacing: -1.5,
                          wordSpacing: 2.0)),
              trailing: UserDetail.email == "" || UserDetail.email == null
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _emailSet = true;
                        });
                      },
                      child: _emailSet == false
                          ? Icon(Icons.edit, size: 28)
                          : Icon(Icons.save, size: 28),
                    )
                  : Container(
                      width: 10,
                    ),
            ),
          ),
          Card(
            elevation: 0,
            color: Color(0xfff0f0f0),
            child: ListTile(
              leading: Icon(Icons.person),
              title: _usernameSet == true
                  ? TextFormField(
                      controller: _username1,
                      autofocus: false,
                      validator: (_username1) {
                        if (_username1.length == 0) {
                          return "Model can't be Empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          fontFamily: "Open Sans",
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          letterSpacing: -1.5,
                          wordSpacing: 2.0))
                  : Text(
                      username == "" || username == "null" || username == null
                          ? "Username"
                          : username,
                      style: TextStyle(
                          fontFamily: "Open Sans",
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          letterSpacing: -1.5,
                          wordSpacing: 2.0)),
              trailing: GestureDetector(
                onTap: () {
                  setState(() {
                    _usernameSet = true;
                  });
                },
                child: _usernameSet == false
                    ? Icon(Icons.edit, size: 28)
                    : Icon(Icons.save, size: 28),
              ),
            ),
          ),
          Card(
            elevation: 0,
            color: Color(0xfff0f0f0),
            child: ListTile(
              leading: Icon(Icons.phone),
              title: _mobileSet == true
                  ? UserDetail.mob != null
                      ? Text(UserDetail.mob,
                          style: TextStyle(
                              fontFamily: "Open Sans",
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              letterSpacing: -1.5,
                              wordSpacing: 2.0))
                      : TextFormField(
                          controller: _mobile1,
                          autofocus: false,
                          validator: (_mobile1) {
                            if (_mobile1.length == 0) {
                              return "Model can't be Empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontFamily: "Open Sans",
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              letterSpacing: -1.5,
                              wordSpacing: 2.0))
                  : Text(
                      UserDetail.mob == null ||
                              UserDetail.mob == "null" ||
                              UserDetail.mob == ""
                          ? mobile == "" || mobile == "null" || mobile == null
                              ? "Mobile"
                              : mobile
                          : UserDetail.mob,
                      style: TextStyle(
                          fontFamily: "Open Sans",
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          letterSpacing: -1.5,
                          wordSpacing: 2.0)),
              trailing: UserDetail.mob != null
                  ? Container(
                      width: 10,
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          _mobileSet = true;
                        });
                      },
                      child: _mobileSet == false
                          ? Icon(Icons.edit, size: 28)
                          : Icon(Icons.save, size: 28),
                    ),
            ),
          ),
          Card(
            elevation: 0,
            color: Color(0xfff0f0f0),
            child: ListTile(
              leading: Icon(Icons.my_location),
              title: _addressSet == true
                  ? TextFormField(
                      controller: _address1,
                      autofocus: false,
                      validator: (_address1) {
                        if (_address1.length == 0) {
                          return "Model can't be Empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                          fontFamily: "Open Sans",
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          letterSpacing: -1.5,
                          wordSpacing: 2.0))
                  : Text(
                      address == "" || address == "null" || address == null
                          ? "Address"
                          : address,
                      style: TextStyle(
                          fontFamily: "Open Sans",
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          letterSpacing: -1.5,
                          wordSpacing: 2.0)),
              trailing: GestureDetector(
                onTap: () {
                  setState(() {
                    _addressSet = true;
                  });
                },
                child: _addressSet == false
                    ? Icon(
                        Icons.edit,
                        size: 28,
                      )
                    : Icon(Icons.save, size: 28),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 30,
          ),
          FloatingActionButton.extended(
            onPressed: () {
              if (_formEmailKey.currentState.validate()) {
                if (_email1.text != null ||
                    _username1.text != null ||
                    _mobile1.text != null ||
                    _address1.text != null) {
                  addcall(
                    _email1.text,
                    _username1.text,
                    _mobile1.text,
                    _address1.text,
                    // smsCodeDialog(context);
                  );
                  setState(() {
                    Firestore.instance
                        .collection("users")
                        .document(UserDetail.uid)
                        .get()
                        .then((value) {
                      setState(() {
                        email = value.data['Email'].toString() == "" ||
                                value.data['Email'].toString() == "null" ||
                                value.data['Email'].toString() == null
                            ? "Email"
                            : value.data['Email'].toString();
                        username = value.data['Username'].toString() == "" ||
                                value.data['Username'].toString() == "null" ||
                                value.data['Username'].toString() == null
                            ? "Username"
                            : value.data['Username'].toString();
                        mobile = value.data['Mobile'].toString() == "" ||
                                value.data['Mobile'].toString() == "null" ||
                                value.data['Mobile'].toString() == null
                            ? "Mobile"
                            : value.data['Mobile'].toString();
                        address = value.data['Address'].toString() == "" ||
                                value.data['Address'].toString() == "null" ||
                                value.data['Address'].toString() == null
                            ? "Address"
                            : value.data['Address'].toString();
                      });
                    });
                    _emailSet = false;
                    _usernameSet = false;
                    _mobileSet = false;
                    _addressSet = false;
                  });
                }
              }
            },
            backgroundColor: lightblue,
            label: Text(
              "SAVE PROFILE INFO",
              style: TextStyle(
                  fontFamily: "Open Sans",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: -1.5,
                  wordSpacing: 2.0),
            ),
          )
        ],
      ),
    );
  }

  void addcall(
    String email,
    String username,
    String mobile,
    String address,
  ) async {
    await databaseReference
        .collection("users")
        .document(UserDetail.uid)
        .updateData({
      'Email': email,
      'Username': username,
      'Mobile': mobile,
      'Address': address,
    });
  }
}
