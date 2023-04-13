import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/MyGame.dart';

class MyAvis extends StatefulWidget {
  final MyGame game;
  const MyAvis({super.key, required this.game});

  @override
  State<MyAvis> createState() => _MyAvisState();
}

class _MyAvisState extends State<MyAvis> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11),
      child: ListView(
        shrinkWrap: true,
        children: [
          widget.game.reviews != null
              ? Padding(
                  padding: MediaQuery.of(context).size.height< 400
                      ? const EdgeInsets.only(left: 10, right: 10)
                      : const EdgeInsets.only(
                          left: 10, right: 10, top:100, bottom: 10),
                  child: Center(
                    child: Container(
                      height: 200,
                      child: Text(
                        "Aucun review n'est disponible !",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(30, 38, 44, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: 390,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Avis",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.game.reviews!.length.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
        ],
      ),
    );
  }
}
