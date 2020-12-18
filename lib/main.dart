import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:master_uro_control_ver_3/data_screen/poll_statefull.dart';
import 'package:master_uro_control_ver_3/theme_constants.dart';
import 'package:flutter/services.dart';

import 'theme_constants.dart';

void main() {
  runApp(UroControlMain());
}

class UroControlMain extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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

  TextEditingController _weightController;
  TextEditingController _tallController;
  TextEditingController _ageController;

  int _currentPage = 1;
  int _lengthPages;
  List<Widget> _pages;

  List<String> sexList = const ["Мужской", "Женский"];
  String dropDownValue = "Мужской";

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  getAge() async {
    final SharedPreferences prefs = await _prefs;
    final String val = prefs.getString('age') ?? '36';
    return val;
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [firstScreenData(), Text("Второй")];
    _lengthPages = _pages.length;
    _weightController = TextEditingController();
    _ageController = TextEditingController(text: "123");
    _tallController = TextEditingController();
  }

  void dispose() {
    _pageController.dispose();
    _ageController.dispose();
    _tallController.dispose();
    _weightController.dispose();
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
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              putYourData, // Header string
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
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
                                  _currentPage = index+1;
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
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                                  child: MaterialButton(
                                    onPressed: () async {
                                      // prefs = await SharedPreferences.getInstance();
                                      // await prefs.clear();
                                    },
                                    color: Color(0xff4BAAC5),
                                    textColor: Colors.white,
                                    minWidth: double.infinity,
                                    // infinity get all width of its parent
                                    padding: EdgeInsets.symmetric(vertical: 10.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(89.0)
                                    ),
                                    // padding: EdgeInsets.fromLTRB(80.0, 15.0, 80.0, 15.0),
                                    child: Text(continueButton, style: TextStyle(
                                        fontSize: 18.0
                                    ),),
                                  ),
                                ),
                                Text("Шаг $_currentPage из $_lengthPages")
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

  Widget firstScreenData() {

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // decoration: BoxDecoration(
            //     color: Colors.grey
            // ),
            child: Column(
              children: [
                Padding(
                  padding: onlyBottomPad8,
                  child: _fieldPool(label: "Вес", shaPrefValue: "weight", hint: "кг"),
                ),
                Padding(
                  padding: onlyBottomPad8,
                  child: _fieldPool(label: "Рост", shaPrefValue: "tall", hint: "см"),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 10.0),
                  child: FormField<String>(
                      builder: (FormFieldState<
                          String> state) {
                        return InputDecorator(
                            decoration: InputDecoration(
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        style: BorderStyle
                                            .none)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primaryColor
                                    )
                                ),
                                labelText: "Пол",
                                errorStyle: TextStyle(
                                    color: Colors
                                        .redAccent,
                                    fontSize: 16.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius
                                      .circular(5.0),
                                  // borderSide: BorderSide(
                                  //   color: primaryColor
                                  // )
                                )
                            ),
                            isEmpty: dropDownValue ==
                                'Выберите из списка',

                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<
                                  String>(
                                value: dropDownValue,
                                hint: Text("Выберите из списка"),
                                isDense: true,
                                isExpanded: true,
                                onChanged: (value) {
                                  setState(() {
                                    state.didChange(
                                        value);
                                    setState(() {
                                      dropDownValue =
                                          value;
                                    });
                                  });
                                },
                                items: sexList.map<
                                    DropdownMenuItem<
                                        String>>((
                                    String val) {
                                  return DropdownMenuItem<
                                      String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                }).toList(),
                              ),
                            )
                        );}
                  ),
                ),
                Padding(
                  padding: onlyBottomPad8,
                  child: _fieldPool(label: "Возраст",
                      txtInputAction: TextInputAction.done,
                  shaPrefValue: "age", controllerName: _ageController),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  TextField _fieldPool({String label, TextEditingController controllerName,
    shaPrefValue, String hint='', int maxLen=3, bool focus=false, txtInputAction = TextInputAction.next}) {

    return TextField(
      autofocus: focus,
      textInputAction: txtInputAction,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      controller: controllerName,
      maxLength: maxLen,
      onSubmitted: (value) async {
        final SharedPreferences prefs = await _prefs;
        prefs.setString(shaPrefValue, value);
        // //TODO: make check if value isSet or not
      },
      decoration: InputDecoration(
        // border: OutlineInputBorder(),
          labelText: label,
          // labelStyle: TextStyle.,
          // helperText: hint,
          suffix: Text(hint.toString()),
      ),
    );
  }

}

class AppNameHeader extends StatelessWidget {
  const AppNameHeader();
  @override
  Widget build(BuildContext context) {
    print("AppNameHeader render...");
    return Container(
        child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: symVerticalPad10,
              child: Text(
                appName,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: mainTextFamily,
                    fontSize: 40.0),
              ),
            )
        )
    );
  }
}
