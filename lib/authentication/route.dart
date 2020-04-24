import 'package:finalLetsConnect/Views/HomePage.dart';
import 'package:finalLetsConnect/authentication/authenticate.dart';
import 'package:finalLetsConnect/authentication/test.dart';
import 'package:finalLetsConnect/authentication/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Router extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    final adminU =  Provider.of<User>(context);
    print(adminU);
    if(adminU==null){

      return authenticate();
    }
    else{
            UserDetail.email = adminU.email;
      UserDetail.mob = adminU.number;
      return MyHomePage();
    }
  }
}