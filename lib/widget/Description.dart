import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gameapp/models/MyGame.dart';

class DescriptionWd extends StatefulWidget {
  final MyGame game;
  const DescriptionWd({super.key, required this.game});

  @override
  State<DescriptionWd> createState() => _DescriptionWdState();
}

class _DescriptionWdState extends State<DescriptionWd> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11),
      child: Container(
        child: Text(
          widget.game.description,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
