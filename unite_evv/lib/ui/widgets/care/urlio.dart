import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

import 'package:flutter/services.dart' show rootBundle;
/*static*/ const String CMS_BB_API_ENDPOINT            =   "https://sandbox.bluebutton.cms.gov/v1";
/*static*/ const String CMS_BB_API_PATIENT_URI         =   CMS_BB_API_ENDPOINT + "/fhir/Patient/";

patientClick  () async  {

  print('In Patient Click');
  var patient = await getAppointment("Dave","Walsh");
  print('We got the Appointment');

}

Future<Map<String,dynamic>> getPatient(String accessToken, String patientId) async {

  var patientURL =  CMS_BB_API_PATIENT_URI + patientId;
  var authHeader = "Bearer $accessToken";
  print('Going to get' + patientURL);
  patientURL = 'http://hapi.fhir.org/baseDstu3/Patient/1293766';
  final response = await http.get(patientURL,headers:{"Authorization":authHeader});

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    print(response.body);

    return json.decode(response.body);
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to get patient');
  }
}

Future<Map<String,dynamic>> getAppointment(String accessToken, String patientId) async {
  var returnJSON;
  var appointmentURL =  CMS_BB_API_PATIENT_URI + patientId;
  var authHeader = "Bearer $accessToken";
  print('Going to get' + appointmentURL);
  appointmentURL = 'http://hapi.fhir.org/baseDstu3/Appointment/1293839/_history/1';
  final response = await http.get(appointmentURL,headers:{"Authorization":authHeader});

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    print(response.body);
    returnJSON = json.decode(response.body);
    print(returnJSON["resourceType"]);
    print(returnJSON["participant"][1]["actor"]["reference"]);

    return json.decode(response.body);
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to get appointment');
  }
}

/*
String _accessToken = 'Dave';
refresh() {
  print("refreshing");
/*  setState(() {
    _loading = true;
    _loadingError = false;
  });
*/

/*  getPatient(_accessToken,'Walsh').then((eobData) {
};
*/
*/
//http://hapi.fhir.org/baseDstu3/Appointment/1293839/_history/1