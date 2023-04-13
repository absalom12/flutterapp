import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gameapp/common/CheckAuth.dart';
import 'package:gameapp/firebase_options.dart';
import 'package:gameapp/models/MyGame.dart';
import 'package:gameapp/screens/ForgetScreen.dart';
import 'package:gameapp/screens/GameDetails.dart';
import 'package:gameapp/screens/LoginScreen.dart';
import 'package:gameapp/screens/MyFavScreen.dart';
import 'package:gameapp/screens/MyWishScreen.dart';
import 'package:gameapp/screens/RegisterScreen.dart';
import 'package:gameapp/screens/WelcomeScreen.dart';
import 'package:gameapp/services/GameServices.dart';
import 'package:gameapp/services/LikeServices.dart';
import 'package:gameapp/widget/MyLikeEmpty.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: AnimatedSplashScreen(
        splash: new Image.asset('assets/images/applogo.png',
            height: 200, width: 200),
        nextScreen: CheckAuth(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white,
        duration: 3000,
      ),
    );
  }
}
