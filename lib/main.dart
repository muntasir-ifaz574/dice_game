import 'package:dice_game/dice.dart';
import 'package:dice_game/knockout.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const diceGame());
}

class diceGame extends StatelessWidget {
  const diceGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: knocKoutGame(),
    );
  }
}
