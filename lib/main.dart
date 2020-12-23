import 'package:flutter/material.dart';
import 'package:master_uro_control_ver_3/theme_constants.dart';
import 'package:flutter/services.dart';
import 'package:master_uro_control_ver_3/data_screen/data_poll.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:developer';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

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
      title: 'Uro Control app',
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
        fontFamily: mainTextFamily, // value from theme_constants.dart
        buttonColor: primaryColor,
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
  PageController _pageController = PageController(
      initialPage: 0
  );

  int _currentPage = 1;
  int _lengthPages;
  List<Widget> _pages;
  String _buttonText = continueButton;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [firstScreenData(), Text("Второй экран")];
    _lengthPages = _pages.length;
    getValues();

    // getDropDownValue();
  }

  void dispose() {
    _pageController.dispose();
    ageController.dispose();
    tallController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Scaffold render...");
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          // hide keyboard when tap outside input text field
        },
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: const [primaryColor, secondaryColor]
              )
          ),

          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AppNameHeader(), // app name string
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: symHorizontalPad40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [ // Table inner white bg
                        PutYourDataString(),
                        Flexible(
                          flex: 10,
                          child: Container(
                            // decoration: BoxDecoration(
                            //     color: Colors.yellowAccent
                            // ),
                            child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              controller: _pageController,
                              itemCount: _lengthPages,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentPage = ++index;
                                  if(_currentPage == 2) {
                                    _buttonText = startButton;
                                  } else {
                                    _buttonText = continueButton;
                                  }
                                });
                              },
                              itemBuilder: (context, index) {
                                return _pages[index];
                              },
                              // children: [
                              //   firstScreenData(),
                              //   Text("Hello World!")
                              // ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                PollButton(pController: _pageController, tButton: _buttonText,),
                                Text("Шаг $_currentPage из $_lengthPages",
                                  style: TextStyle(
                                      color: Colors.grey[600]
                                  ),)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

