import 'package:flutter/material.dart';
import 'package:master_uro_control_ver_3/data_screen/poll_statefull.dart';
import 'package:master_uro_control_ver_3/theme_constants.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(UroControlMain());
}

class UroControlMain extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Theme widget may quick change style for one component
    // Example:
    //
    // Theme(
    //   // Create a unique theme with "ThemeData"
    //   data: ThemeData(
    //     accentColor: Colors.yellow,
    //   ),
    //   child: FloatingActionButton(
    //     onPressed: () {},
    //     child: Icon(Icons.add),
    //   ),
    // );

    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        // '/': (context) => UroControlMain(),
        // '/second': (context) => SecondSecondPage(),
        // '/test': (context) => HiItsMe(),
        // '/scroll': (context) => ScrollTest()
      },
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: secondaryColor,
        // fontFamily: mainTextFamily, // value from theme_constants.dart

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'UroControl Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // Constructor. this.title assign variable title send string via args
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title; // var for constructor. Look upper info in comment

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return PollScreen();
  }
}
