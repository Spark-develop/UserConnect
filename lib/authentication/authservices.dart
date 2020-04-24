import 'package:finalLetsConnect/authentication/test.dart';
import 'package:finalLetsConnect/authentication/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finalLetsConnect/authentication/verId.dart';
import 'package:googleapis/people/v1.dart'
    show ListConnectionsResponse, PeopleApi;
import 'package:google_sign_in/google_sign_in.dart'
    show GoogleSignIn, GoogleSignInAccount, GoogleSignInAuthentication;
    
class AuthService {
  final Future<bool> smsCodeDialog;
  AuthService({this.smsCodeDialog});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String verificationId;

  User _userFromFirebaseUser(FirebaseUser user) {
  //  if(user != null){
  //   UserDetail.email = user.email;
  //   UserDetail.mob = user.phoneNumber;
  //  }
    return user != null ? User(uid: user.uid,email: user.email,number: user.phoneNumber) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future sendPasswordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.message);
      return null;
    }
  }

  Future signInWithGoogle() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential =
          await GoogleAuthProvider.getCredential(
              idToken: googleSignInAuthentication.idToken,
              accessToken: googleSignInAuthentication.accessToken);
      final FirebaseUser user =
          (await _auth.signInWithCredential(authCredential)).user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithPhoneAuth(AuthCredential authCredential) async {
    try {
      AuthResult result = await _auth.signInWithCredential(authCredential);
      FirebaseUser uuser = result.user;
      
      return _userFromFirebaseUser(uuser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> sendCodeToPhoneNumber(PhoneNo) async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential authResult) {
      signInWithPhoneAuth(authResult);
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      print(
          'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      // this.verificationId = verificationId;
      VerId.yourID = verificationId.toString();
      smsCodeDialog.then((value) => print("Signed In"));
      // verid(verId: verificationId);
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;
      print("time out");
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: PhoneNo,
        timeout: Duration(seconds: 20),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: null);
  }
}
class UserDetails {
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final List<ProviderDetails> providerData;

  UserDetails(this.providerDetails,this.userName, this.photoUrl,this.userEmail, this.providerData);
}


class ProviderDetails {
  ProviderDetails(this.providerDetails);
  final String providerDetails;
}