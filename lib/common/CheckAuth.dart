
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gameapp/screens/LoginScreen.dart';
import 'package:gameapp/screens/WelcomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isAuth = false;
  bool isFound = false;
  bool? _jailbroken;
  bool? _developerMode;

  @override
  void initState() {
    super.initState();
    if (isFound == false) {
      checkCurrentUser();
    }
  }

  void checkCurrentUser() async {
    User? user = _auth.currentUser;
    if (user != null) {
      // Navigate to the home page if the user is already logged in
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      child = WelcomeScreen();
    } else {
      child = LoginScreen();
    }
    return Scaffold(
      body: child,
    );
  }
}
