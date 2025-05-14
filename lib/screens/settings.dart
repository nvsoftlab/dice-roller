import 'package:dice_roller/widgets/settings/settings_appearance_section.dart';
import 'package:flutter/material.dart';
import 'package:dice_roller/constants/utils.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _numberOfDices = 4.0;
  String? _dice1Type = 'Select Type';
  String? _dice2Type = 'Select Type';
  String? _dice3Type = 'Select Type';
  String? _dice4Type = 'Select Type';

  bool _soundEffects = true;
  bool _vibration = true;
  bool _keepScreenOn = false;

  Widget _buildSectionTitle(
    String title, {
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 20.0,
    ),
  }) {
    return Padding(
      padding: padding,
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }

  Widget _buildDiceTypeDropdown(
    String? currentValue,
    ValueChanged<String?> onChanged,
  ) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          filled: true,
          fillColor:
              Colors.grey[230], // Slightly different from card for contrast
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
        ),
        value: currentValue,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.black54),
        elevation: 2,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(color: Colors.black87),
        dropdownColor: Colors.white,
        onChanged: onChanged,
        items:
            diceTypeOptions.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                    color:
                        value == 'Select Type'
                            ? Colors.grey[600]
                            : Colors.black87,
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            SettingsAppearanceSection(),
            _buildSectionTitle(
              'Dice Settings',
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            ),
            Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              elevation:
                  0, // Using elevation 0 as per modern design, relying on card color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          'Number of Dices',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const Spacer(),
                        Text(
                          '${_numberOfDices.toInt()}',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: _numberOfDices,
                      min: 1,
                      max: 10,
                      divisions: 9,
                      label: _numberOfDices.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _numberOfDices = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildSettingRow(
                      'Dice 1 Type',
                      _buildDiceTypeDropdown(_dice1Type, (newValue) {
                        setState(() {
                          _dice1Type = newValue;
                        });
                      }),
                    ),
                    const SizedBox(height: 12),
                    _buildSettingRow(
                      'Dice 2 Type',
                      _buildDiceTypeDropdown(_dice2Type, (newValue) {
                        setState(() {
                          _dice2Type = newValue;
                        });
                      }),
                    ),
                    const SizedBox(height: 12),
                    _buildSettingRow(
                      'Dice 3 Type',
                      _buildDiceTypeDropdown(_dice3Type, (newValue) {
                        setState(() {
                          _dice3Type = newValue;
                        });
                      }),
                    ),
                    const SizedBox(height: 12),
                    _buildSettingRow(
                      'Dice 4 Type',
                      _buildDiceTypeDropdown(_dice4Type, (newValue) {
                        setState(() {
                          _dice4Type = newValue;
                        });
                      }),
                    ),
                  ],
                ),
              ),
            ),

            _buildSectionTitle('General'),
            Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 8.0,
                ), // Reduced vertical padding
                child: Column(
                  children: <Widget>[
                    _buildSwitchRow('Sound Effects', _soundEffects, (
                      bool value,
                    ) {
                      setState(() {
                        _soundEffects = value;
                      });
                    }),
                    const Divider(height: 1, indent: 16, endIndent: 16),
                    _buildSwitchRow('Vibration', _vibration, (bool value) {
                      setState(() {
                        _vibration = value;
                      });
                    }),
                    const Divider(height: 1, indent: 16, endIndent: 16),
                    _buildSwitchRow('Keep Screen On', _keepScreenOn, (
                      bool value,
                    ) {
                      setState(() {
                        _keepScreenOn = value;
                      });
                    }),
                  ],
                ),
              ),
            ),
            // Placeholder for the bottom section if needed
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: Text('App Version 1.0.0', style: Theme.of(context).textTheme.labelLarge),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingRow(String title, Widget controlWidget) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0), // Reduced padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            // Ensure title doesn't overflow
            flex: 2,
            child: Text(title, style: Theme.of(context).textTheme.bodyLarge),
          ),
          Expanded(
            // Ensure control has enough space and aligns right
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: controlWidget,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchRow(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Material(
      // Added Material for InkWell splash effect
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onChanged(!value);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 12.0,
          ), // Adjusted padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title, style: Theme.of(context).textTheme.bodyLarge),
              SizedBox(
                height: 24, // Constrain switch height for better alignment
                child: Switch(
                  value: value,
                  onChanged: onChanged,
                  activeColor: Theme.of(
                    context,
                  ).switchTheme.thumbColor?.resolve({WidgetState.selected}),
                  activeTrackColor: Theme.of(
                    context,
                  ).switchTheme.trackColor?.resolve({WidgetState.selected}),
                  inactiveThumbColor: Theme.of(
                    context,
                  ).switchTheme.thumbColor?.resolve({}),
                  inactiveTrackColor: Theme.of(
                    context,
                  ).switchTheme.trackColor?.resolve({}),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
