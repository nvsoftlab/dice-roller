import 'dart:math';
import 'dart:async'; // Import for Completer
import 'package:flutter/material.dart';
import 'package:dice_roller/models/dice_type.dart';

class Dice extends StatefulWidget {
  const Dice({
    super.key,
    this.size = 150.0,
    required this.type,
    this.onRollComplete,
  });

  final double size;
  final DiceType type;
  final VoidCallback? onRollComplete; // Optional callback

  @override
  State<Dice> createState() => DiceState();
}

class DiceState extends State<Dice> with SingleTickerProviderStateMixin {
  int _currentDiceFace = 1;
  final Random _random = Random();

  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _counterRotationAnimation;
  int _finalDiceFace = 1;
  Completer<int>? _rollCompleter; // Completer to signal roll completion
  bool _isRolling = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Animation for the dice container
    _rotationAnimation = Tween<double>(begin: 0, end: 1.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCubic,
      ),
    );

    // Counter-animation for the numeric text to keep it upright
    // Its 'turns' value will be the negative of _rotationAnimation's 'turns'
    // if both are driven by the same controller and have inverse begin/end factors.
    _counterRotationAnimation = Tween<double>(begin: 0, end: -1.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCubic,
      ),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Complete the completer with the final value
        _rollCompleter?.complete(_finalDiceFace);
        _rollCompleter = null; // Reset completer
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
    return _random.nextInt(type.maxValue) + 1;
  }

  // Modified to return a Future that completes with the final value
  Future<int> rollDice() {
    if (_isRolling) {
      // If already rolling, return the existing future or a new one indicating current state
      // For simplicity, let's just return a future that completes immediately with the current face
      return Future.value(_isRolling ? _currentDiceFace : _finalDiceFace);
    }

    _rollCompleter = Completer<int>(); // Create a new completer
    _finalDiceFace = _generateRandomFaceValueForType(widget.type);
    setState(() {
      _isRolling = true;
      _currentDiceFace = _generateRandomFaceValueForType(widget.type);
    }); // Update state to show interim value and start animation
    _animationController.forward(from: 0.0);
    return _rollCompleter!.future; // Return the future
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
      case DiceType.d6:
      case DiceType.d10:
        return _buildNumericDiceFace(value);
      case DiceType.d6Classic:
        return _buildClassicDiceFace(value);
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

    return Center(
      child: RotationTransition(
        turns: _counterRotationAnimation,
        child: content,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _rotationAnimation,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(widget.size * 0.13),
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
        // Show final face when not rolling, current (interim) when rolling
        child: _buildDiceFace(_isRolling ? _currentDiceFace : _finalDiceFace),
      ),
    );
  }
}
