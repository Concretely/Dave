import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_patient/src/api/api.dart';
import 'package:flutter_patient/src/model/fhir.dart';
import 'package:flutter_patient/src/model/fhir-base.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class FormAddScreen extends StatefulWidget {
  final Patient patient;

  FormAddScreen({this.patient});

  @override
  _FormAddScreenState createState() => _FormAddScreenState();
}

class _FormAddScreenState extends State<FormAddScreen> {
  bool _isLoading = false;
  ResourceApiService resourceApiService = ResourceApiService(
      'https://r9rtfzdz-rich1.interopland.com/five-lakes-health-system/fhir/',
      'aW50ZXJvcF9maGlyX3BpdDpaUWUzOWhuSTNUdndwT3lpMjBUdkU2c3h5UEc1TDdaMHk1UkQ=');
  bool _isFieldFirstNameValid;
  bool _isFieldLastNameValid;
  bool _isFieldCityValid;
  bool _isFieldStateValid;
  String newGender;

  TextEditingController _controllerFirstName = TextEditingController();
  TextEditingController _controllerLastName = TextEditingController();
  TextEditingController _controllerCity = TextEditingController();
  TextEditingController _controllerState = TextEditingController();

  @override
  void initState() {
    if (widget.patient != null) {
      _isFieldFirstNameValid = true;
      _controllerFirstName.text = widget.patient.name[0].given[0];
      _isFieldLastNameValid = true;
      _controllerLastName.text = widget.patient.name[0].family;
      _isFieldCityValid = true;
      _controllerCity.text = widget.patient.address[0].city;
      _isFieldStateValid = true;
      _controllerState.text = widget.patient.address[0].state;
      newGender = widget.patient.gender;
    } else {
      newGender = 'male';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.patient == null ? "Add Patient" : "Modify Patient",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                _buildTextFieldFirstName(),
                _buildTextFieldLastName(),
                _buildTextFieldCity(),
                _buildTextFieldState(),
                _buildGenderDropdown(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    child: Text(
                      widget.patient == null
                          ? "Submit".toUpperCase()
                          : "Update Data".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (_isFieldFirstNameValid == null ||
                          _isFieldLastNameValid == null ||
                          _isFieldCityValid == null ||
                          _isFieldStateValid == null ||
                          !_isFieldFirstNameValid ||
                          !_isFieldLastNameValid ||
                          !_isFieldCityValid ||
                          !_isFieldStateValid) {
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Please fill all field"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String firstname = _controllerFirstName.text.toString();
                      String lastname = _controllerLastName.text.toString();
                      String city = _controllerCity.text.toString();
                      String state = _controllerState.text.toString();

                      if (widget.patient == null) {
                        Patient patient = new Patient();
                        patient.resourceType = "Patient";
                        patient.name = [];
                        patient.name.add(new HumanName());
                        patient.name[0].given = [];
                        patient.name[0].given.add(firstname);
                        patient.name[0].family = lastname;
                        patient.address = [];
                        patient.address.add(new Address());
                        patient.address[0].city = city;
                        patient.address[0].state = state;
                        patient.gender = newGender;
                        patient.generalPractitioner = [];
                        patient.generalPractitioner.add(new Reference());
                        patient.generalPractitioner[0].reference =
                            "Practitioner/6";
                        patient.generalPractitioner[0].display =
                            "Louise Catherine McCarthy MD";
                        print(jsonEncode(patient.toJson()));
                        resourceApiService
                            .create("Patient", patient)
                            .then((statusCode) {
                          setState(() => _isLoading = false);
                          print(statusCode);
                          if (statusCode == 201) {
                            Navigator.pop(_scaffoldState.currentState.context);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Submit data failed"),
                            ));
                          }
                        });
                      } else {
                        Patient patient = widget.patient;
                        patient.name[0].given[0] = firstname;
                        patient.name[0].family = lastname;
                        patient.address[0].city = city;
                        patient.address[0].state = state;
                        patient.gender = newGender;

                        resourceApiService
                            .update("Patient", patient)
                            .then((statusCode) {
                          setState(() => _isLoading = false);
                          if (statusCode == 200 || statusCode == 204) {
                            Navigator.pop(_scaffoldState.currentState.context);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Update data failed"),
                            ));
                          }
                        });
                      }
                    },
                    color: Colors.grey[500],
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButton<String>(
      value: newGender,
      iconSize: 24,
      elevation: 16,
      underline: Container(
        height: 2,
      ),
      onChanged: (String newValue) {
        setState(() => newGender = newValue);
      },
      items: <String>['male', 'female']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildTextFieldFirstName() {
    return TextField(
      controller: _controllerFirstName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "First name",
        errorText: _isFieldFirstNameValid == null || _isFieldFirstNameValid
            ? null
            : "First name is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldFirstNameValid) {
          setState(() => _isFieldFirstNameValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldLastName() {
    return TextField(
      controller: _controllerLastName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Last name",
        errorText: _isFieldLastNameValid == null || _isFieldLastNameValid
            ? null
            : "Full name is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldLastNameValid) {
          setState(() => _isFieldLastNameValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldCity() {
    return TextField(
      controller: _controllerCity,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "City",
        errorText: _isFieldCityValid == null || _isFieldCityValid
            ? null
            : "City is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldCityValid) {
          setState(() => _isFieldCityValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldState() {
    return TextField(
      controller: _controllerState,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "State",
        errorText: _isFieldStateValid == null || _isFieldStateValid
            ? null
            : "State is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldStateValid) {
          setState(() => _isFieldStateValid = isFieldValid);
        }
      },
    );
  }
}
