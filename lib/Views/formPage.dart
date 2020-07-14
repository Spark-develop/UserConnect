import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalLetsConnect/Views/confirm_order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finalLetsConnect/styles/appColors.dart';
import 'package:finalLetsConnect/styles/network_image.dart';
import 'package:finalLetsConnect/authentication/test.dart';
import 'package:googleapis/adsense/v1_4.dart';

class FormPage extends StatefulWidget {
  final String initial;
  final String subject;
  final int itemCost;
  const FormPage({Key key, this.initial, this.subject, this.itemCost})
      : super(key: key);
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  var subjectCallItem, _selectedItems;

  _onGetItemImage() {
    Firestore.instance
        .collection("others")
        .where("subject", isEqualTo: subjectCallItem)
        .getDocuments()
        .then((value) {
      value.documents.forEach((result) {
        _selectedItems = result.data['icon'].toString();
      });
    });
  }

  final _model = TextEditingController();
  final _issue = TextEditingController();
  final _subject = TextEditingController();

  void dispose() {
    _model.dispose();
    _issue.dispose();
    _subject.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightblue,
        elevation: 0,
        leading: MyButton(context),
      ),
      body: mainForm(context),
    );
  }

  Widget MyButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
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

  Widget mainForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('others').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return const Text('Loading');
                else {
                  List<DropdownMenuItem> subjectCall = [];
                  for (int i = 0; i < snapshot.data.documents.length; i++) {
                    final DocumentSnapshot document =
                        snapshot.data.documents[i];
                    final dynamic subject = document['subject'];
                    subjectCall.add(DropdownMenuItem(
                      child: Text(
                        subject,
                        style: TextStyle(color: darkblue, fontSize: 15),
                      ),
                      value: "$subject",
                    ));
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      subjectCallItem != null
                          ? Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: PNetworkImage(
                                subjectCallItem == 'Monitor'
                                    ? 'https://firebasestorage.googleapis.com/v0/b/connect-59a1f.appspot.com/o/app%20assets%2Fmonitor1.png?alt=media&token=6e1ad0f1-75d1-4fed-956a-7edd742e31ea'
                                    : subjectCallItem == 'Laptops'
                                        ? 'https://firebasestorage.googleapis.com/v0/b/connect-59a1f.appspot.com/o/app%20assets%2Fothers%2FLaptop1.png?alt=media&token=411a315d-4d02-4cf4-afe6-6f7cf2b22d91'
                                        : subjectCallItem == 'Tablets'
                                            ? 'https://firebasestorage.googleapis.com/v0/b/connect-59a1f.appspot.com/o/app%20assets%2Fothers%2Ftablets1.png?alt=media&token=5975b7ce-9050-4e36-81b5-d622b803445a'
                                            : subjectCallItem == 'CCTV'
                                                ? 'https://firebasestorage.googleapis.com/v0/b/connect-59a1f.appspot.com/o/app%20assets%2Fothers%2Fcctv.png?alt=media&token=15b399ef-6124-4633-ba49-6491a05325c9'
                                                : subjectCallItem ==
                                                        'Printers and Xerox'
                                                    ? 'https://firebasestorage.googleapis.com/v0/b/connect-59a1f.appspot.com/o/app%20assets%2FPicture2.png?alt=media&token=ba2923e4-b0dd-46e8-8605-207e0d651447'
                                                    : subjectCallItem ==
                                                            'RAM, ROM and memory modules or Motherboard'
                                                        ? 'https://firebasestorage.googleapis.com/v0/b/connect-59a1f.appspot.com/o/app%20assets%2Fram-computer-memory.png?alt=media&token=23555357-dcf1-4559-aa6c-744d87612f85'
                                                        : subjectCallItem ==
                                                                'Biomatrix'
                                                            ? 'https://firebasestorage.googleapis.com/v0/b/connect-59a1f.appspot.com/o/app%20assets%2Fothers%2Fbio1.png?alt=media&token=5aac846d-faad-4b81-b648-f2c1040aa3bb'
                                                            : subjectCallItem ==
                                                                    'CPU, Desktop Pc and Smart Stations'
                                                                ? 'https://firebasestorage.googleapis.com/v0/b/connect-59a1f.appspot.com/o/app%20assets%2Fss1.png?alt=media&token=16cfae6c-a3ab-404e-8b3e-4dd73b431b2e'
                                                                : subjectCallItem ==
                                                                        'Cables and Connectors'
                                                                    ? 'https://firebasestorage.googleapis.com/v0/b/connect-59a1f.appspot.com/o/app%20assets%2F%E2%80%94Pngtree%E2%80%94simple%20style%20cable%20elements%20are_4020545.png?alt=media&token=852eafb1-e98a-4410-bb7d-0701f9cb1699'
                                                                    : subjectCallItem ==
                                                                            'Keyboard and mouse'
                                                                        ? 'https://firebasestorage.googleapis.com/v0/b/connect-59a1f.appspot.com/o/app%20assets%2F%E2%80%94Pngtree%E2%80%94flat%20wind%20keyboard%20and%20mouse_4480360.png?alt=media&token=52b6fe8a-83b6-4c9e-b9c9-caec26d2b551'
                                                                        : subjectCallItem ==
                                                                                'Routers'
                                                                            ? 'https://firebasestorage.googleapis.com/v0/b/connect-59a1f.appspot.com/o/app%20assets%2Fothers%2Frouter1.png?alt=media&token=94ab7fad-87e4-45bb-9831-a81fed6513be'
                                                                            : null,
                                height: MediaQuery.of(context).size.height / 5,
                              ),
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: PNetworkImage(
                                widget.initial,
                                height: MediaQuery.of(context).size.height / 5,
                              ),
                            ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField(
                          decoration: new InputDecoration(
                            fillColor: lightWhite,
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: darkblue, width: 2.0),
                              borderRadius: new BorderRadius.circular(25.0),
                            ),
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                          ),
                          hint: Text(
                            widget.subject == null
                                ? "Select Your Problem"
                                : widget.subject,
                            overflow: TextOverflow.visible,
                            style: TextStyle(fontSize: 15.0, color: darkblue),
                          ),
                          isExpanded: true,
                          items: subjectCall,
                          onChanged: (subs) {
                            setState(() {
                              subjectCallItem = subs;
                              _onGetItemImage();
                            });
                          },
                          value: subjectCallItem,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new TextFormField(
                          controller: _model,
                          autofocus: false,
                          decoration: new InputDecoration(
                            labelText: "Model No.",
                            labelStyle: TextStyle(color: darkblue),
                            fillColor: lightWhite,
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: darkblue, width: 2.0),
                              borderRadius: new BorderRadius.circular(25.0),
                            ),
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                          ),
                          validator: (_model) {
                            if (_model.length == 0) {
                              return "Model can't be Empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new TextFormField(
                          controller: _issue,
                          autofocus: false,
                          decoration: new InputDecoration(
                            labelText: "Issues",
                            labelStyle: TextStyle(color: darkblue),
                            fillColor: lightWhite,
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: darkblue, width: 2.0),
                              borderRadius: new BorderRadius.circular(25.0),
                            ),
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          validator: (_issue) {
                            if (_issue.length == 0) {
                              return "Describe the Issue..";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 8,
                            child: Text(
                              "₹",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 40),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            flex: 40,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 13,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)),
                                  border: Border.all(color: Colors.grey)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 18.0),
                                    child: Text(
                                      "${widget.itemCost}",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  VerticalDivider(
                                    width: 1,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        return _showMyDialog();
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.info, color: darkblue),
                                        Text(
                                          "Click here for more information",
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              fontSize: 15, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              if (subjectCallItem != null) {
                                addcall(
                                  subjectCallItem,
                                  _model.text,
                                  _issue.text,
                                  _selectedItems,
                                  UserDetail.uid,
                                );
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ConfirmOrderPage(
                                              itemsSubject: subjectCallItem,
                                              itemsImage: _selectedItems,
                                              itemsCost: widget.itemCost,
                                            )));
                                // smsCodeDialog(context);
                              } else {
                                addcall(
                                  widget.subject,
                                  _model.text,
                                  _issue.text,
                                  widget.initial,
                                  UserDetail.uid,
                                );
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ConfirmOrderPage(
                                              itemsSubject: widget.subject,
                                              itemsImage: widget.initial,
                                              itemsCost: widget.itemCost,
                                            )));
                                // smsCodeDialog(context);
                              }
                            }
                          },
                          backgroundColor: Color(0xfff0f0f0),
                          label: Row(
                            children: [
                              Text("Add to ",
                                  style: TextStyle(
                                      fontFamily: "Open Sans",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: darkblue,
                                      letterSpacing: -1.5,
                                      wordSpacing: 2.0)),
                              Icon(
                                Icons.shopping_cart,
                                color: darkblue,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              })),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Service Costing'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'This is to acknowledge that service cost will not vary according to the number of services related to any '),
                Row(
                  children: [
                    Text("category added to the "),
                    Icon(
                      Icons.shopping_cart,
                      color: Color(0xFF5165E0),
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final databaseReference = Firestore.instance;
  final FirebaseAuth _firebase = FirebaseAuth.instance;
  void addcall(String sub, String modelNo, String issues, String serviceIcon,
      String usrer) async {
    await databaseReference
        .collection("users")
        .document(usrer)
        .collection('calls')
        .document()
        .setData({
      'model': modelNo,
      'issue': issues,
      'subject': sub,
      'icon': serviceIcon,
    });
  }
}
//https://github.com/Spark-develop/Systech.git
