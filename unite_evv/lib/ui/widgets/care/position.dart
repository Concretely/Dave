import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
//Included from httpread
import 'dart:convert';
import 'dart:io' show Platform;
//import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
//import 'package:untitled7/untitled7.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
//import '../care/care_list.dart';
import 'dart:core';
import 'package:uuid/uuid.dart';
import 'banner.dart';

double latitude;
double longitude;

Patient p = new Patient();
Position position;

getLocation() async {
  print("Here we are");
  bool emulation = true;

  if (emulation == true) {
    print("Using Emulation");
    latitude = 39.22471;
    longitude = 77.25169;
    latitude = 33.7386703;
    longitude = -77.4278203;
    latitude = 39.379750;
    longitude = -77.421361;
//    position.latitude = 39.379750;
//    position.longitude = -77.421361;
  } else {
    print("Using real location");
    position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    latitude = position.latitude;
    longitude = position.longitude;
  }
//    _stringposition =
//        'Latitude =' + '$_latitude' + '  ' + 'Longitute =' + '$_longitude';
/*
    setState(() {
      //_position = position;
    });
*/
  return (position);
}

launchURL() async {
  if(  validPatientList == false ) {
    return;
  };
  getLocation();
  String url = "https://www.google.com/maps/@39.734984,-77.4732153,15z";
  url = "https://www.google.com/maps/@" +
      '$latitude' +
      ',' +
      '$longitude' +
      ",15z";
//    url = "https://maps.google.com/?daddr=+ "@zoom=15" +  '$_latitude' + ',' + '$_longitude'  ;
  url =
  "https://www.google.com/maps/@?api=1&map_action=map&center=$latitude,$longitude&zoom=15";
  String destinationaddress;
//    String destinationstring = "1017 Columbine drive frederick MD 21701";
  Patient p = new Patient();
  p = patientList[patientListIndex];
  destinationaddress =
  '${p.address1} ${p.city}  ${p.state} ${p.zip}';
  print("destinationaddress=");
  print(destinationaddress);
  bool emulation = true;
  print("Emulation = $emulation");
  String fixeddestinationaddress;
//    destinationaddress = fixeddestinationaddress;
  if (emulation == true) {
    print(destinationaddress);
//      selectedPatient._address1 = " ";
//      selectedPatient._address2 = " ";
//      selectedPatient._city = " ";
//      selectedPatient._state = " ";
//      selectedPatient._zip = " ";
    fixeddestinationaddress = destinationaddress.replaceAll(' ', '+');
    print("Replaced=");
    print(fixeddestinationaddress);

    url =
    "https://www.google.com/maps/dir/?api=1&origin=$latitude,$longitude&destination=$fixeddestinationaddress";
  } else {
    url =
    "https://www.google.com/maps/dir/?api=1&destination=$fixeddestinationaddress";
  }
//    url = "https://www.google.com";
  print("url=");
  print(url);
  print("url=");
//    url="https://www.google.com/maps/dir/?api=1&origin=39.37975,-77.421361&destination=204 Whitmoor Terrace Silver Spring  MD 20901";
  print("url=");
  print(url);
  print("Calling canlaunch");
  if (await canLaunch(url)) {
    print("Calling URL");
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MITA TAC EVV PoC',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
//      home: MyHomePage(title: 'MITA TAC EVV PoC Home Page'),
    );
  }
}

/*

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _patientname = '';
  Position _position;
  double _latitude;
  double _longitude;
/*
  _getLocation() async {
    print("Here we are");
    bool emulation = true;

    if (emulation == true) {
      print("Using Emulation");
      _latitude = 39.22471;
      _longitude = 77.25169;
      _latitude = 33.7386703;
      _longitude = -77.4278203;
      _latitude = 39.379750;
      _longitude = -77.421361;
    } else {
      print("Using real location");
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _latitude = position.latitude;
      _longitude = position.longitude;
    }
//    _stringposition =
//        'Latitude =' + '$_latitude' + '  ' + 'Longitute =' + '$_longitude';
/*
    setState(() {
      //_position = position;
    });
*/
    return (null);
  }
  */
/*
  launchURL() async {
    _getLocation();
    String url = "https://www.google.com/maps/@39.734984,-77.4732153,15z";
    url = "https://www.google.com/maps/@" +
        '$_latitude' +
        ',' +
        '$_longitude' +
        ",15z";
//    url = "https://maps.google.com/?daddr=+ "@zoom=15" +  '$_latitude' + ',' + '$_longitude'  ;
    url =
    "https://www.google.com/maps/@?api=1&map_action=map&center=$_latitude,$_longitude&zoom=15";
    String destinationaddress;
//    String destinationstring = "1017 Columbine drive frederick MD 21701";
    destinationaddress = " ";
//  '${selectedPatient._address1} ${selectedPatient._city}  ${selectedPatient._state} ${selectedPatient._zip}';
    print("destinationaddress=");
    print(destinationaddress);
    bool emulation = true;
    print("Emulation = $emulation");
    String fixeddestinationaddress;
//    destinationaddress = fixeddestinationaddress;
    if (emulation == true) {
      print(destinationaddress);
//      selectedPatient._address1 = " ";
//      selectedPatient._address2 = " ";
//      selectedPatient._city = " ";
//      selectedPatient._state = " ";
//      selectedPatient._zip = " ";
      fixeddestinationaddress = destinationaddress.replaceAll(' ', '+');
      print("Replaced=");
      print(fixeddestinationaddress);

      url =
      "https://www.google.com/maps/dir/?api=1&origin=$_latitude,$_longitude&destination=$fixeddestinationaddress";
    } else {
      url =
      "https://www.google.com/maps/dir/?api=1&destination=$fixeddestinationaddress";
    }
//    url = "https://www.google.com";
    print("url=");
    print(url);
    print("url=");
//    url="https://www.google.com/maps/dir/?api=1&origin=39.37975,-77.421361&destination=204 Whitmoor Terrace Silver Spring  MD 20901";
    print("url=");
    print(url);
    print("Calling canlaunch");
    if (await canLaunch(url)) {
      print("Calling URL");
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
*/
}
*/

class ThirdRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Visit details"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Place of Service',
              style: Theme.of(context).textTheme.display1,

            ),
            Text(
              'Tester',
            //  _currentStringPosition,
              style: Theme.of(context).textTheme.display1,

            ),
            // Text('$_latitude',),
            // Text('$_longitude',),
            //Text('$_stringposition',),
            Text('first and last name'
/*              '${selectedPatient._firstname}' +
                  ' ' +
                  '${selectedPatient._lastname}'*/
                                                ,
              style: Theme.of(context).textTheme.display1,
            ),

            RaisedButton(
              onPressed: () {
                print("He pushed me");
                //_getCurrentLocation();
                // currentVisit.position = _latitude;//_listPatients();
                Navigator.push(
                  context,
                       MaterialPageRoute(builder: (context) => ThirdRoute()),
                  //MaterialPageRoute(builder: (context) => AuthWidget()),
                );


              },

              child: Text('Start Visit'),
            ),
          ],
        ),

      ),


    );
  }

}
