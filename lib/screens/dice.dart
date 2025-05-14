import 'package:dice_roller/screens/score.dart';
import 'package:dice_roller/screens/settings.dart';
import 'package:dice_roller/widgets/dice.dart';
import 'package:flutter/material.dart';

class DiceScreen extends StatefulWidget {
  const DiceScreen({super.key});

  @override
  State<DiceScreen> createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> {
  final List<GlobalKey<DiceState>> _diceKeys = List.generate(
    6,
    (_) => GlobalKey<DiceState>(),
  );

  int diceCount = 6; // Can be changed by user in Settings later

  void _navigateToSettings(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => const SettingsScreen()));
  }

  void _navigateToScore(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => const ScoreScreen()));
  }

  void _rollAllDice() {
    for (int i = 0; i < diceCount; i++) {
      _diceKeys[i].currentState?.rollDice();
    }
  }

  double getDiceSize(double width, int count) {
    int dicePerRow = (width / 140).floor().clamp(1, 3);
    double spacing = 20 * (dicePerRow + 1);
    return ((width - spacing) / dicePerRow).clamp(60, 160);
  }

  Widget _buildResponsiveDiceLayout(double width) {
    double diceSize = getDiceSize(width, diceCount);
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 20,
      runSpacing: 20,
      children: List.generate(
        diceCount,
        (i) => Dice(key: _diceKeys[i], size: diceSize),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;

    const Color primaryBackgroundColor = Color(0xFFBCA8FF);

    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Top UI: Score & Icons
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.history,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () => _navigateToScore(context),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () => _navigateToSettings(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10.0,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFCEC0FF),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: const Text(
                          'Your Score: 1',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Responsive Dice Layout
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: _buildResponsiveDiceLayout(width),
                  ),
                ),
              ),

              // Bottom Roll Button
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton.icon(
                      onPressed: _rollAllDice,
                      icon: const Icon(
                        Icons.rocket_launch,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Roll',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9C82FF),
                        padding: const EdgeInsets.symmetric(
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
