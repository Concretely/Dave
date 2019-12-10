/*
  This file  contains the code for the Hoem Screen: Displays the time line of all EOOB Entries for the suer
  It calls the CMS BlueButton get EOB API and builds the List with a header and a time line
  This program is free software: you can redistribute it and/or modify
      it under the terms of the GNU General Public License as published by
      the Free Software Foundation, either version 3 of the License, or
      (at your option) any later version.

      This program is distributed in the hope that it will be useful,
      but WITHOUT ANY WARRANTY; without even the implied warranty of
      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
      GNU General Public License for more details.

      You should have received a copy of the GNU General Public License
      along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:flutter/material.dart';
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
import 'visitRoute.dart';
import 'appointmentList.dart';
import '../security/auth.dart';

String global = 'global2';


class PatientVisit {
  Position position;
  Patient selectedPatient;
  DateTime visitStarted;
  DateTime visitEnded;
  String serviceRendered;
}

class Patient {
  String firstname;
  String lastname;
  String address1;
  String address2;
  String city;
  String state;
  String zip;
  String patientId;
  String patientDob;
}
bool validPatientList = false;
Patient p = new Patient();


int patientListIndex = 0;

List<Patient> patientList = new List();


createBlankPatientList () {
  print("creating blank patient list");
  Patient p = new Patient();
  p.firstname = "";
  p.lastname = "";
  p.address1 = "";
  p.address2 = "";
  p.city = "";
  p.state = "";
  p.zip = "";
  p.patientId = "";
  p.patientDob = "";

  patientList.add(p);
  validPatientList = false;
}


class CareList2 extends StatefulWidget {

  final String accessToken;

  CareList2({Key key, @required this.accessToken}) : super(key: key);

  @override
  _CareListState2 createState() => new _CareListState2();
}

class _CareListState2 extends State<CareList2> {

  var _accessToken;
  var _patientId = "";
  var _patientName = "";
  var _patientDOB = "";
  ExplnationOfBenfits _eobData;
  var _loading = true;
  var _loadingError = false;

  _onChange(int index) {

    setState(() {
      patientListIndex = index;
    });

  }

  @override
  void initState()  {

    super.initState();
    setState(() {
      _accessToken = widget.accessToken;
      _loadingError = false;
    });

    refresh();
  }

  refresh() {

    print("refreshing");
    setState(() {
      _loading = true;
      _loadingError = false;
    });

    /*getData(_accessToken).then((eobData) {
      setState(() {
        _eobData = eobData;
        _loading = false;
      });
    }).catchError((error){
      print("Exception!: $error");
      //todo: show dialog
    });
    */
  }

  @override
  Widget build(BuildContext context) {

    var appBarColor  = HumedStyles.APP_BAR_COLOR;
    var appBarTitleColor = HumedStyles.APP_BAR_TITLE_COLOR;
    var appBarFontSize = HumedStyles.APP_BAR_TITLE_FONT_SZIE;

    return new Scaffold(
      //drawer: drawer,
      //key: _scaffoldKey,
        appBar: new AppBar(
          bottomOpacity: 0.0,
          backgroundColor: appBarColor,
          brightness: Brightness.light,
          automaticallyImplyLeading: false,
          title: new Text(
            "Unite EVV",
            style: new TextStyle(color: appBarTitleColor,fontSize: appBarFontSize),
          ),
          centerTitle: true,
          elevation: 0.0,
          iconTheme: Theme.of(context).iconTheme,
        ),
          body:buildBody(context)
 //       body: _loading || _loadingError ? new LoadSpinner(loadingError: _loadingError,loading: _loading,):buildBody(context)
    );
  }

  Widget buildBody(BuildContext context) {
    return new Stack(
        children: <Widget>[
          //buildHeader(context),
          buildBodyDetail(context)
        ]
    );
  }

  Widget buildBodyDetail(BuildContext context) {
    print("buildBodyDetail");
    return new Scaffold(
      backgroundColor: Colors.white30,
      body: new Stack(
        children: <Widget>[
          new PatientHeader(patientId: _patientId,patientName: _patientName,patientDOB: _patientDOB),
          //buildTimeline(context),
          buildList(context),

/*
          new Expanded(
              child: new ListView(
//                children: _eobData.benefitEntries.map((benefitEntry) => buildCareRow(benefitEntry)).toList(),
                children: patientList,
              )
          ),
*/


        ],



      ),
    );
  }

  //the vdrtical line
  Widget buildTimeline(BuildContext context) {


    Size screenSize = MediaQuery.of(context).size;


    return new Positioned(
      top: ((screenSize.height / 4) + 70),
      bottom: 0.0,
      left: 32.0,
      child: new Container(
        width: 1.0,
        color: Colors.grey[300],
      ),
    );
  }

  //the list
  Widget buildList(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    print("Building List");
    return new Padding(
      padding: new EdgeInsets.only(top: ((screenSize.height / 3) + 20)),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //List Hedder
          new Padding(
            padding: new EdgeInsets.only(left: 30.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                RaisedButton(
                  onPressed: () {
                    // _listPatients();
                    print("Login");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AuthWidget()),

                    );
                  },
                  child: Text('Login'),
                ),


                RaisedButton(
                  onPressed: () {
                    getAppointment("token", "Patient");
                    populatePatientList();  // This should be deleted when getAppointment is working
                  },
                  child: new Text('Get Appointments'),
                ),

                RaisedButton(
                  onPressed: () {
                    // _listPatients();
                    print("Listing Appointments");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TestRoute()),

                    );
                  },
                  child: Text('Select Appointment'),
                ),

                RaisedButton(
                  onPressed: launchURL,
                  child: new Text('Navigate'),
                ),

                RaisedButton(
                  onPressed: () {
                    // _listPatients();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VisitRoute()),

                    );
                  },
                  child: Text('Start Visit'),
                ),


              ],
            ),
          ),
          //the ListView

/*
          new Expanded(
              //child: new ListView(



                /*body:*/child: new ListView.builder(

                    itemCount: patientList.length,
                    itemBuilder: (BuildContext context, int index){
                      return new Card(
                        child: new Container(
                          padding: new EdgeInsets.all(5.0),
                          child: new Column(
                            children: <Widget>[
                              //new Text(('This is item ${index}')),
                              new Text((patientList[index].firstname + '  ' + patientList[index].lastname)),
                              new CheckboxListTile(
                                value: false , //patientList[index],
                                controlAffinity: ListTileControlAffinity.leading,
                                title: new Text('Select'),
                                onChanged: ( value){_onChange(index);},
                              )
                            ],
                          ),
                        ),
                      );
                    }
                ),

//                children: _eobData.benefitEntries.map((benefitEntry) => buildCareRow(benefitEntry)).toList(),




              )
*/

    ],
      ),
    );
  }


  Widget buildCareRow(BenefitEntry benefityEntry) {

    if(benefityEntry.claimTypeCode == EOBJsonStatics.PHARMACY) {
      return CareRowPharma(benefitEntry:benefityEntry);
    }
    else {
      return CareRowNonPharma(benefitEntry:benefityEntry);
    }
  }

  //call the API and get the EOB  Data
  Future<ExplnationOfBenfits> getData(String accessToken) async {

    var eobData;
    try {
      var userInfo = await getUserInfo(_accessToken);
      setState(() {
        _patientId = userInfo["patient"];
        _patientName = userInfo["name"];
      });

      var patientId = userInfo["patient"].toString();
//      var patient = await getPatient(_accessToken,patientId);
      String patient = "Dave";  // Hacked this
      setState(() {
        _patientDOB = patient[3];  //Hacked this
      });

      print("getting EOB DAta");
      eobData = await getEOB(_accessToken,patientId);
    }
    catch (e) {
      print(e.toString());
      setState(() {
        _loading = false;
        _loadingError = true;
      });
    }

    return eobData;

  }
}

populatePatientList() {
  List<Patient> list = patientList;

  print("in populatelist");
  Patient p = new Patient();
  p.firstname = "Tom";
  p.lastname = "Jones";
  p.address1 = "1017 Columbine Drive";
  p.address2 = "Apt 1A";
  p.city = "Frederick";
  p.state = "MD";
  p.zip = "21701";
  p.patientId = "0";
  p.patientDob = "1/1/2019";

  list.add(p);

  p = new Patient();
  p.firstname = "George";
  p.lastname = "Harrison";
  p.address1 = "5301 Buckeystown Pike";
  p.address2 = "";
  p.city = "Frederick";
  p.state = "MD";
  p.zip = "21704";
  p.patientId = "1";
  p.patientDob = "1/2/2019";

  list.add(p);
  p = new Patient();
  p.firstname = "Mary";
  p.lastname = "McArthy";
  p.address1 = "204 Whitmoor Terrace";
  p.address2 = "";
  p.city = "Silver Spring";
  p.state = "MD";
  p.zip = "20901";
  p.patientId = "2";
  p.patientDob = "1/3/2019";


  list.add(p);
  p = new Patient();
  p.firstname = "Julie";
  p.lastname = "McArthy";
  p.address1 = "204 Whitmoor Terrace";
  p.address2 = "";
  p.city = "Silver Spring";
  p.state = "MD";
  p.zip = "20901";
  p.patientId = "2";
  p.patientDob = "1/3/2019";

  list.add(p);
  p = new Patient();
  p.firstname = "Jean";
  p.lastname = "McArthy";
  p.address1 = "204 Whitmoor Terrace";
  p.address2 = "";
  p.city = "Silver Spring";
  p.state = "MD";
  p.zip = "20901";
  p.patientId = "2";
  p.patientDob = "1/3/2019";
  list.add(p);

  p = new Patient();
  p.firstname = "Joan";
  p.lastname = "McArthy";
  p.address1 = "204 Whitmoor Terrace";
  p.address2 = "";
  p.city = "Silver Spring";
  p.state = "MD";
  p.zip = "20901";
  p.patientId = "2";
  p.patientDob = "1/3/2019";
  list.add(p);

  p = new Patient();
  p.firstname = "Sylvia";
  p.lastname = "McArthy";
  p.address1 = "204 Whitmoor Terrace";
  p.address2 = "";
  p.city = "Silver Spring";
  p.state = "MD";
  p.zip = "20901";
  p.patientId = "2";
  p.patientDob = "1/3/2019";
  list.add(p);

  p = new Patient();
  p.firstname = "Bob";
  p.lastname = "McArthy";
  p.address1 = "204 Whitmoor Terrace";
  p.address2 = "";
  p.city = "Silver Spring";
  p.state = "MD";
  p.zip = "20901";
  p.patientId = "2";
  p.patientDob = "1/3/2019";
  list.add(p);

  p = new Patient();
  p.firstname = "Robert";
  p.lastname = "McArthy";
  p.address1 = "204 Whitmoor Terrace";
  p.address2 = "";
  p.city = "Silver Spring";
  p.state = "MD";
  p.zip = "20901";
  p.patientId = "2";
  p.patientDob = "1/3/2019";
  list.add(p);

  p = new Patient();
  p.firstname = "Mike";
  p.lastname = "McArthy";
  p.address1 = "204 Whitmoor Terrace";
  p.address2 = "";
  p.city = "Silver Spring";
  p.state = "MD";
  p.zip = "20901";
  p.patientId = "2";
  p.patientDob = "1/3/2019";
  list.add(p);

  p = new Patient();
  p.firstname = "Dick";
  p.lastname = "McArthy";
  p.address1 = "204 Whitmoor Terrace";
  p.address2 = "";
  p.city = "Silver Spring";
  p.state = "MD";
  p.zip = "20901";
  p.patientId = "2";
  p.patientDob = "1/3/2019";
  list.add(p);

  p = new Patient();
  p.firstname = "Steve";
  p.lastname = "McArthy";
  p.address1 = "204 Whitmoor Terrace";
  p.address2 = "";
  p.city = "Silver Spring";
  p.state = "MD";
  p.zip = "20901";
  p.patientId = "2";
  p.patientDob = "1/3/2019";
  list.add(p);

  p = new Patient();
  p.firstname = "Don";
  p.lastname = "McArthy";
  p.address1 = "204 Whitmoor Terrace";
  p.address2 = "";
  p.city = "Silver Spring";
  p.state = "MD";
  p.zip = "20901";
  p.patientId = "2";
  p.patientDob = "1/3/2019";
  list.add(p);

  p = new Patient();
  p.firstname = "Ed";
  p.lastname = "McArthy";
  p.address1 = "204 Whitmoor Terrace";
  p.address2 = "";
  p.city = "Silver Spring";
  p.state = "MD";
  p.zip = "20901";
  p.patientId = "2";
  p.patientDob = "1/3/2019";
  list.add(p);

  p = new Patient();
  p.firstname = "Jim";
  p.lastname = "McArthy";
  p.address1 = "204 Whitmoor Terrace";
  p.address2 = "";
  p.city = "Silver Spring";
  p.state = "MD";
  p.zip = "20901";
  p.patientId = "2";
  p.patientDob = "1/3/2019";
  list.add(p);

  print(list.length);
  p = new Patient();
  p.firstname = "John";
  p.lastname = "Jones";
  p.address1 = "319 Hillmoor Drive";
  p.address2 = "";
  p.city = "Silver Spring";
  p.state = "MD";
  p.zip = "20901";
  p.patientId = "15";
  p.patientDob = "1/3/2019";
  list.add(p);

  validPatientList = true;

}
/*
void _onChange(Patient value, int index) {
  setState((){
    patientList[index] = value;
  });
}
*/
@override
Widget build(BuildContext context) {
  return new Scaffold(
    appBar: new AppBar(
      title: new Text('ListView Demo'),
    ),
    body: new ListView.builder(
        itemCount: patientList.length,
        itemBuilder: (BuildContext context, int index){
          return new Card(
            child: new Container(
              padding: new EdgeInsets.all(5.0),
              child: new Column(
                children: <Widget>[
                  new Text(('This is item ${index}')),
                  new CheckboxListTile(
                    value: false , //patientList[index],
                    controlAffinity: ListTileControlAffinity.leading,
                    title: new Text('Click me item ${index}'),
                    //onChanged: (Patient value){_onChange(value, index);},
                  )
                ],
              ),
            ),
          );
        }
    ),
  );
}


