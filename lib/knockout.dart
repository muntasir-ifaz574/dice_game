import 'package:dice_game/dice.dart';
import 'package:flutter/material.dart';

TextStyle textStyle = TextStyle(
  color: Color(0xFFF5F2EC),
  fontWeight: FontWeight.bold,
  fontSize: 18,
);
Color text = Colors.black;

class knocKoutGame extends StatefulWidget {
  const knocKoutGame({Key? key}) : super(key: key);

  @override
  _knocKoutGameState createState() => _knocKoutGameState();
}

class _knocKoutGameState extends State<knocKoutGame> {
  Dice? dice1;
  Dice? dice2;
  double _palyerScore = 0;
  double _machineScore = 0;
  String _turn = "";
  String _recentPlsc = "";
  String _recentMachinesc = "";
  String _winnig = "";
  bool _running = false;

  void showMessage(BuildContext context, String notification) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          height: 200,
          child: Text(
            notification,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: text,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    dice1 = Dice();
    dice2 = Dice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E94C7),
      appBar: AppBar(
        backgroundColor: Color(0xFF78EBA),
        centerTitle: true,
        title: Text(
          "Knock Out Game",
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 2.5,
                child: dice1,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 2.5,
                child: dice2,
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              _turn,
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Player",
                style: textStyle,
              ),
              Text(
                "Machine",
                style: textStyle,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                child: Text(
                  _recentPlsc,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                child: Text(
                  _recentMachinesc,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "$_palyerScore",
                style: textStyle,
              ),
              Text(
                "$_machineScore",
                style: textStyle,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                color: Color(0xFF71B8F5),
                onPressed: _running
                    ? null
                    : () async {
                        setState(() {
                          _running = true;
                        });
                        setState(() {
                          _turn = "Player Dice Rolling";
                        });
                        double playerResult =
                            await dice1!.play() + await dice2!.play();
                        setState(() {
                          _recentPlsc = "Recent : $playerResult";
                        });
                        if (playerResult == 7) playerResult = 0;
                        await Future.delayed(
                          Duration(
                            seconds: 2,
                          ),
                        );
                        setState(() {
                          _turn = "Machine Dice Rolling";
                        });
                        double mnResult =
                            await dice1!.play() + await dice2!.play();
                        setState(() {
                          _recentMachinesc = "Recent : $mnResult";
                        });
                        if (mnResult == 7) mnResult = 0;
                        setState(() {
                          _palyerScore += playerResult;
                          _machineScore += mnResult;
                        });
                        setState(() {
                          _turn = " ";
                        });
                        if (_machineScore >= 50 || _palyerScore >= 50) {
                          if (_machineScore > _palyerScore) {
                            setState(() {
                              _winnig = "You lose";
                            });
                          } else if (_machineScore == _palyerScore) {
                            setState(() {
                              _winnig = "Draw Match";
                            });
                          } else {
                            setState(() {
                              _winnig = "You Won";
                            });
                          }
                          showMessage(context, _winnig);
                          _machineScore = 0;
                          _palyerScore = 0;
                        }
                        setState(() {
                          _running = false;
                        });
                      },
                child: Text(
                  "Play",
                  style: textStyle,
                ),
              ),
              MaterialButton(
                color: Color(0xFF71B8F5),
                onPressed: () {
                  setState(() {
                    _machineScore = 0;
                    _palyerScore = 0;
                  });
                },
                child: Text(
                  "Restart",
                  style: textStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
