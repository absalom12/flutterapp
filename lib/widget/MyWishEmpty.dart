import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class MyWishEmpty extends StatelessWidget {
  const MyWishEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 400,
        height: 250,
        color: Color.fromRGBO(26, 32, 37, 1),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Container(child: Image.asset("assets/images/str.png"))),
            SizedBox(height: 20),
            Container(
              width: 300,
              height: 80,
              child: Text(
                "Vous n’avez encore pas liké de contenu.Cliquez sur l’étoile pour en rajouter.",
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ));
  }
}
