import 'package:flutter/material.dart';
import 'visitRoute.dart';
import 'banner.dart';


class SettingsWidget extends StatefulWidget {
  SettingsWidget({Key key}) : super(key: key);

  @override
  _SettingsWidgetState createState() => new _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {

  List _services =
  ["Bathing", "Phone Call", "Haircut", "Mail", "Vitals", "newitem", "N1", "BloodDraw", "Temperature", "Blood Presure", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentService;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentService = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    int _count = 0;
    for (String _currentService in _services) {
      items.add(new DropdownMenuItem(
          value: _currentService,
          child: new Text(_currentService)
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {

    return new Container(
      color: Colors.white,
      child: new Center(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
//              new Text("Service Provided: "),
              new Container(
                padding: new EdgeInsets.all(1.0),
              ),
              new DropdownButton(
                value: _currentService,
                items: _dropDownMenuItems,
                onChanged: changedDropDownItem,
              )
            ],
          )
      ),
    );
  }

  void changedDropDownItem(String selectedService) {
    setState(() {
//      _currentService = selectedService;
      patientVisit.serviceRendered = patientVisit.serviceRendered  + " : " + selectedService;
      myController.text = patientVisit.serviceRendered;


    });
  }

}