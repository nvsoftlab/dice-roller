import 'package:dice_roller/models/option.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  const CustomDropdown({
    super.key,
    required this.currentValue,
    required this.onChanged,
    required this.options,
  });

  final T? currentValue;
  final ValueChanged<T?> onChanged;
  final List<Option<T>> options;

  void _showOptionsBottomSheet(BuildContext context) {
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
                  itemCount: options.length,
                  itemBuilder: (BuildContext listItemContext, int index) {
                    final Option<T> option = options[index];
                    final bool isSelected = (option.value == currentValue);

                    return ListTile(
                      title: Text(
                        option.label,
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
                        onChanged(option.value);
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
    Option<T>? currentOption;
    if (currentValue != null) {
      for (final opt in options) {
        if (opt.value == currentValue) {
          currentOption = opt;
          break;
        }
      }
    }

    String displayedText;
    if (currentOption != null) {
      displayedText = currentOption.label;
    } else if (options.isNotEmpty) {
      displayedText = options.first.label;
    } else {
      displayedText = '';
    }

    return InkWell(
      onTap: () => _showOptionsBottomSheet(context),
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
                displayedText,
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
