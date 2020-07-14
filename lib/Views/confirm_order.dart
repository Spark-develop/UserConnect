import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalLetsConnect/Views/formPage.dart';
import 'package:finalLetsConnect/authentication/test.dart';
import 'package:finalLetsConnect/styles/network_image.dart';
import 'package:flutter/material.dart';
import 'package:finalLetsConnect/styles/appColors.dart';

class ConfirmOrderPage extends StatefulWidget {
  final String itemsSubject;
  final String itemsImage;
  final int itemsCost;
  const ConfirmOrderPage(
      {Key key, this.itemsSubject, this.itemsImage, this.itemsCost})
      : super(key: key);
  @override
  _ConfirmOrderPageState createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  final String phone = UserDetail.mob;
  bool costZero = false;
  int total;
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Service Costing', style: TextStyle(fontSize: 22)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you really want to exit,Items'),
                Row(
                  children: [
                    Text("in the"),
                    Icon(
                      Icons.shopping_cart,
                      color: Color(0xFF5165E0),
                    ),
                    Text("will get discarded!")
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Row(children: <Widget>[
                Icon(
                  Icons.backspace,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Back',
                  style: TextStyle(fontSize: 20),
                )
              ]),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(width: 30),
            FlatButton(
              child: Row(children: <Widget>[
                Text(
                  'Approve',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.check_box,
                  color: Colors.red,
                ),
              ]),
              onPressed: () {
                Firestore.instance
                    .collection('users')
                    .document(UserDetail.uid)
                    .collection('calls')
                    .getDocuments()
                    .then((value) {
                  for (DocumentSnapshot ds in value.documents) {
                    ds.reference.delete();
                  }
                });
                Navigator.popUntil(context, ModalRoute.withName('/service'));
              },
            ),
          ],
        );
      },
    );
  }

  Widget MyButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showMyDialog();
      },
      child: CircleAvatar(
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MyButton(context),
        title: Text(
          "Cart",
          style: TextStyle(
              fontFamily: "Open Sans",
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: lightWhite,
              letterSpacing: -1.5,
              wordSpacing: 2.0),
        ),
        backgroundColor: lightblue,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('users')
                .document(UserDetail.uid)
                .collection('calls')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return const Text('Loading');

              final int messageCount = snapshot.data.documents.length;
              return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: messageCount,
                  itemBuilder: (_, int index) {
                    final DocumentSnapshot document =
                        snapshot.data.documents[index];
                    final dynamic model = document['model'];
                    final dynamic issue = document['issue'];
                    final dynamic subject = document['subject'];
                    final dynamic icon = document['icon'];

                    return ListTile(
                      // shape: ,
                      leading: Container(
                          width: MediaQuery.of(context).size.width / 7,
                          child: Center(child: PNetworkImage(icon))),
                      trailing: IconButton(
                        splashColor: Colors.red,
                        splashRadius: 30,
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          document.reference.delete();
                          if (messageCount == 1) {
                            setState(() {
                              costZero = true;
                            });
                          }
                        },
                      ),
                      title: Text(
                          subject != null ? subject : "No Subject Mentioned!"),
                      subtitle: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Text(model != null
                                ? "Model:${model.toString()}"
                                : "No Model Mentioned!"),
                            Text(issue != null
                                ? "Model:${issue.toString()}"
                                : "No issue Mentioned!"),
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
          _buildBody(context),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding:
          EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0, bottom: 10.0),
      child: Column(
        children: <Widget>[
          RaisedButton(
              color: darkblue,
              onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FormPage(
                                  initial:
                                      "https://firebasestorage.googleapis.com/v0/b/connect-59a1f.appspot.com/o/app%20assets%2F5589.jpg?alt=media&token=7abb0b36-8626-435d-b20b-d49398999b16",
                                  itemCost: 400,
                                )))
                  },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add More Items",
                      style: TextStyle(
                          fontFamily: "Open Sans",
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          letterSpacing: -1.5,
                          wordSpacing: 2.0),
                    ),
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ],
                ),
              )),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Subtotal",
                style: TextStyle(
                    fontFamily: "Open Sans",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    letterSpacing: -1.5,
                    wordSpacing: 2.0),
              ),
              Text(
                costZero == true ? "₹${0}" : "₹${widget.itemsCost}",
                // "₹$finalCost",
                style: TextStyle(
                    fontFamily: "Open Sans",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    letterSpacing: -1.5,
                    wordSpacing: 2.0),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Discount",
                style: TextStyle(
                    fontFamily: "Open Sans",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    letterSpacing: -1.5,
                    wordSpacing: 2.0),
              ),
              Text(
                "",
                // "$discount%",
                style: TextStyle(
                    fontFamily: "Open Sans",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    letterSpacing: -1.5,
                    wordSpacing: 2.0),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Total",
                style: TextStyle(
                    fontFamily: "Open Sans",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    letterSpacing: -1.5,
                    wordSpacing: 2.0),
              ),
              Text(
                "",
                // discount == 0"
                //     ? "₹${finalCost + discount}"
                //     : "₹${finalCost * (discount / 100)}",
                style: TextStyle(
                    fontFamily: "Open Sans",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    letterSpacing: -1.5,
                    wordSpacing: 2.0),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
              color: Colors.grey.shade200,
              padding: EdgeInsets.all(8.0),
              width: double.infinity,
              child: Text(
                "Delivery Address".toUpperCase(),
                style: TextStyle(
                    fontFamily: "Open Sans",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: darkblue,
                    letterSpacing: -1.5,
                    wordSpacing: 2.0),
              )),
          Column(
            children: <Widget>[
              // UserDetail.address != "" ||
              //         UserDetail.address != "null" ||
              UserDetail.address != null
                  ? RadioListTile(
                      activeColor: darkblue,
                      selected: true,
                      value: "address",
                      groupValue: "address",
                      title: Text(
                        "address",
                        style: TextStyle(
                            fontFamily: "Open Sans",
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: darkblue,
                            letterSpacing: -1.5,
                            wordSpacing: 2.0),
                      ),
                      onChanged: (value) {},
                    )
                  : RadioListTile(
                      activeColor: darkblue,
                      selected: false,
                      value: "New Address",
                      groupValue: "address",
                      title: Text(
                        "Choose new delivery address",
                        style: TextStyle(
                            fontFamily: "Open Sans",
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            letterSpacing: -1.5,
                            wordSpacing: 2.0),
                      ),
                      onChanged: (value) {},
                    ),
              Container(
                  color: Colors.grey.shade200,
                  padding: EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: Text(
                    "Contact Number".toUpperCase(),
                    style: TextStyle(
                        fontFamily: "Open Sans",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: darkblue,
                        letterSpacing: -1.5,
                        wordSpacing: 2.0),
                  )),
              RadioListTile(
                activeColor: darkblue,
                selected: true,
                value: phone,
                groupValue: phone,
                title: Text(
                  phone,
                  style: TextStyle(
                      fontFamily: "Open Sans",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: darkblue,
                      letterSpacing: -1.5,
                      wordSpacing: 2.0),
                ),
                onChanged: (value) {},
              ),
              RadioListTile(
                activeColor: darkblue,
                selected: false,
                value: "New Phone",
                groupValue: phone,
                title: Text(
                  "Choose new contact number",
                  style: TextStyle(
                      fontFamily: "Open Sans",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      letterSpacing: -1.5,
                      wordSpacing: 2.0),
                ),
                onChanged: (value) {},
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
              color: Colors.grey.shade200,
              padding: EdgeInsets.all(8.0),
              width: double.infinity,
              child: Text(
                "Payment Option".toUpperCase(),
                style: TextStyle(
                    fontFamily: "Open Sans",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: darkblue,
                    letterSpacing: -1.5,
                    wordSpacing: 2.0),
              )),
          RadioListTile(
            activeColor: darkblue,
            groupValue: true,
            value: true,
            title: Text(
              "Cash on Delivery",
              style: TextStyle(
                  fontFamily: "Open Sans",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  letterSpacing: -1.5,
                  wordSpacing: 2.0),
            ),
            onChanged: (value) {},
          ),
          Container(
            width: double.infinity,
            child: RaisedButton(
              color: darkblue,
              onPressed: () => {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Confirm Order",
                  style: TextStyle(
                      fontFamily: "Open Sans",
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      letterSpacing: -1.5,
                      wordSpacing: 2.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
