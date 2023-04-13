import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gameapp/screens/WelcomeScreen.dart';
import 'package:get/get.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final toast = FToast();

class AuthenticationServices {
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      print(user!.email.toString());
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      toast.showToast(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.green,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check),
              SizedBox(
                width: 12.0,
              ),
              Text("Connexion réussie !"),
            ],
          ),
        ),
      );
      Get.off(WelcomeScreen());
    } catch (e) {
      toast.showToast(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.red,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error),
              SizedBox(
                width: 12.0,
              ),
              Text("Mot de passe ou email incorrect !"),
            ],
          ),
        ),
      );
      return null;
    }
  }

  Future<void> addUser(String email, String password, String username) async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = _auth.currentUser;
      if (user != null) {
        final String? uid = user.uid;

        await FirebaseFirestore.instance.collection('users').doc(email).set({
          'email': email,
          'password': password,
          'username': username,
          'uid': uid,

          // Add any other user data here
        });
        toast.showToast(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.green,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check),
                SizedBox(
                  width: 12.0,
                ),
                Text("Utilisateur ajouté !"),
              ],
            ),
          ),
        );
      }
    } catch (e) {
      toast.showToast(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.red,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error),
              SizedBox(
                width: 12.0,
              ),
              Text("Veuillez remplir tous les champs !"),
            ],
          ),
        ),
      );
      return null;
    }
  }
}
