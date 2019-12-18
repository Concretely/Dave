import 'package:flutter/material.dart';
//import 'package:flutter_patient/src/ui/formadd/form_add_screen.dart';
import 'package:fhir_evv/src/ui/home_screen.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        accentColor: Colors.lightBlueAccent,
      ),
      home: Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          title: Text(
            "FHIR EVV",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            ],
        ),
        body: HomeScreen(),
      ),
    );
  }
}
