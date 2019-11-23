import 'package:flutter/material.dart';
import 'package:flutter_patient/src/api/api.dart';
import 'package:flutter_patient/src/ui/formadd/form_add_screen.dart';
import 'package:flutter_patient/src/model/fhir.dart';


String getName(Patient patient){
  if (patient.name == null)
    return "Unknown Name";
  for(int i=0; i < patient.name.length; i++)
    if(patient.name[i].use=="official")
      if(patient.name[i].given != null)
        return patient.name[i].given[0] + " " + patient.name[i].family;
      else return patient.name[i].family;
  if(patient.name[0].given != null)
    return patient.name[0].given[0] + " " + patient.name[0].family;
  if(patient.name[0].family != null)
    return patient.name[0].family;
    
  return "Unknown Name";
}

String getCityState(Patient patient){
  return getCity(patient) + ", " + getState(patient);
}

String getCity(Patient patient){
  if(patient.address != null)
    return(checkNull(patient.address[0].city,"N/A"));
  else
    return "N/A";
}

String getState(Patient patient){
  if(patient.address != null)
    return(checkNull(patient.address[0].state,"N/A"));
  else
    return "N/A";
}

String checkNull(String str, String rep){
  if(str==null)
    return rep;
  else
    return str;
}

String getGender(patient){
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
    searchApiService = SearchApiService('https://r9rtfzdz-rich1.interopland.com/five-lakes-health-system/fhir/','aW50ZXJvcF9maGlyX3BpdDpaUWUzOWhuSTNUdndwT3lpMjBUdkU2c3h5UEc1TDdaMHk1UkQ=');
    resourceApiService = ResourceApiService('https://r9rtfzdz-rich1.interopland.com/five-lakes-health-system/fhir/','aW50ZXJvcF9maGlyX3BpdDpaUWUzOWhuSTNUdndwT3lpMjBUdkU2c3h5UEc1TDdaMHk1UkQ=');
  }


  @override
  Widget build(BuildContext context) {
    this.context = context;
    return SafeArea(
      child: FutureBuilder(
        future: searchApiService.search("Patient",{"general-practitioner": "6"}),
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


Widget _buildListView(List<Entry> entry) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Entry e = entry[index];
          Patient patient;
          print(e.resource.resourceType);
          if(e.resource is Patient)
            patient = e.resource;
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
                    Text(getCityState(patient)),
                    Text(getGender(patient)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Warning"),
                                    content: Text(
                                        "Are you sure want to delete patient ${patient.id}?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Yes"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          resourceApiService.delete("Patient", patient.id)
                                              .then((statusCode) {
                                            if (statusCode==200) {
                                              setState(() {});
                                              Scaffold.of(this.context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Delete data success")));
                                            } else {
                                              Scaffold.of(this.context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Delete data failed")));
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
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return FormAddScreen(patient: patient);
                            
                            }));
                          
                          },
                          child: Text(
                            "Edit",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
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

