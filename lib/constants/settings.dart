import 'package:flutter/material.dart';

const List<String> kDiceTypeOptions = [
  'D6Classic',
  'D4',
  'D6',
  'D8',
  'D10',
  'D12',
  'D20',
];

const List<Color> kColors = [
  Color(0xFFA299FE),
  Color(0xFF000000),
  Color(0xFF6A1B9A),
  Color(0xFFD84315),
  Color(0xFF2E7D32),
  Color(0xFFC2185B),
  Color(0xFF546E7A),
  Color(0xFFFBC02D),
  Color(0xFF039BE5),
  Color(0xFFEF6C00),
  Color(0xFF4527A0),
  Color(0xFF7CB342),
];

const int kInitialDiceCount = 1;

const int kMaxScoreHistoryLength = 20;

const Map<String, String> kRating = {
  'poor': 'poor',
  'fair': 'fair',
  'okay': 'okay',
  'good': 'good',
};