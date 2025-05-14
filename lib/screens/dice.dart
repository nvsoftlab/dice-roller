// lib/screens/dice.dart
import 'package:dice_roller/screens/score.dart';
import 'package:dice_roller/screens/settings.dart';
import 'package:dice_roller/widgets/dice.dart'; // Correct import
import 'package:flutter/material.dart';

class DiceScreen extends StatelessWidget {
  DiceScreen({super.key}); // Removed const as GlobalKey is not const

  // Create a GlobalKey to access the DiceState
  final GlobalKey<DiceState> _diceKey = GlobalKey<DiceState>();

  void _navigateToSettings(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => SettingsScreen()));
  }

  void _navigateToScore(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => ScoreScreen()));
  }

  @override
  Widget build(BuildContext context) {
    Color primaryBackgroundColor = Color(0xFFBCA8FF);

    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // This will center Dice()
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.history, color: Colors.white, size: 30),
                    onPressed: () {
                      _navigateToScore(context);
                    },
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFCEC0FF),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Text(
                      // TODO: Make score dynamic
                      'Your Score: 1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.settings, color: Colors.white, size: 30),
                    onPressed: () {
                      _navigateToSettings(context);
                    },
                  ),
                ],
              ),

              // Use the Dice widget and assign the key
              Dice(
                key: _diceKey,
              ), // The Dice widget will now take its intrinsic size (150x150)

              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton.icon(
                      onPressed: () {
                        // Call the rollDice method on the Dice widget's state
                        _diceKey.currentState?.rollDice();
                        print('Roll pressed (from DiceScreen)');
                      },
                      icon: Icon(Icons.rocket_launch, color: Colors.white),
                      label: Text(
                        'Roll',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF9C82FF),
                        padding: EdgeInsets.symmetric(
                          horizontal: 35.0,
                          vertical: 15.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        elevation: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
