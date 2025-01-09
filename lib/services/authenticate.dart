import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tuna_asis/pages/home/home.dart';
import 'package:tuna_asis/services/database.dart';

class Authenticate {
  final FirebaseAuth auth = FirebaseAuth.instance;
  getCurrentUser() async {
    return await auth.currentUser;
  }

  signInWithGoogle(BuildContext context) async {
    final FirebaseAuth firebaseauth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication?.idToken,
      accessToken: googleSignInAuthentication?.accessToken,
    );
    UserCredential result = await firebaseauth.signInWithCredential(credential);
    User? userDetails = result.user;
    if (result != null) {
      Map<String, dynamic> userInfoMap = {
        "email": userDetails!.email,
        "username": userDetails.displayName,
        "imgURL": userDetails.photoURL,
        "id": userDetails.uid,
      };
      await Database().addUser(userDetails.uid, userInfoMap).then(
            (value) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
            ),
          );
    }
  }
}
