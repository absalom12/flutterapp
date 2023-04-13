import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gameapp/screens/LoginScreen.dart';
import 'package:get/get.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  TextEditingController email = TextEditingController();
  final toast = FToast();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(26, 32, 37, 1),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Column(children: [
            Padding(
              padding: EdgeInsets.only(top: 130),
              child: Container(
                height: 180,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Mot de passe oublié",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      width: 300,
                      height: 80,
                      child: Text(
                        "Veuillez saisir votre email afin de réinitialiser votre mot de passe",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: Container(
                width: 390,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(30, 38, 44, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 16),
                    Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          hintText: 'E-mail',
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(right: 10, left: 10),
              child: Container(
                width: 390,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(99, 106, 246, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextButton(
                  onPressed: () async {
                    try {
                      final FirebaseAuth _auth = FirebaseAuth.instance;

                      await _auth.sendPasswordResetEmail(email: email.text);

                      toast.showToast(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 12.0),
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
                              Text("Email envoyé avec succès"),
                            ],
                          ),
                        ),
                      );
                      Get.to(LoginScreen());
                      print("Sent Succefssfully");
                      // Password reset email sent successfully
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        toast.showToast(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 12.0),
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
                                Text("Cette adresse email n'existe pas"),
                              ],
                            ),
                          ),
                        );
                      } else {
                        // Some other error occurred
                      }
                    }
                  },
                  child: Text(
                    'Renvoyer mon mot de passe',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
