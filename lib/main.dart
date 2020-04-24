import 'package:finalLetsConnect/authentication/authenticate.dart';
import 'package:finalLetsConnect/authentication/authservices.dart';
import 'package:finalLetsConnect/authentication/route.dart';
import 'package:finalLetsConnect/authentication/test.dart';
import 'package:finalLetsConnect/authentication/users.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finalLetsConnect/Views/callHistoryPage.dart';
import 'package:finalLetsConnect/Views/formPage.dart';
import 'package:finalLetsConnect/Views/servicePage.dart';
import 'package:finalLetsConnect/authentication/login2.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<MyApp> {
      final FirebaseMessaging _fcm = FirebaseMessaging();
  
  @override
  void initState() {
    super.initState();
    _fcm.configure(onMessage: (Map<String, dynamic> message) async {
      print('onMessage:$message');
    }, onResume: (Map<String, dynamic> message) async {
      print('onMessage:$message');
    }, onLaunch: (Map<String, dynamic> message) async {
      print('onMessage:$message');
    });
    _saveDeviceToken();
  }

 _saveDeviceToken() async{
    String _fcmToken = await _fcm.getToken();
    UserDetail.tokenz=_fcmToken;
 }
  
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Proto',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // home: SettingsPage(),
          home: Router(),
          routes: {
            '/service': (context) => Service(),
            '/form': (context) => FormPage(),
            '/callHistory': (context) => CallHistoryPage(),
            '/login': (context) => LoginTwoPage(),
            '/authenticate': (context) => authenticate(),
          },
        ));
  }
}
