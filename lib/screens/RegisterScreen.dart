import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gameapp/screens/LoginScreen.dart';
import 'package:gameapp/services/AuthServices.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController passwordValidate = TextEditingController();

  final toast = FToast();
  @override
  void initState() {
    super.initState();
    toast.init(context);
  }

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
          SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 40,
                ),
                child: Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width,
                    height: 30,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Get.to(LoginScreen());
                            },
                            color: Colors.white))),
              ),
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: Container(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Inscription",
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        width: 300,
                        height: 80,
                        child: Text(
                          "Veuillez saisir ces différentes informations, afin que vos listes soient sauvegardées.",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 6.0),
              Container(
                width: 390,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(30, 38, 44, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 16),
                    Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: username,
                        decoration: InputDecoration(
                          hintText: 'Nom d’utilisateur',
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
              SizedBox(height: 16.0),
              Container(
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
                          hintText: 'E-Mail',
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
              SizedBox(height: 16.0),
              Container(
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
                          hintText: 'Mot de passe',
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
              SizedBox(height: 16.0),
              Container(
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
                        controller: passwordValidate,
                        decoration: InputDecoration(
                          hintText: 'Vérification du mot de passe',
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
              SizedBox(height: 50.0),
              Container(
                width: 390,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(99, 106, 246, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextButton(
                  onPressed: () {
                    if (password.text == passwordValidate.text &&
                        username.text != "" &&
                        email.text != "" &&
                        password.text != "" &&
                        passwordValidate.text != "") {
                      AuthenticationServices()
                          .addUser(email.text, password.text, username.text)
                          .then((value) => toast.showToast(
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
                                    Text("Inscription réussie !"),
                                  ],
                                ),
                              ),
                              gravity: ToastGravity.BOTTOM,
                              toastDuration: Duration(seconds: 2)));
                    }
                  },
                  child: Text(
                    'S’inscrire',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
