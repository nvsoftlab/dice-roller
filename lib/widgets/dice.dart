// lib/widgets/dice.dart
import 'dart:math';
import 'package:flutter/material.dart';

enum DiceType { d6, d6Classic, d10 }

class Dice extends StatefulWidget {
  // If you need to pass any initial parameters, define them here
  final double size;
  final DiceType type;
  const Dice({super.key, this.size = 150.0, this.type = DiceType.d6Classic});

  @override
  // Make the State class public so DiceScreen can use a GlobalKey with it
  State<Dice> createState() => DiceState();
}

// Renamed from _DiceState to DiceState (or keep private and use GlobalKey<_DiceState>)
// For simplicity in cross-file key usage if DiceScreen were in a different library,
// making it public is easier. For same-library, _DiceState with GlobalKey<_DiceState> is fine.
// Let's assume for now _DiceState is okay as they are in the same package.
class DiceState extends State<Dice> with SingleTickerProviderStateMixin {
  int _currentDiceFace = 1;
  // _diceCount and its related UI/logic seem to be from a previous version
  // and are not currently controlled by DiceScreen. Removing for clarity.
  // If needed, this can be added back as a parameter or internal state.

  final Random _random = Random();

  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  int _finalDiceFace = 1;

  bool _isRolling = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 1.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCubic,
      ),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _currentDiceFace = _finalDiceFace;
          _isRolling = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  int _generateRandomFaceValueForType(DiceType type) {
    switch (type) {
      case DiceType.d6Classic:
      case DiceType.d6:
        return _random.nextInt(6) + 1;
      case DiceType.d10:
        return _random.nextInt(10) + 1;
    }
  }

  // Make this method public to be called from DiceScreen via GlobalKey
  void rollDice() {
    // Renamed from _rollDice
    if (_isRolling) return;
    _finalDiceFace = _generateRandomFaceValueForType(widget.type);
    setState(() {
      _isRolling = true;
      _currentDiceFace = _generateRandomFaceValueForType(widget.type);
    });

    _animationController.forward(from: 0.0);
    print(
      'Dice rolling (from Dice widget)... interim: $_currentDiceFace, final: $_finalDiceFace',
    );
  }

  Widget _buildPip({double? size}) {
    size ??= widget.size * 0.12;
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildDiceFace(int value) {
    switch (widget.type) {
      case DiceType.d6Classic:
        return _buildClassicDiceFace(value);
      case DiceType.d6:
      case DiceType.d10:
        return _buildNumericDiceFace(value);
      default:
        return _buildClassicDiceFace(value); // Fallback
    }
  }

  Widget _buildClassicDiceFace(int value) {
    final double pipPadding = widget.size * 0.1;
    List<Widget> pips = [];
    switch (value) {
      case 1:
        pips = [Align(alignment: Alignment.center, child: _buildPip())];
        break;
      case 2:
        pips = [
          Align(alignment: Alignment.topLeft, child: _buildPip()),
          Align(alignment: Alignment.bottomRight, child: _buildPip()),
        ];
        break;
      case 3:
        pips = [
          Align(alignment: Alignment.topLeft, child: _buildPip()),
          Align(alignment: Alignment.center, child: _buildPip()),
          Align(alignment: Alignment.bottomRight, child: _buildPip()),
        ];
        break;
      case 4:
        pips = [
          Align(alignment: Alignment.topLeft, child: _buildPip()),
          Align(alignment: Alignment.topRight, child: _buildPip()),
          Align(alignment: Alignment.bottomLeft, child: _buildPip()),
          Align(alignment: Alignment.bottomRight, child: _buildPip()),
        ];
        break;
      case 5:
        pips = [
          Align(alignment: Alignment.topLeft, child: _buildPip()),
          Align(alignment: Alignment.topRight, child: _buildPip()),
          Align(alignment: Alignment.center, child: _buildPip()),
          Align(alignment: Alignment.bottomLeft, child: _buildPip()),
          Align(alignment: Alignment.bottomRight, child: _buildPip()),
        ];
        break;
      case 6:
        pips = [
          Align(alignment: Alignment.topLeft, child: _buildPip()),
          Align(alignment: Alignment.topRight, child: _buildPip()),
          Align(alignment: Alignment.centerLeft, child: _buildPip()),
          Align(alignment: Alignment.centerRight, child: _buildPip()),
          Align(alignment: Alignment.bottomLeft, child: _buildPip()),
          Align(alignment: Alignment.bottomRight, child: _buildPip()),
        ];
        break;
      default:
        pips = [Align(alignment: Alignment.center, child: _buildPip())];
    }
    return Padding(
      padding: EdgeInsets.all(pipPadding),
      child: Stack(children: pips),
    );
  }

  Widget _buildNumericDiceFace(int value) {
    String valueString = value.toString();
    List<Widget> digitWidgets = [];

    for (int i = 0; i < valueString.length; i++) {
      digitWidgets.add(
        Text(
          valueString[i],
          style: TextStyle(
            fontSize: widget.size * 0.4,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      );
    }

    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      children: digitWidgets,
    );

    // Apply rotation only when the dice is NOT rolling (final state)
    if (!_isRolling) {
      content = RotatedBox(
        quarterTurns: 2, // Rotate 180 degrees to flip the numbers
        child: content,
      );
    }

    return Center(child: content);
  }

  @override
  Widget build(BuildContext context) {
    // This widget now ONLY returns the visual representation of the dice.
    // No SafeArea, no outer Column, no Expanded here.
    // The parent (DiceScreen) will handle its placement and sizing.
    return RotationTransition(
      turns: _rotationAnimation,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: _buildDiceFace(_currentDiceFace),
      ),
    );
  }

  // Removed _buildTopButton and _buildCircularButton as they are not used
  // by this simplified widget. If DiceScreen needs similar buttons,
  // it should define them or use a common widget library.
}
