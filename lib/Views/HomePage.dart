import 'package:finalLetsConnect/Views/Accesories.dart';
import 'package:finalLetsConnect/Views/formPage.dart';
import 'package:finalLetsConnect/Views/servicePage.dart';
import 'package:finalLetsConnect/Views/settingsPage.dart';
import 'package:finalLetsConnect/styles/appImages.dart';
import 'package:finalLetsConnect/styles/network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:finalLetsConnect/Views/assets.dart';
import 'package:finalLetsConnect/Views/wallet.dart';
import 'package:finalLetsConnect/Views/callHistoryPage.dart';
import 'package:finalLetsConnect/styles/appColors.dart';
import 'package:finalLetsConnect/styles/apptext.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _tabs = [
      homeWidget(context),
      CallHistoryPage(),
      WalletPage(),
      SettingsPage()
    ];
    return Container(
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            iconSize: 20,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.orange,
            elevation: 0,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                backgroundColor: Color(0xFF5165E0),
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                backgroundColor: Color(0xFF5165E0),
                icon: Icon(Icons.history),
                title: Text('Call History'),
              ),
              BottomNavigationBarItem(
                  backgroundColor: Color(0xFF5165E0),
                  icon: Icon(Icons.account_balance_wallet),
                  title: Text("Wallet")),
              BottomNavigationBarItem(
                backgroundColor: Color(0xFF5165E0),
                icon: Icon(Icons.person),
                title: Text('Profile'),
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
          body: _tabs[_selectedIndex]),
    );
  }
}

// Widget _buildListSectionHeader(BuildContext context, String title) {
//   return Container(
//     color: Colors.transparent,
//     padding: EdgeInsets.only(left: 40.0, top: 30.0, bottom: 8),
//     child: Text(
//       title,
//       style: bodyHeadline1,
//     ),
//   );
// }

onGridTapped(BuildContext context, int index) {
  Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) => grid_tab[index],
      ));
}
List<TextEditingController> editCtrl=[];
final grid_tab = [
  FormPage(subject:"Monitor"),
  FormPage(subject:"Wires and Cables"),
  FormPage(subject:"Keyboard"),
  FormPage(subject:"RAM,ROM or Motherboard"),
  FormPage(subject:"Router"),
  FormPage(subject:"Printer"),
];

Widget categorygrid(BuildContext context) {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      mainAxisSpacing: 0.75,
      crossAxisSpacing: 0,
      crossAxisCount: 3,
      childAspectRatio: 1,
    ),
    physics: ScrollPhysics(),
    padding: EdgeInsets.all(8),
    itemCount: 6,
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
          onTap: () {
            onGridTapped(context, index);
          },
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(0),
                  padding: const EdgeInsets.all(38.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Img(all[index]),
                ),
              ]));
    },
  );
}

Widget Img(String img) {
  return PNetworkImage(
    img,
    fit: BoxFit.cover,
    height: 50,
    width: 50,
  );
}

Widget homeWidget(BuildContext context) {
  return Scaffold(
    appBar: defaultAppBar(context),
    body: SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            homeUserIntro(context),
            Container(
              child: categorygrid(context),
            ),
            lister(context)
          ],
        ),
        padding: EdgeInsets.only(bottom: 0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [lightblue, darkblue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
      ),
    ),
  );
}

Widget homeUserIntro(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 20),
    child: Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(top: 8),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: new BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8.0,
                          spreadRadius: 0.1,
                          offset: Offset(0, 12))
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: lightWhite,
                  ),
                  padding: EdgeInsets.only(right: 7, left: 7),
                  height: MediaQuery.of(context).size.height / 3.5,
                  width: MediaQuery.of(context).size.width,
                  child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: adv.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4.0),
                            child: PNetworkImage(
                              adv[index],
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ))
        // Container(
        //   child: Icon(
        //     Icons.check,
        //     size: 70,
        //     color: lightWhite,
        //   ),
        //   alignment: Alignment.centerLeft,
        // ),
        // Container(
        //   child: Text(
        //     'Hello, User',
        //     style: userIntroName,
        //   ),
        //   alignment: Alignment.centerLeft,
        // ),
        // Container(
        //   child: Text(
        //     'This is a user description area..',
        //     style: userIntroDes,
        //   ),
        //   alignment: Alignment.centerLeft,
        // ),
        // Container(
        //   child: Text(
        //     'TIME :' + DateTime.now().toString(),
        //     style: homePageTime,
        //   ),
        //   padding: EdgeInsets.only(top: 28),
        //   alignment: Alignment.centerLeft,
        // ),
      ],
    ),
  );
}

Widget lister(BuildContext context) {
  return DefaultTabController(
    length: 2,
    child: Container(
      color: Colors.transparent,
      height: 350,
      padding: EdgeInsets.only(top: 15, bottom: 10),
      child: TabBarView(
        // padding: EdgeInsets.only(left: 20, right: 40),
        // scrollDirection: Axis.horizontal,
        children: <Widget>[
          homeCardContainer(context, "/service"),
          homeCardContainer(context, "/accesories"),
        ],
      ),
    ),
  );
}

Widget homeCardContainer(BuildContext context, String tab) {
  // var mycolor = Color(0xFF0AB0B8);
  return InkWell(
    onTap: () {
      // mycolor = Color(0xFFF2F2F2);
      print('object');
      Navigator.pushNamed(context, tab);
    },
    child: Container(
      margin: EdgeInsets.only(left: 40, right: 40),
      // padding: EdgeInsets.all(20),
      width: 300,
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black26,
              blurRadius: 8.0,
              spreadRadius: 0.1,
              offset: Offset(0, 12))
        ],
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: lightWhite,
      ),
      child: innnerCardContainer(context, tab),
    ),
  );
}

Widget innnerCardContainer(BuildContext context, String tab) {
  if (tab == "/service")
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 10.0),
            child: Image.asset(
              'images/servicePage.png',
              height: 250,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 10.0),
          child: Text(
            'Service',
            style: cardTitleService,
            textAlign: TextAlign.start,
          ),
        )
      ],
    );
  if (tab == "/accesories")
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 10.0),
            child: Image.asset(
              'images/accPage.png',
              height: 250,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 10.0),
          child: Text(
            'Accesories',
            style: cardTitleAccesories,
            textAlign: TextAlign.start,
          ),
        )
      ],
    );
}

// Widget homeViewListView(BuildContext context) {
//   return Container(
//     child: ListView(
//       scrollDirection: Axis.horizontal,
//       children: <Widget>[
//         Container(
//           width: 160.0,
//           color: Colors.red,
//         ),
//         Container(
//           width: 160.0,
//           color: Colors.yellow,
//         ),
//         Container(
//           width: 160.0,
//           color: Colors.blue,
//         ),
//       ],
//     ),
//   );
// }
