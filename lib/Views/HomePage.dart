import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:finalLetsConnect/Views/settingsPage.dart';
import 'package:finalLetsConnect/styles/network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:finalLetsConnect/Views/assets.dart';
import 'package:finalLetsConnect/Views/walletPage.dart';
import 'package:finalLetsConnect/styles/appColors.dart';
import 'package:finalLetsConnect/styles/apptext.dart';

class MyHomePage extends StatefulWidget {
  final String userAddress;

  const MyHomePage({Key key, this.userAddress}) : super(key: key);
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
    print(widget.userAddress);
    final _tabs = [
      homeWidget(context),
      WalletPage(),
      WalletPage(),
      SettingsPage()
    ];
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 27,
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
        body: _tabs[_selectedIndex]);
  }
}

// onGridTapped(BuildContext context, int index) {
//   Navigator.push(
//       context,
//       MaterialPageRoute(
//         fullscreenDialog: true,
//         builder: (BuildContext context) => grid_tab[index],
//       ));
// }

List<TextEditingController> editCtrl = [];

Widget homeWidget(BuildContext context) {
  return Scaffold(
    appBar: defaultAppBar(context),
    body: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        height: MediaQuery.of(context).size.height / 1.212,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            homeUserIntro(context),
            // Container(
            //   child: categorygrid(context),
            // ),
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
  return Container(
    height: MediaQuery.of(context).size.height / 3,
    color: Colors.transparent,
    padding: EdgeInsets.only(top: 10.0, bottom: 16.0),
    child: Swiper(
      itemBuilder: (BuildContext context, int index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            color: Colors.black,
            child: PNetworkImage(
              "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg",
              fit: BoxFit.fill,
            ),
          ),
        );
      },
      containerHeight: 100,
      itemCount: 4,
      viewportFraction: 0.8,
      scale: 0.9,
      pagination: SwiperPagination(),
    ),
  );
}

Widget lister(BuildContext context) {
  return DefaultTabController(
    length: 1,
    child: Container(
      color: Colors.transparent,
      height: 350,
      padding: EdgeInsets.only(top: 15, bottom: 10),
      child: TabBarView(
        children: <Widget>[
          homeCardContainer(context, "/service"),
          // homeCardContainer(context, "/accesories"),
        ],
      ),
    ),
  );
}

Widget homeCardContainer(BuildContext context, String tab) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, tab);
    },
    child: Container(
      margin: EdgeInsets.only(left: 40, right: 40),
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
  // if (tab == "/accesories")
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Center(
  //         child: Padding(
  //           padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 10.0),
  //           child: Image.asset(
  //             'images/accPage.png',
  //             height: 250,
  //           ),
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 10.0),
  //         child: Text(
  //           'Accesories',
  //           style: cardTitleAccesories,
  //           textAlign: TextAlign.start,
  //         ),
  //       )
  //     ],
  //   );
}
