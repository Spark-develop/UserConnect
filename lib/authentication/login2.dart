import 'package:finalLetsConnect/authentication/test.dart';
import 'package:flutter/services.dart';
import 'package:finalLetsConnect/authentication/authservices.dart';
import 'package:finalLetsConnect/authentication/resetpass.dart';
import 'package:finalLetsConnect/authentication/users.dart';
import 'package:finalLetsConnect/styles/apptext.dart';
import './spinkit1.dart';
import 'package:flutter/material.dart';

class LoginTwoPage extends StatefulWidget {
  final Function toggleview;
  LoginTwoPage({this.toggleview});
  @override
  _LoginTwoPageState createState() => _LoginTwoPageState();
}

class _LoginTwoPageState extends State<LoginTwoPage> {
  String emailR, passwordR, error = "";
  bool _rememberMe = false;
  bool _isLoading = false;
  User us;
  final AuthService auth = AuthService();
  bool passwordshow = false;
  final _formkey = GlobalKey<FormState>();
  Widget _buildPageContent(BuildContext context)  {
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
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'OpenSans',
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 30.0),
                                _buildEmailTF(),
                                SizedBox(
                                  height: 30.0,
                                ),
                                _buildPasswordTF(),
                                _buildForgotPasswordBtn(),
                                _buildRememberMeCheckbox(),
                                _buildLoginBtn(),
                                showCircularProgress(),
                                _buildSignInWithText(),
                                _buildSignupBtn(),
                                _buildSocialBtnRow(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageContent(context),
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
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            // TextSpan(
            //   text: error,
            //   style: TextStyle(
            //     color: Colors.red,
            //     fontSize: 18.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            //),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            validator: (val) => val.isEmpty ? "input empty" : null,
            onChanged: (val) => setState(() => emailR = val),
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            validator: (val) => val.length < 6 ? 'Too short Password' : null,
            obscureText: passwordshow == false ? true : false,
            onChanged: (val) => setState(() => passwordR = val),
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ResetPassword()),
          );
        },
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: passwordshow,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (bool value) {
                setState(() {
                  passwordshow = value;
                  print(passwordshow);
                });
              },
            ),
          ),
          Text(
            'Show Password',
            style: kLabelStyle,
          ),
        ],
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

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          UserDetail.email=emailR;
          UserDetail.mob=null;
          if (_formkey.currentState.validate()) {
            setState(() => _isLoading = true);
            dynamic result =
                await auth.signInWithEmailAndPassword(emailR, passwordR);

            if (result == null) {
              setState(() {
                error = 'credentials are wrong';
                _isLoading = false;
              });
            } else {
              print(result.uid);
            }
          } else {
            print("Input error!");
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
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
    Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }
    Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () => AuthService().signInWithGoogle(),
            AssetImage(
              'images/google2.webp',
            ),
          ),
          _buildSocialBtn(
            () => widget.toggleview(1),
            AssetImage(
              'images/phone2.png',
            ),
          ),
        ],
      ),
    );
  }
}
