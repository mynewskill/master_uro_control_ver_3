import 'package:flutter/material.dart';
import 'package:master_uro_control_ver_3/theme_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController weightController = TextEditingController();
TextEditingController tallController = TextEditingController();
TextEditingController ageController = TextEditingController();

List<String> sexList = const ["Мужской", "Женский"];
String dropDownValue;

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

getDDB() async {
  final SharedPreferences prefs = await _prefs;
  dropDownValue = prefs.getString('sex') ?? 'Мужской';
  print("getDDB function called...");
}

getValues () async {
  final SharedPreferences prefs = await _prefs;
  ageController.text = prefs.getString('age') ?? '';
  tallController.text = prefs.getString('tall') ?? '';
  weightController.text = prefs.getString('weight') ?? '';
  dropDownValue = prefs.getString('sex') ?? 'Мужской';
  // dropDownValue = testDDV;
  print(dropDownValue);
}

getDropDownValue() async {
  final SharedPreferences prefs = await _prefs;
  dropDownValue = prefs.getString('sex') ?? 'Мужской';
  Future.delayed(Duration(milliseconds: 500));
  return dropDownValue.toString();
}

void saveShaPrefInt(shaPrefKey, value) async {
  final SharedPreferences prefs = await _prefs;
  prefs.setString(shaPrefKey,
      // trim leading zeroes (convert to Int and save as String)
      int.parse(value).toString());
  // //TODO: make check if value isSet or not
}

void saveShaPref(shaPrefKey, value) async {
  final SharedPreferences prefs = await _prefs;
  prefs.setString(shaPrefKey,value);
  // //TODO: make check if value isSet or not
}

void saveFirstScreenData() async {
  final SharedPreferences prefs = await _prefs;
  prefs.setString('sex', dropDownValue);
  prefs.setString('age', ageController.text);
  prefs.setString('tall', tallController.text);
  prefs.setString('weight', weightController.text);

}

// Widget addPollButton(PageController pController, Text tButton) {
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 12.0, top: 8.0),
//     child: MaterialButton(
//       onPressed: () {
//         if (_pageController.initialPage == 0) {
//           saveFirstScreenData();
//           _pageController.nextPage(
//               duration: Duration(milliseconds: 600),
//               curve: Curves.easeInOutQuint);
//
//         } if(_pageController.initialPage == 1) {
//
//         } else {
//
//         }
//       },
//       color: Color(0xff4BAAC5),
//       textColor: Colors.white,
//       minWidth: double.infinity,
//       // infinity get all width of its parent
//       padding: EdgeInsets.symmetric(vertical: 10.0),
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(89.0)
//       ),
//       // padding: EdgeInsets.fromLTRB(80.0, 15.0, 80.0, 15.0),
//       child: Text(_buttonText, style: TextStyle(
//           fontSize: 18.0
//       ),),
//     ),
//   );
// }

class PollButton extends StatefulWidget {
  const PollButton({this.pController, this.tButton, Key key}) : super(key: key);

  final PageController pController;
  final String tButton;

  @override
  _PollButtonState createState() => _PollButtonState();
}

class _PollButtonState extends State<PollButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, top: 8.0),
      child: MaterialButton(
        onPressed: () {
          if (widget.pController.initialPage == 0) {
            saveFirstScreenData();
            widget.pController.nextPage(
                duration: Duration(milliseconds: 600),
                curve: Curves.easeInOutQuint);

          } if(widget.pController.initialPage == 1) {

          } else {

          }
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
        child: Text(widget.tButton, style: TextStyle(
            fontSize: 18.0
        ),),
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

class PutYourDataString extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
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
    );
  }
}

class DropDownSexList extends StatefulWidget {
  @override
  _DropDownSexListState createState() => _DropDownSexListState();
}

class _DropDownSexListState extends State<DropDownSexList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, bottom: 10.0),
      child: FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
                decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            style: BorderStyle.none)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: primaryColor
                        )
                    ),
                    labelText: "Пол",
                    // helperText: "Helper Text",
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
                // isEmpty: dropDownValue ==
                //     'Выберите из списка',

                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: dropDownValue,
                    hint: Text("Выберите из списка"),
                    isDense: true,
                    isExpanded: true,
                    onChanged: (value) {
                      setState(() {
                        // state.didChange(value);
                        dropDownValue = value;
                        saveShaPref('sex', value);
                      });
                    },
                    items: sexList.map<
                        DropdownMenuItem<String>>((String val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    }).toList(),
                  ),
                )
            );}
      ),
    );
  }
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
                child: _fieldPool(label: "Вес", shaPrefValue: "weight", controllerName: weightController,
                    hint: "кг"),
              ),
              Padding(
                padding: onlyBottomPad8,
                child: _fieldPool(label: "Рост", shaPrefValue: "tall", controllerName: tallController,
                    hint: "см"),
              ),
              DropDownSexList(),
              Padding(
                padding: onlyBottomPad8,
                child: _fieldPool(label: "Возраст",
                    txtInputAction: TextInputAction.done,
                    shaPrefValue: "age", controllerName: ageController),
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
    onSubmitted: (value) {
      saveShaPrefInt(shaPrefValue, value);
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
