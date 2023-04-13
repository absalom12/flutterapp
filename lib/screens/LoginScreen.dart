import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gameapp/screens/ForgetScreen.dart';
import 'package:gameapp/screens/RegisterScreen.dart';
import 'package:gameapp/services/AuthServices.dart';
import 'package:gameapp/services/GameServices.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final toast = FToast();
  @override
  void initState() {
    super.initState();
    toast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Get.to(() => ForgetScreen());
        },
        child: Container(
            height: 50,
            alignment: Alignment.center,
            child: Text(
              "Mot de passe oublié",
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.white,
                fontSize: 15,
              ),
            )),
      ),
      backgroundColor: Color.fromRGBO(26, 32, 37, 1),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/bg.png',
                fit: BoxFit.cover,
              ),
            ),
            Column(children: [
              Padding(
                padding: EdgeInsets.only(top: 120, right: 20, left: 20),
                child: Container(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Text(
                        "Bienvenue !",
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        width: 180,
                        height: 80,
                        child: Text(
                          "Veuillez vous connecter ou créer un nouveau compte pour utiliser l'application",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 6.0),
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
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
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
                        Icons.lock,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: TextFormField(
                          obscureText: true,
                          controller: password,
                          decoration: InputDecoration(
                            hintText: 'Password',
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
              SizedBox(height: 50.0),
              Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: Container(
                  width: 390,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(99, 106, 246, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextButton(
                    onPressed: () {
                      AuthenticationServices().signInWithEmailAndPassword(
                          email.text, password.text);
                    },
                    child: Text(
                      'Se connecter',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: Container(
                  width: 390,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Color.fromRGBO(99, 106, 246, 1),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()),
                      );
                    },
                    child: Text('Créer un nouveau compte',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
