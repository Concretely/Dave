import 'package:flutter/material.dart';
import 'banner.dart';
import '../../../util/apiutils.dart';
import '../../../util/constants.dart';
import '../common/load_spinner.dart';
import '../../../model/eob.dart';
import '../../../model/EOBJsonStatics.dart';
import 'care_row_pharma.dart';
import 'care_row_non_pharma.dart';
import '../common/patient_header.dart';
import 'package:geolocator/geolocator.dart';
import 'position.dart';
import 'urlio.dart';
import 'serviceDropDown.dart';



final myController = TextEditingController();
PatientVisit patientVisit = new PatientVisit();


class VisitRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Visit Verification';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form Widget
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class will hold the data related to
// the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();




  @override
  void initState() {
    super.initState();


  }



  @override
  Widget build(BuildContext context) {
    getLocation();
    patientVisit.serviceRendered = "";


    // Build a Form widget using the _formKey we created above
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

/*          TextFormField(
            initialValue: (testtext),


            validator: (value) {
              if (visit.serviceRendered.isEmpty) {
                return 'Service Provided';
              }
            },
          ),
*/

          TextField(
            autofocus: (false),
            controller: myController,
            onChanged: (text) {
              patientVisit.serviceRendered = text;
            },

          ),

          SettingsWidget(

          ),

          Text(
            " ",
            style: new TextStyle(fontSize: 18.0),
          ),

          Text(
            "Individual Receiving Service:",
            style: new TextStyle(fontSize: 18.0, color: Colors.blue),

          ),
          Text(
            "FirstName:       " + patientList[patientListIndex].firstname,
            style: new TextStyle(fontSize: 18.0),
          ),
          Text(
            "LastName:        " + patientList[patientListIndex].lastname,
            style: new TextStyle(fontSize: 18.0),
          ),
          Text(
            "DOB:                   " + patientList[patientListIndex].patientDob,
            style: new TextStyle(fontSize: 18.0),
          ),
          Text(
            " ",
            style: new TextStyle(fontSize: 18.0),
          ),
          Text(
            "Individual Providing Service:",
            style: new TextStyle(fontSize: 18.0, color: Colors.blue),

          ),
          Text(
            "FirstName:       " + "Jane"/*patientList[patientListIndex].firstname"*/,
            style: new TextStyle(fontSize: 18.0),
          ),
          Text(
            "LastName:        " + "Doe"/*patientList[patientListIndex].lastname*/,
            style: new TextStyle(fontSize: 18.0),
          ),
          Text(
            "NPI:                    " + "1234567890"/*patientList[patientListIndex].lastname*/,
            style: new TextStyle(fontSize: 18.0),

          ),

          Text(
            " ",
            style: new TextStyle(fontSize: 18.0),
          ),
          Text(
            "Location of Service:",
            style: new TextStyle(fontSize: 18.0, color: Colors.blue),
          ),
          Text(
            "   Latitude    = " + latitude.toString(),
            style: new TextStyle(fontSize: 18.0),
          ),
          Text(
            "   Longitude = " + longitude.toString(),
            style: new TextStyle(fontSize: 18.0),
          ),
          Text(
            " ",
            style: new TextStyle(fontSize: 18.0),
          ),
          Text(
            "Date of Service:",
            style: new TextStyle(fontSize: 18.0, color: Colors.blue),
          ),
          Text(
            "   Date    = " + DateTime.now().toString(),
            style: new TextStyle(fontSize: 18.0),
          ),
          Text(
            " ",
            style: new TextStyle(fontSize: 18.0),
          ),
          Text(
            "Start Time of Service:",
            style: new TextStyle(fontSize: 18.0, color: Colors.blue),
          ),
          Text(
            "   Start Time    = " + TimeOfDay.now().toString(),
            style: new TextStyle(fontSize: 18.0),
          ),
          Text(
            " ",
            style: new TextStyle(fontSize: 18.0),
          ),
          Text(
            "End Time of Service:",
            style: new TextStyle(fontSize: 18.0, color: Colors.blue),
          ),
          Text(
            "   End Time    = " + TimeOfDay.now().toString(),
            style: new TextStyle(fontSize: 18.0),
          ),

/*
Type of service provided
Individual receiving the service
Individual providing the service
Date of the service
Location of the service deliver
Time the service begins and ends
*/
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                setState(() {
//                  patientVisit.serviceRendered[patientListIndex].firstname = "Test";
//                  testtext = "Test";
//                  setState(() {
//                    testtext = "Test";
//                    print("Service Rendered = $testtext");
//                  });

                });

                // Validate will return true if the form is valid, or false if
                // the form is invalid.


                if (_formKey.currentState.validate()) {
//                 Navigator.pop(context);
                  // If the form is valid, we want to show a Snackbar
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Submitting Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
/*

class VisitRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visit Details"),
      ),
      body: ListView.builder(
        itemCount: patientList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${patientList[index].firstname}'
                ' '
                '${patientList[index].lastname}'),
            onTap: () {
              print("He Tapped me");
              print(index);
              //selectedPatient = patientList[index];

              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
*/
