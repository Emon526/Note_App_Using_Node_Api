// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/home_page.dart';

class AuthProvider with ChangeNotifier {
  var firebaseAuth = FirebaseAuth.instance;

  void signOut() async {
    await firebaseAuth.signOut();
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   CupertinoPageRoute(builder: (context) => const LoginPage()),
    //   (Route route) => false,
    // );
  }

  Stream<User?> get user => firebaseAuth.authStateChanges();
  // void deleteaccount(BuildContext context, String uid) async {
  //   const snackbar = SnackBar(
  //     content: Text("Account Deleted"),
  //   );
  //   ScaffoldMessenger.of(context).showSnackBar(snackbar);

  //   Navigator.pop(context);

  //   await firebaseAuth.currentUser!.delete();
  // }

  void loginUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential cred = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      // _user = cred.user;
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   CupertinoPageRoute(builder: (context) => const HomePage()),
      //   (Route route) => false,
      // );
      notifyListeners();
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  void registerUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      //save out user to auth and firebase firestore
      UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // _user = cred.user;
      Navigator.pop(context);
      notifyListeners();
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  // resetPassword({required String email, required BuildContext context}) {
  //   try {
  //     firebaseAuth.sendPasswordResetEmail(email: email);
  //     const snackbar = SnackBar(
  //       duration: Duration(seconds: 8),
  //       content:
  //           Text("Email sent.Please check Inbox.Don't forgot to check spam"),
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(snackbar);
  //     Navigator.pushNamed(context, '/SignInScreen');
  //   } catch (e) {
  //     final snackbar = SnackBar(content: Text(e.toString()));
  //     ScaffoldMessenger.of(context).showSnackBar(snackbar);
  //   }
  // }
}
