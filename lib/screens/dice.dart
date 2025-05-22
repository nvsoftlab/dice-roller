import 'dart:async';
import 'dart:math';
import 'dart:convert';
import 'package:dice_roller/widgets/dice/dice_grid_view.dart';
import 'package:dice_roller/widgets/dice/dice_screen_header.dart';
import 'package:dice_roller/widgets/dice/roll_dice_button.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dice_roller/constants/settings.dart';
import 'package:dice_roller/constants/shared_preferences_indexes.dart';

import 'package:dice_roller/models/roll_history_entry.dart';
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
  int diceCount = kInitialDiceCount;
  final List<GlobalKey<DiceState>> _diceKeys = List.generate(
    kInitialDiceCount,
    (_) => GlobalKey<DiceState>(),
  );
  List<DiceType> diceTypes = List.generate(
    kInitialDiceCount,
    (_) => DiceType.d6Classic,
  );
  bool _isShaking = false;
  bool _isRollingDice = false; // Flag to prevent concurrent roll operations
  int _currentTotalScore = kInitialDiceCount;
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  bool _isScreenVisible =
      true; // Manages accelerometer listener based on screen visibility
  Color _backgroundColor =
      kColors.isNotEmpty ? kColors[0] : const Color(0xFFBCA8FF);

  @override
  void initState() {
    super.initState();
    _reloadDataAndUpdateState();
    _startAccelerometerListener();
  }

  Future<void> _reloadDataAndUpdateState() async {
    final preferences = await SharedPreferences.getInstance();
    if (!mounted) return;

    // --- Load Background Color ---
    final int colorIndex = preferences.getInt(selectedColorIndexKey) ?? 0;
    Color newBackgroundColor = _backgroundColor;
    if (kColors.isNotEmpty && colorIndex >= 0 && colorIndex < kColors.length) {
      newBackgroundColor = kColors[colorIndex];
    }

    // --- Load Dice Settings ---
    final List<String>? diceTypeStrings = preferences.getStringList(
      diceTypesKey,
    );
    int newDiceCount;
    List<DiceType> newDiceTypes;

    if (diceTypeStrings != null && diceTypeStrings.isNotEmpty) {
      newDiceCount = diceTypeStrings.length;
      newDiceTypes =
          diceTypeStrings.map((str) => DiceType.fromString(str)).toList();
    } else {
      newDiceCount = kInitialDiceCount;
      newDiceTypes = List.generate(newDiceCount, (_) => DiceType.d6Classic);
    }

    int newTotalScore = _currentTotalScore;
    if (diceCount != newDiceCount) {
      newTotalScore = newDiceCount; // Each new/reconfigured die starts at 1
    }

    // --- Update State ---
    setState(() {
      _backgroundColor = newBackgroundColor;
      diceCount = newDiceCount;
      diceTypes = newDiceTypes;

      // Update dice keys only if the count has changed
      if (_diceKeys.length != newDiceCount) {
        _diceKeys.clear();
        _diceKeys.addAll(
          List.generate(newDiceCount, (_) => GlobalKey<DiceState>()),
        );
      }
      _currentTotalScore = newTotalScore;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ModalRoute? route = ModalRoute.of(context);
    final bool isCurrentlyVisible = route?.isCurrent ?? false;

    if (isCurrentlyVisible && !_isScreenVisible) {
      // Screen became visible
      _isScreenVisible = true;
      _reloadDataAndUpdateState(); // Reload settings and update state
      _startAccelerometerListener();
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
      _accelerometerSubscription = accelerometerEventStream().listen(
        (AccelerometerEvent? event) {
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
              Future.delayed(const Duration(milliseconds: 400), () {
                if (mounted) {
                  // Check mounted before setState in delayed future
                  setState(() {
                    _isShaking = false;
                  });
                }
              });
            }
          }
        },
        onError: (error) {
          if (mounted && _isScreenVisible) {
            _accelerometerSubscription?.cancel();
            _accelerometerSubscription = null;
            _startAccelerometerListener();
          }
        },
        onDone: () {
          if (mounted && _isScreenVisible) {
            _accelerometerSubscription = null;
            _startAccelerometerListener();
          }
        },
      );
    }
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  void _navigateToSettings(BuildContext context) async {
    await _accelerometerSubscription?.cancel();
    _accelerometerSubscription = null;
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => const SettingsScreen()));

    if (mounted) {
      await _reloadDataAndUpdateState();
      if (_isScreenVisible) {
        _startAccelerometerListener();
      }
    }
  }

  void _navigateToScore(BuildContext context) async {
    await _accelerometerSubscription?.cancel();
    _accelerometerSubscription = null;
    final preferences = await SharedPreferences.getInstance();
    final List<String> historyJsonStrings =
        preferences.getStringList(rollHistoryKey) ?? [];
    final List<RollHistoryEntry> rollHistory =
        historyJsonStrings
            .map((jsonString) {
              try {
                return RollHistoryEntry.fromJson(
                  json.decode(jsonString) as Map<String, dynamic>,
                );
              } catch (e) {
                // Handle potential parsing errors, e.g., if old format data exists
                return null; // Or a default/error entry
              }
            })
            .whereType<RollHistoryEntry>()
            .toList(); // Filter out nulls if any errors occurred

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ScoreScreen(rollHistory: rollHistory),
      ),
    );

    if (mounted) {
      await _reloadDataAndUpdateState();
      if (_isScreenVisible) {
        _startAccelerometerListener();
      }
    }
  }

  void _rollAllDice() async {
    // Prevent new roll if already shaking OR if a roll operation is in progress
    if (_isRollingDice) return;

    setState(() {
      _isRollingDice = true;
    });

    try {
      List<Future<int>> rollFutures = [];
      List<DiceType> currentDiceTypesForRoll = [];

      for (int i = 0; i < diceCount; i++) {
        if (i < _diceKeys.length && _diceKeys[i].currentState != null) {
          rollFutures.add(_diceKeys[i].currentState!.rollDice());
          // Store the type of the die being rolled
          currentDiceTypesForRoll.add(_diceKeys[i].currentState!.widget.type);
        }
      }

      List<int> rolledValues = await Future.wait(rollFutures);
      int newScore = rolledValues.fold(0, (sum, value) => sum + value);
      _updateTotalScore(newScore);

      // Create list of IndividualDieRoll objects
      List<IndividualDieRoll> individualRolls = [];
      for (int i = 0; i < rolledValues.length; i++) {
        individualRolls.add(
          IndividualDieRoll(
            type: currentDiceTypesForRoll[i],
            value: rolledValues[i],
          ),
        );
      }

      // Create and save RollHistoryEntry
      final newEntry = RollHistoryEntry(
        timestamp: DateTime.now(),
        totalScore: newScore,
        individualRolls: individualRolls,
      );

      final preferences = await SharedPreferences.getInstance();
      List<String> historyJsonStrings =
          preferences.getStringList(rollHistoryKey) ?? [];
      historyJsonStrings.insert(
        0,
        json.encode(newEntry.toJson()),
      ); // Add new entry as JSON string

      if (historyJsonStrings.length > kMaxScoreHistoryLength) {
        historyJsonStrings = historyJsonStrings.sublist(
          0,
          kMaxScoreHistoryLength,
        );
      }
      await preferences.setStringList(rollHistoryKey, historyJsonStrings);
    } finally {
      if (mounted) {
        setState(() {
          _isRollingDice = false;
        });
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
                currentScore: _currentTotalScore,
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

  void _updateTotalScore(int newScore) {
    setState(() {
      _currentTotalScore = newScore;
    });
  }
}
