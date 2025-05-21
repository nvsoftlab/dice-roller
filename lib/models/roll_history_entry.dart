import 'package:dice_roller/models/dice_type.dart';

class IndividualDieRoll {
  final DiceType type;
  final int value;

  IndividualDieRoll({required this.type, required this.value});

  Map<String, dynamic> toJson() => {'type': type.toJson(), 'value': value};

  factory IndividualDieRoll.fromJson(Map<String, dynamic> json) =>
      IndividualDieRoll(
        type: DiceType.fromJson(json['type'] as String),
        value: json['value'] as int,
      );
}

class RollHistoryEntry {
  final DateTime timestamp;
  final int totalScore;
  final List<IndividualDieRoll> individualRolls;

  RollHistoryEntry({
    required this.timestamp,
    required this.totalScore,
    required this.individualRolls,
  });

  factory RollHistoryEntry.fromJson(Map<String, dynamic> json) {
    List<IndividualDieRoll> parsedRolls = [];
    if (json['individualRolls'] != null && json['individualRolls'] is List) {
      var rollsList = json['individualRolls'] as List;
      parsedRolls =
          rollsList
              .map((item) {
                if (item is Map<String, dynamic>) {
                  return IndividualDieRoll.fromJson(item);
                }
                return null;
              })
              .whereType<IndividualDieRoll>()
              .toList();
    }

    return RollHistoryEntry(
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int),
      totalScore: json['totalScore'] as int,
      individualRolls: parsedRolls,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.millisecondsSinceEpoch,
      'totalScore': totalScore,
      'individualRolls': individualRolls.map((roll) => roll.toJson()).toList(),
    };
  }
}
