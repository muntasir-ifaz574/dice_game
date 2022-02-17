import 'package:dice_game/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class Dice extends StatefulWidget {
  Dice({Key? key}) : super(key: key);

  StateMachineController? _controller;
  Artboard? _riveArtboard;
  SMIInput<double>? _numInput;

  Future<double> play() async {
    double num;
    _numInput!.value = 0;
    await Future.delayed(Duration(seconds: 3)).then((value) {});
    num = getRandomNumber();
    _numInput!.value = num;
    return num;
  }

  @override
  _DiceState createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  @override
  void initState() {
    rootBundle.load("assets/dice.riv").then((ByteData data) {
      RiveFile file = RiveFile.import(data);
      Artboard artboard = file.mainArtboard;
      widget._controller =
          StateMachineController.fromArtboard(artboard, "State");
      artboard.addController(widget._controller!);
      widget._numInput = widget._controller!.findInput("num");
      setState(() {
        widget._riveArtboard = artboard;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget._riveArtboard == null
        ? SizedBox()
        : SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 1.5,
            child: Rive(
              artboard: widget._riveArtboard!,
            ),
          );
  }
}
