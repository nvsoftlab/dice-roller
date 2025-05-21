import 'package:flutter/material.dart';

import 'package:dice_roller/models/dice_type.dart';

class MiniDiceWidget extends StatelessWidget {
  final DiceType type;
  final int value;
  final double size;

  const MiniDiceWidget({
    super.key,
    required this.type,
    required this.value,
    this.size = 40.0,
  });

  Widget _buildPip({double? pipSize, Color color = Colors.black}) {
    pipSize ??= size * 0.18;
    return Container(
      width: pipSize,
      height: pipSize,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _buildClassicDiceFace(BuildContext context) {
    final double pipPadding = size * 0.1;
    final Color pipColor =
        Theme.of(context).brightness == Brightness.dark
            ? Colors.white70
            : Colors.black87;

    List<Widget> pips = [];
    switch (value) {
      case 1:
        pips = [
          Align(alignment: Alignment.center, child: _buildPip(color: pipColor)),
        ];
        break;
      case 2:
        pips = [
          Align(
            alignment: Alignment.topLeft,
            child: _buildPip(color: pipColor),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: _buildPip(color: pipColor),
          ),
        ];
        break;
      case 3:
        pips = [
          Align(
            alignment: Alignment.topLeft,
            child: _buildPip(color: pipColor),
          ),
          Align(alignment: Alignment.center, child: _buildPip(color: pipColor)),
          Align(
            alignment: Alignment.bottomRight,
            child: _buildPip(color: pipColor),
          ),
        ];
        break;
      case 4:
        pips = [
          Align(
            alignment: Alignment.topLeft,
            child: _buildPip(color: pipColor),
          ),
          Align(
            alignment: Alignment.topRight,
            child: _buildPip(color: pipColor),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: _buildPip(color: pipColor),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: _buildPip(color: pipColor),
          ),
        ];
        break;
      case 5:
        pips = [
          Align(
            alignment: Alignment.topLeft,
            child: _buildPip(color: pipColor),
          ),
          Align(
            alignment: Alignment.topRight,
            child: _buildPip(color: pipColor),
          ),
          Align(alignment: Alignment.center, child: _buildPip(color: pipColor)),
          Align(
            alignment: Alignment.bottomLeft,
            child: _buildPip(color: pipColor),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: _buildPip(color: pipColor),
          ),
        ];
        break;
      case 6:
        pips = [
          Align(
            alignment: Alignment.topLeft,
            child: _buildPip(color: pipColor),
          ),
          Align(
            alignment: Alignment.topRight,
            child: _buildPip(color: pipColor),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: _buildPip(color: pipColor),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: _buildPip(color: pipColor),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: _buildPip(color: pipColor),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: _buildPip(color: pipColor),
          ),
        ];
        break;
      default:
        pips = [
          Align(alignment: Alignment.center, child: _buildPip(color: pipColor)),
        ];
    }
    return Padding(
      padding: EdgeInsets.all(pipPadding),
      child: Stack(children: pips),
    );
  }

  Widget _buildNumericDiceFace(BuildContext context) {
    return Center(
      child: Text(
        value.toString(),
        style: TextStyle(
          fontSize: size * 0.5,
          fontWeight: FontWeight.bold,
          color:
              Theme.of(context).brightness == Brightness.dark
                  ? Colors.white70
                  : Colors.black87,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,

        borderRadius: BorderRadius.circular(size * 0.1),
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 0.5,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child:
          type == DiceType.d6Classic
              ? _buildClassicDiceFace(context)
              : _buildNumericDiceFace(context),
    );
  }
}
