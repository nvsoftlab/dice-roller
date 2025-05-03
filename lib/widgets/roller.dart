import 'package:flutter/material.dart';

class Roller extends StatefulWidget {
  const Roller({super.key});

  @override
  State<Roller> createState() {
    return _RollerState();
  }
}

class _RollerState extends State<Roller> {
  @override
  Widget build(BuildContext context) {
    return Text('dice roller');
  }
}
