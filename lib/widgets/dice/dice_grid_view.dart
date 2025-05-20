import 'package:flutter/material.dart';
import 'package:dice_roller/widgets/dice.dart';
import 'package:dice_roller/models/dice_type.dart';
import 'package:dice_roller/utils/layout_utils.dart';

class DiceGridView extends StatelessWidget {
  final int diceCount;
  final List<DiceType>? diceTypes;
  final List<GlobalKey<DiceState>> diceKeys;
  final double availableWidth;

  const DiceGridView({
    super.key,
    required this.diceCount,
    required this.diceTypes,
    required this.diceKeys,
    required this.availableWidth,
  });

  @override
  Widget build(BuildContext context) {
    double diceSize = LayoutUtils.getDiceSize(availableWidth, diceCount);

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 20,
      runSpacing: 20,
      children: List.generate(
        diceCount,
        (i) => Dice(
          key: diceKeys[i],
          size: diceSize,
          type:
              (diceTypes != null && i < diceTypes!.length)
                  ? diceTypes![i]
                  : DiceType.d6Classic,
        ),
      ),
    );
  }
}
