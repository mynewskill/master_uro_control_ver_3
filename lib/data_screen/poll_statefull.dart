import 'package:flutter/material.dart';
import 'package:master_uro_control_ver_3/theme_constants.dart';

class PollScreen extends StatefulWidget {
  @override
  _PollScreenState createState() => _PollScreenState();
}

class _PollScreenState extends State<PollScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [primaryColor, secondaryColor]
            )
        ),
      ),
    );
  }
}
