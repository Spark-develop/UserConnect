import 'package:finalLetsConnect/Views/walletRedirectPage.dart';
import 'package:finalLetsConnect/styles/appColors.dart';
import 'package:flutter/material.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final fixedamount=TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:10),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
          TextFormField(
            controller: fixedamount,
            // initialValue:"250",
            // onChanged: (){
            // },
            decoration: new InputDecoration(
              labelText: "Price",
              hintText: "500",
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
          ButtonBar(
            mainAxisSize: MainAxisSize.max,
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WalletRedirectPage(amount:fixedamount.text)));
                },
              )
            ],
          )
        ]),
      ),
    );
  }
}
