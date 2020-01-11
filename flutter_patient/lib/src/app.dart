import 'package:flutter/material.dart';
import 'package:flutter_patient/src/ui/formadd/form_add_screen.dart';
import 'package:flutter_patient/src/ui/home/home_screen.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.grey[700],
        accentColor: Colors.grey[500],
      ),
      home: Scaffold(
          key: _scaffoldState,
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.local_hospital),
                SizedBox(width:4),
                Text(
                  "FHIR Patient Maintenance",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          body: HomeScreen(),
          floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.push(
                    _scaffoldState.currentContext,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return FormAddScreen();
                    }),
                  ),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ))),
    );
  }
}
