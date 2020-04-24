import 'package:finalLetsConnect/authentication/authservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String emailRes;
   String _email;
   final AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: ListView(
          padding: EdgeInsets.only(right:40,left: 40,top:100),
          children:<Widget>[
                TextFormField(
                  validator: (val) => val.isEmpty ? "input empty" : null,
                  style: TextStyle(color: Colors.blue),
                  onChanged: (val) => setState(() => emailRes = val),
                  decoration: InputDecoration(
                      hintText: "Email address",
                      hintStyle: TextStyle(color: Colors.blue.shade200),
                      icon: Icon(
                        Icons.email,
                        color: Colors.blue,
                      )),
                ),
                FlatButton(
                  onPressed: () async {
                      if(emailRes==null){
                        print('Please enter your email');
                      }
                      else{
                      await auth.sendPasswordResetEmail(emailRes);
                      print("A password reset link has been sent to $emailRes");
                      }
                    },
                    color: Colors.transparent,
                    child: Text(
                      "Reset Password",
                      style: TextStyle(color: Colors.black45, fontSize: 15),
                    )
                    ),
          ]
        ),
      )
      
    );
  }
}