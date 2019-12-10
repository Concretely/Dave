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

// user defined function



class TestRoute extends StatelessWidget {
  @override

  Widget build(BuildContext context) {


    // buildList(context)
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointments"),
      ),
//

//
      body: ListView.builder(
        itemCount: patientList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${patientList[index].firstname}'
                ' '
                '${patientList[index].lastname}'),
            subtitle: Text('${patientList[index].address1}  ${patientList[index].city}  ${patientList[index].state} ${patientList[index].zip}'),



            onTap: () {
              patientListIndex = index;


              Navigator.pop(context);
            },
//            Text("Second Line"),
          );
        },
      ),
/*
      child: ListView.builder(
          itemCount: patientList.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              child: new Container(
                padding: new EdgeInsets.all(5.0),
                child: new Column(
                  children: <Widget>[
                    //new Text(('This is item ${index}')),
                    new Text((patientList[index].firstname +
                        '  ' +
                        patientList[index].lastname)),
                    new CheckboxListTile(
                      value: false, //patientList[index],
                      controlAffinity: ListTileControlAffinity.leading,
                      title: new Text('Select'),
                      onChanged: (value) {
                        _onChange(index);
                      },
                    )
                  ],
                ),
              ),
            );
          }),
*/
    );
  }
}
