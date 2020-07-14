import 'package:finalLetsConnect/Views/HomePage.dart';
import 'package:finalLetsConnect/authentication/authenticate.dart';
import 'package:finalLetsConnect/authentication/spinkit1.dart';
import 'package:finalLetsConnect/authentication/test.dart';
import 'package:finalLetsConnect/authentication/users.dart';
import 'package:finalLetsConnect/mapThing/UserLoaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class Router extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final adminU = Provider.of<User>(context);
    final userLocation = Provider.of<UserLocation>(context);
    if (adminU == null) {
      return authenticate();
    } else {
      UserDetail.email = adminU.email;
      UserDetail.mob = adminU.number;
      UserDetail.uid = adminU.uid;
      if (userLocation != null) {
        final coordinates =
            new Coordinates(userLocation.latitude, userLocation.longitude);
        var addresses =
            Geocoder.local.findAddressesFromCoordinates(coordinates);
        return MyHomePage(
          userAddress: addresses.toString(),
        );
      } else
        return Loading();
    }
  }
  // print(
  //     ' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
  // return first;
}
