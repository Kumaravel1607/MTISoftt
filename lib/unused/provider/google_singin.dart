// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class GoogleSignInProvider extends ChangeNotifier {
//   final googleSignIn = GoogleSignIn();
//   GoogleSignInAccount? _user;

//   GoogleSignInAccount get user => _user!;

//   Future googleLogin() async {
//     final googleUser = await googleSignIn.signIn();
//     if (googleUser == null) return;
//     _user = googleUser;

//     final googleAuth = await googleUser.authentication;

//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     await FirebaseAuth.instance.signInWithCredential(credential);

//     notifyListeners();
//   }

//   Future logout() async {
//     await googleSignIn.disconnect();
//     FirebaseAuth.instance.signOut();
//   }

//   Future<void> signinWithFacebook(BuildContext context) async {
//     try {
//       final LoginResult loginResult = await FacebookAuth.instance.login();
//       final OAuthCredential facebookAuthCredential =
//           FacebookAuthProvider.credential(loginResult.accessToken!.token);

//       await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
//     } on FirebaseAuthException catch (e) {
//       showSnackBar(context, e.message!);
//     }
//   }

//   void showSnackBar(BuildContext context, String text) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
//   }
// }
