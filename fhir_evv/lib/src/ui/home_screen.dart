import 'package:flutter/material.dart';
import 'package:fhir_evv/src/fhirstarter/api.dart';
//import 'package:flutter_patient/src/ui/formadd/form_add_screen.dart';
import 'package:fhir_evv/src/fhirstarter/fhir.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

void launchURL(url) async {
  print(url);
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void showPositionDialog(BuildContext context) async{
  Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Verifying Visit"),
          content: Text("Verifying visit from current latitude: " 
          + position.latitude.toString()
          + " longitude: "
          + position.longitude.toString()
          
          ),
          actions: <Widget>[
            FlatButton(
              child: Icon(Icons.map),
              onPressed: () {
                launchURL("https://www.google.com/maps/search/?api=1&query="+position.latitude.toString()+","+position.longitude.toString());
              },
            ),
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}

Practitioner getAppointmentPractitioner(Bundle b, Appointment a) {
  Practitioner ret;
  String practitionerId;

  a.participant.forEach((p) {
    //print(p.actor.reference);
    if (p.actor.reference.startsWith("Practitioner")) {
      practitionerId = p.actor.reference.split("/")[1];
      //print(practitionerId);
      b.entry.forEach((e) {
        if (e.resource is Practitioner && e.resource.id == practitionerId)
          ret = e.resource;
        return ret;
      });
    }
  });
  return ret;
}

Patient getAppointmentPatient(Bundle b, Appointment a) {
  Patient ret;
  String patientId;

  a.participant.forEach((p) {
    //print(p.actor.reference);
    if (p.actor.reference.startsWith("Patient")) {
      patientId = p.actor.reference.split("/")[1];
      //print(patientId);
      b.entry.forEach((e) {
        if (e.resource is Patient && e.resource.id == patientId)
          ret = e.resource;
        return ret;
      });
    }
  });
  return ret;
}

String formatDate(String ts) {
  DateTime dt = DateTime.parse(ts);
  //DateFormat.y

  return new DateFormat.yMd().add_jm().format(dt);
}

String getName(Patient patient) {
  if (patient.name == null) return "Unknown Name";
  for (int i = 0; i < patient.name.length; i++)
    if (patient.name[i].use == "official") if (patient.name[i].given != null)
      return patient.name[i].given[0] + " " + patient.name[i].family;
    else
      return patient.name[i].family;
  if (patient.name[0].given != null)
    return patient.name[0].given[0] + " " + patient.name[0].family;
  if (patient.name[0].family != null) return patient.name[0].family;

  return "Unknown Name";
}

String getCityState(Patient patient) {
  return getCity(patient) + ", " + getState(patient);
}

String getCity(Patient patient) {
  if (patient.address != null)
    return (checkNull(patient.address[0].city, "N/A"));
  else
    return "N/A";
}

String getState(Patient patient) {
  if (patient.address != null)
    return (checkNull(patient.address[0].state, "N/A"));
  else
    return "N/A";
}

String checkNull(String str, String rep) {
  if (str == null)
    return rep;
  else
    return str;
}

String getGender(patient) {
  return checkNull(patient.gender, "N/A");
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BuildContext context;
  SearchApiService searchApiService;
  ResourceApiService resourceApiService;

  @override
  void initState() {
    super.initState();
    searchApiService = SearchApiService(
        'https://r9rtfzdz-rich1.interopland.com/five-lakes-health-system/fhir/',
        'aW50ZXJvcF9maGlyX3BpdDpaUWUzOWhuSTNUdndwT3lpMjBUdkU2c3h5UEc1TDdaMHk1UkQ=');
    resourceApiService = ResourceApiService(
        'https://r9rtfzdz-rich1.interopland.com/five-lakes-health-system/fhir/',
        'aW50ZXJvcF9maGlyX3BpdDpaUWUzOWhuSTNUdndwT3lpMjBUdkU2c3h5UEc1TDdaMHk1UkQ=');
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return SafeArea(
      child: FutureBuilder(
        future: searchApiService.search("Appointment",
            criteria: {"practitioner": "14936"},
            includes: ["Appointment:patient", "Appointment:practitioner"]),
        builder: (BuildContext context, AsyncSnapshot<Bundle> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            Bundle bundle = snapshot.data;
            //return Text(entries[0].patient.id);
            return _buildListView(bundle);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(Bundle bundle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Entry e = bundle.entry[index];
          Appointment appointment;
          //Practitioner practitioner;
          Patient patient;
          print(e.resource.resourceType);
          if (e.resource is Appointment) {
            appointment = e.resource;
            //practitioner = getAppointmentPractitioner(bundle, appointment);
            patient = getAppointmentPatient(bundle, appointment);

            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        patient.name[0].given[0] + " " + patient.name[0].family,
                        //patient.name[0].family,
                        style: Theme.of(context).textTheme.title,
                      ),
                      Text("Start: " + formatDate(appointment.start)),
                      Text("End: " + formatDate(appointment.end)),
                      //Text("Patient: " + patient.name[0].given[0] + " " + patient.name[0].family),
                      Text(patient.address[0].line[0]),
                      Text(patient.address[0].city +
                          ", " +
                          patient.address[0].state +
                          "  " +
                          patient.address[0].postalCode),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              //Position position = getPosition();
                              showPositionDialog(context);
                            },
                            child: Icon(
                              Icons.verified_user,
                              color: Colors.blue,
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              launchURL(
                                  "https://www.google.com/maps/search/?api=1&query=" +
                                      patient.address[0].line[0] +
                                      " " +
                                      patient.address[0].city +
                                      ", " +
                                      patient.address[0].state +
                                      "  " +
                                      patient.address[0].postalCode);
                              //Navigator.push(context,
                              //    MaterialPageRoute(builder: (context) {
                              //  return FormAddScreen(patient: patient);

                              //}));
                            },
                            child: Icon(
                              Icons.map,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else
            return null;
        },
        //itemCount: entry.length,
      ),
    );
  }
}
