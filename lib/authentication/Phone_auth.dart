import 'package:finalLetsConnect/authentication/login2.dart';
import 'package:finalLetsConnect/authentication/test.dart';
import 'package:finalLetsConnect/styles/appColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finalLetsConnect/authentication/authservices.dart';
import 'package:finalLetsConnect/authentication/spinkit1.dart';
import 'package:finalLetsConnect/authentication/verId.dart';
import 'package:finalLetsConnect/styles/apptext.dart';
import 'package:googleapis/chat/v1.dart';

enum PhoneAuthState {
  Started,
  CodeSent,
  CodeResent,
  Verified,
  Failed,
  Error,
  AutoRetrievalTimeOut
}

class Phone_auth extends StatefulWidget {
  Phone_auth({
    Key key,
    this.toggleview,
  }) : super(key: key);
  final Function toggleview;
  // final bool flag;
  // final String title;

  @override
  _PhoneAuth createState() => _PhoneAuth();
}

class _PhoneAuth extends State<Phone_auth> {
  final _formkey = GlobalKey<FormState>();
  String PhoneNumber, smsCode;
  static var _authcred;
  bool _isLoading = false;

  void signInWithPhoneNumber(String smsCode) async {
    _authcred = PhoneAuthProvider.getCredential(
        verificationId: VerId.yourID, smsCode: smsCode);
    try {
      await FirebaseAuth.instance
          .signInWithCredential(_authcred)
          .then((AuthResult result) async {
        print('Authentication successful');
        print(PhoneAuthState.Verified);
      }).catchError((error) {
        print(PhoneAuthState.Error);
        print(
            'Something has gone wrong, please try later(signInWithPhoneNumber) $error');
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget _buildPageContent(BuildContext context) {
    return _isLoading
        ? Loading()
        : SafeArea(
            child: Scaffold(
              body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Form(
                    key: _formkey,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF73AEF5),
                                Color(0xFF61A4F1),
                                Color(0xFF478DE0),
                                Color(0xFF398AE5),
                              ],
                              stops: [0.1, 0.4, 0.7, 0.9],
                            ),
                          ),
                        ),
                        Container(
                          height: double.infinity,
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: 40.0,
                              // vertical: 120.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 50.0),
                                Text(
                                  'Sign In With Phone',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'OpenSans',
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                _buildPhoneNumber(),
                                _buildSentOtp(),
                                showCircularProgress(),
                                _buildSignInWithText(),
                                _buildSignupBtn(),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () async {
        widget.toggleview(2);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Dont have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign-Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget _buildSentOtp() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          AuthService(smsCodeDialog: smsCodeDialog(context))
              .sendCodeToPhoneNumber(PhoneNumber);
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'SEND OTP',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Phone Number',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            onChanged: (val) => setState(() => PhoneNumber = val),
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.white,
              ),
              hintText: 'Enter your Phone Number',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Enter Code"),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              FlatButton(
                child: Text("Verify"),
                onPressed: () {
                  UserDetail.mob = PhoneNumber;
                  UserDetail.email = null;
                  FirebaseAuth.instance.currentUser().then((user) {
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed('/homepage');
                    } else {
                      Navigator.of(context).pop();
                      signInWithPhoneNumber(smsCode);
                    }
                  });
                },
              )
            ],
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageContent(context),
      appBar: AppBar(
        backgroundColor: Color(0xFF73AEF5),
        elevation: 0,
        leading: MyButton(context)
      ),
    );
  }
  Widget MyButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.toggleview(0);
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(12.0),
        child: CircleAvatar(child: Icon(Icons.arrow_back_ios,color:lightWhite,),backgroundColor:Colors.transparent,),
      ),
    );
  }
}

