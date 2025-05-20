import 'dart:async';
import 'dart:math';
import 'package:dice_roller/widgets/dice/dice_grid_view.dart';
import 'package:dice_roller/widgets/dice/dice_screen_header.dart';
import 'package:dice_roller/widgets/dice/roll_dice_button.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dice_roller/constants/settings.dart';
import 'package:dice_roller/constants/shared_preferences_indexes.dart';

import 'package:dice_roller/models/dice_type.dart';
import 'package:dice_roller/screens/score.dart';
import 'package:dice_roller/screens/settings.dart';
import 'package:dice_roller/widgets/dice.dart';

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

  int diceCount = kInitialDiceCount;
  List<DiceType>? diceTypes;
  bool _isShaking = false;
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  bool _isScreenVisible =
      true; // Manages accelerometer listener based on screen visibility
  Color _backgroundColor =
      kColors.isNotEmpty ? kColors[0] : const Color(0xFFBCA8FF);

  @override
  void initState() {
    super.initState();
    _loadBackgroundColor();
    _loadDiceSettings().then((_) {
      // Ensure diceKeys list is correctly sized after loading settings
      _updateDiceKeys();
    });
    _startAccelerometerListener();
  }

  Future<void> _loadBackgroundColor() async {
    final preferences = await SharedPreferences.getInstance();
    if (!mounted) return;

    final int colorIndex = preferences.getInt(selectedColorIndexKey) ?? 0;

    if (kColors.isNotEmpty && colorIndex >= 0 && colorIndex < kColors.length) {
      if (_backgroundColor != kColors[colorIndex]) {
        setState(() {
          _backgroundColor = kColors[colorIndex];
        });
      }
    }
  }

  Future<void> _loadDiceSettings() async {
    final preferences = await SharedPreferences.getInstance();
    if (!mounted) return;

    final List<String>? diceTypeStrings = preferences.getStringList(
      diceTypesKey,
    );

    setState(() {
      diceCount = diceTypeStrings?.length ?? kInitialDiceCount;
      if (diceTypeStrings != null) {
        diceTypes =
            diceTypeStrings.map((str) => DiceType.fromString(str)).toList();
      } else {
        diceTypes = List.generate(diceCount, (index) => DiceType.d6Classic);
      }
    });
  }

  void _updateDiceKeys() {
    if (_diceKeys.length != diceCount) {
      setState(() {
        // This rebuilds the keys list to match the actual dice count
        // Important if diceCount can change dynamically
        _diceKeys.clear();
        for (int i = 0; i < diceCount; i++) {
          _diceKeys.add(GlobalKey<DiceState>());
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ModalRoute? route = ModalRoute.of(context);
    final bool isCurrentlyVisible = route?.isCurrent ?? false;

    if (isCurrentlyVisible && !_isScreenVisible) {
      // Screen became visible
      _loadBackgroundColor();
      _loadDiceSettings().then((_) => _updateDiceKeys());
      _startAccelerometerListener();
      _isScreenVisible = true;
    } else if (!isCurrentlyVisible && _isScreenVisible) {
      // Screen became hidden
      _accelerometerSubscription?.cancel();
      _accelerometerSubscription = null; // Allow re-subscription
      _isScreenVisible = false;
    }
  }

  void _startAccelerometerListener() {
    // Only start if not already listening and screen is visible
    if (_accelerometerSubscription == null && _isScreenVisible) {
      accelerometerEventStream()
          .listen((AccelerometerEvent? event) {
            if (event != null && mounted) {
              // Check mounted before setState
              final double x = event.x;
              final double y = event.y;
              final double z = event.z;
              final double acceleration = sqrt(x * x + y * y + z * z);

              if (acceleration > 50 && !_isShaking) {
                // Threshold from original code
                setState(() {
                  _isShaking = true;
                });
                _rollAllDice();
                Future.delayed(const Duration(milliseconds: 500), () {
                  if (mounted) {
                    // Check mounted before setState in delayed future
                    setState(() {
                      _isShaking = false;
                    });
                  }
                });
              }
            }
          })
          .onDone(() {
            // Handle if the stream is closed unexpectedly, maybe try to restart
            if (mounted && _isScreenVisible) {
              _accelerometerSubscription =
                  null; // Reset to allow re-subscription
              _startAccelerometerListener();
            }
          });
    }
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  void _navigateToSettings(BuildContext context) async {
    // Optionally pause accelerometer before navigating
    _accelerometerSubscription?.pause();
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => const SettingsScreen()));

    if (mounted) {
      _loadBackgroundColor();
      _loadDiceSettings().then((_) => _updateDiceKeys());
      // Optionally resume accelerometer if it was paused
      if (_isScreenVisible &&
          _accelerometerSubscription != null &&
          _accelerometerSubscription!.isPaused) {
        _accelerometerSubscription!.resume();
      } else if (_isScreenVisible) {
        // If it was cancelled and nulled (e.g. by didChangeDependencies)
        _startAccelerometerListener();
      }
    }
  }

  void _navigateToScore(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => const ScoreScreen()));
  }

  void _rollAllDice() {
    for (int i = 0; i < diceCount; i++) {
      if (i < _diceKeys.length && _diceKeys[i].currentState != null) {
        _diceKeys[i].currentState?.rollDice();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width;

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              DiceScreenHeader(
                onScorePressed: () => _navigateToScore(context),
                onSettingsPressed: () => _navigateToSettings(context),
                backgroundColor: _backgroundColor,
                // currentScore: yourActualScoreVariable, // You'll need to manage this state
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: DiceGridView(
                      diceCount: diceCount,
                      diceTypes: diceTypes,
                      diceKeys: _diceKeys,
                      availableWidth: width - 40,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: RollDiceButton(
                  onRoll: _rollAllDice,
                  backgroundColor: _backgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
