import './Phone_auth.dart';
import './googleauth.dart';

import './login2.dart';
import './signup1.dart';
import 'package:flutter/material.dart';

class authenticate extends StatefulWidget {
  @override
  _authenticateState createState() => _authenticateState();
}

class _authenticateState extends State<authenticate>
 {
  int counter=0;
  void toggleview(tag) => setState(()=>counter=tag);
  @override
  Widget build(BuildContext context) {
    if(counter==0){
      return LoginTwoPage(toggleview: toggleview);
    }
    else if(counter==1){
      return Phone_auth(toggleview:toggleview);
    }
    else if(counter==2){
      return SignupOnePage(toggleview:toggleview);
    }
  }
}
