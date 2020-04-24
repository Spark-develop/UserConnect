import 'package:finalLetsConnect/authentication/authservices.dart';
import 'package:finalLetsConnect/authentication/spinkit1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth extends StatefulWidget {
  final Function toggleview;
  final UserDetails detailsUser;
  const GoogleAuth({Key key, this.toggleview, this.detailsUser})
      : super(key: key);
  @override
  _GoogleAuthState createState() => _GoogleAuthState();
}

class _GoogleAuthState extends State<GoogleAuth> {
  bool _isLoading = false;
  String Googemail;
  final _formkey = GlobalKey<FormState>();
  Widget _buildPageContent(BuildContext context) {
    final GoogleSignIn _gSignIn = GoogleSignIn();
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
                                  'Google Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'OpenSans',
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                _buildPhoneNumber(),
                                _buildSentOtp(),
                                showCircularProgress(),
                                _buildSignInWithText(),
                                _buildSignupBtn(),
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(widget.detailsUser.photoUrl),
                                  radius: 50.0,
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  "Name : " + widget.detailsUser.userName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20.0),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  "Email : " + widget.detailsUser.userEmail,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20.0),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  "Provider : " + widget.detailsUser.providerDetails,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20.0),
                                ),
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

  Widget _buildPhoneNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[SizedBox(height: 20)],
    );
  }

  Widget _buildSentOtp() {
    return Container(
        //   padding: EdgeInsets.symmetric(vertical: 25.0),
        //   width: double.infinity,
        //   child: RaisedButton(
        //     elevation: 5.0,
        //     onPressed: () async {

        //     },
        //     padding: EdgeInsets.all(15.0),
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(30.0),
        //     ),
        //     color: Colors.white,
        //     child: Text(
        //       'SEND OTP',
        //       style: TextStyle(
        //         color: Color(0xFF527DAA),
        //         letterSpacing: 1.5,
        //         fontSize: 18.0,
        //         fontWeight: FontWeight.bold,
        //         fontFamily: 'OpenSans',
        //       ),
        //     ),
        //   ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageContent(context),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () async {
        widget.toggleview(0);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Try with email? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: "Sign-In",
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
}
