import 'package:flutter/material.dart';
import 'package:master_uro_control_ver_3/theme_constants.dart';

String dropDownValue = "Мужской";
List<String> sexList = const ["Мужской", "Женский"];

PageController _pageController = PageController(initialPage: 0);

Widget firstScreenPool() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            putYourData, // value from theme_constants.dart
            style: TextStyle(
              color: Color(0xff4BAAC5),
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      Flexible(
        flex: 1,
        child: Container(
          decoration: BoxDecoration(color: Colors.yellowAccent),
          child: Flexible(
            flex: 1,
            child: PageView(
              controller: _pageController,
              children: [
                Text(
                  "Example",
                  style: TextStyle(backgroundColor: Colors.pinkAccent),
                ),
                Text("WOW"),
                // showMe(),
              ],
            ),
          ),
        ),
      )
    ],
  );
}
