import 'package:dice_roller/constants/settings.dart';
import 'package:flutter/material.dart';

class DiceTypeDropdown extends StatelessWidget {
  const DiceTypeDropdown({
    super.key,
    required this.currentValue,
    required this.onChanged,
  });

  final String? currentValue;
  final ValueChanged<String?> onChanged;

  void _showDiceOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      builder: (BuildContext bottomSheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              10,
              10,
              10,
              1 + MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: kDiceTypeOptions.length,
                  itemBuilder: (BuildContext listItemContext, int index) {
                    final String option = kDiceTypeOptions[index];
                    final bool isSelected = (option == currentValue);

                    return ListTile(
                      title: Text(
                        option,
                        style: Theme.of(
                          context,
                        ).textTheme.labelMedium?.copyWith(
                          color:
                              isSelected
                                  ? Theme.of(context).primaryColorDark
                                  : Theme.of(
                                    context,
                                  ).textTheme.labelMedium?.color,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      trailing:
                          isSelected
                              ? Icon(
                                Icons.check,
                                color: Theme.of(context).primaryColorDark,
                              )
                              : null,
                      onTap: () {
                        onChanged(option);
                        Navigator.pop(bottomSheetContext);
                      },
                      selected: isSelected,
                      selectedTileColor: Theme.of(
                        context,
                      ).primaryColorLight.withAlpha(26),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showDiceOptionsBottomSheet(context);
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F4F8),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: const Color(0xFFE0E3E7), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Text(
                currentValue ?? kDiceTypeOptions[0],
                style: Theme.of(context).textTheme.labelMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.keyboard_arrow_down_sharp,
              color: Color(0xFF14181B),
            ),
          ],
        ),
      ),
    );
  }
}
