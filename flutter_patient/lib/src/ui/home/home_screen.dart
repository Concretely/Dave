import 'package:flutter/material.dart';
import 'package:flutter_patient/src/api/api.dart';
import 'package:flutter_patient/src/ui/formadd/form_add_screen.dart';
import 'package:flutter_patient/src/model/fhir.dart';
import 'package:url_launcher/url_launcher.dart';

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
        future:
            searchApiService.search("Patient", {"general-practitioner": "6"}),
        builder: (BuildContext context, AsyncSnapshot<Bundle> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            Bundle bundle = snapshot.data;
            //return Text(entries[0].patient.id);
            return _buildListView(bundle.entry);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void launchURL(url) async {
    url = Uri.encodeFull(url);
    //String url="https://www.google.com/maps/search/?api=1&query=Austin, TX";
    print(url);
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _deleteData(Patient patient) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Warning"),
            content: Text("Are you sure want to delete patient ${patient.id}?"),
            actions: <Widget>[
              FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  Navigator.pop(context);
                  resourceApiService
                      .delete("Patient", patient.id)
                      .then((statusCode) {
                    if (statusCode == 200) {
                      setState(() {});
                      Scaffold.of(this.context).showSnackBar(
                          SnackBar(content: Text("Delete data success")));
                    } else {
                      Scaffold.of(this.context).showSnackBar(
                          SnackBar(content: Text("Delete data failed")));
                    }
                  });
                },
              ),
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  Widget _buildListView(List<Entry> entry) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Entry e = entry[index];
          Patient patient;
          print(e.resource.resourceType);
          if (e.resource is Patient) patient = e.resource;
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      getName(patient),
                      //patient.name[0].family,
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(height: 2),
                    GestureDetector(
                      onTap: () {
                        launchURL(
                            "https://www.google.com/maps/search/?api=1&query=" +
                                getCityState(patient));
                      },
                      child: Row(
                        children: [
                          Text(
                            getCityState(patient),
                            style: TextStyle(color: Colors.blue),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.edit_location,
                            color: Colors.blue,
                            size: 16.0,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(capitalize(getGender(patient))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size:24.0,
                          ),
                          onTap: () {
                            _deleteData(patient);
                          },
                        ),
                        SizedBox(width:16),
                        GestureDetector(
                            child: Icon(
                              Icons.edit,
                              size:24.0,
                              color: Colors.grey[500],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return FormAddScreen(patient: patient);
                                  },
                                ),
                              );
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: entry.length,
      ),
    );
  }
}
