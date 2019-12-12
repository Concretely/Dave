import 'dart:io';
import 'api.dart';
import 'fhir.dart';
import 'package:intl/intl.dart';

void main() async {
  String baseURL =
      "https://r9rtfzdz-rich1.interopland.com/five-lakes-health-system/fhir/";
  String token =
      "aW50ZXJvcF9maGlyX3BpdDpaUWUzOWhuSTNUdndwT3lpMjBUdkU2c3h5UEc1TDdaMHk1UkQ=";




  Bundle b;
  SearchApiService sas = new SearchApiService(baseURL, token);
//  ResourceApiService ras = new ResourceApiService(baseURL, token);
  
  Appointment appt;
  b = await sas.search("Appointment", criteria: {"practitioner": "14936"}, includes: ["Appointment:patient", "Appointment:practitioner"]);
  if (b.entry != null) {
    b.entry.forEach((e) {
      //print(e.resource.resourceType + "/" +e.resource.id);
      
      if (e.resource is Appointment) {
        appt = e.resource;
        Practitioner practitioner = getAppointmentPractitioner(b, appt);
        Patient patient = getAppointmentPatient(b, appt);
        print(appt.id + " " + appt.description);
        print("Start: " + formatDate(appt.start));
        print("End: " + formatDate(appt.end));
        print("Practitioner: " + practitioner.name[0].given[0] + " " + practitioner.name[0].family);
        print("Patient: " + patient.name[0].given[0] + " " + patient.name[0].family);
        print("Address: " + patient.address[0].line[0]);
        print("Address: " + patient.address[0].city + ", " + patient.address[0].state + "  " + patient.address[0].postalCode);
        print("-------------------------------");
      }
      
    });
  } else {
    print("No appointments found");
  }

  exit(0);
}

Practitioner getAppointmentPractitioner(Bundle b, Appointment a){
  Practitioner ret = null;
  String practitionerId;
  
  a.participant.forEach((p) {
    //print(p.actor.reference);
    if(p.actor.reference.startsWith("Practitioner")){
      practitionerId=p.actor.reference.split("/")[1];
      //print(practitionerId);
      b.entry.forEach((e){
        if(e.resource is Practitioner && e.resource.id == practitionerId)
          ret = e.resource;
          return ret;
      });
    }
  });
  return ret;
}

Patient getAppointmentPatient(Bundle b, Appointment a){
  Patient ret = null;
  String patientId;
  
  a.participant.forEach((p) {
    //print(p.actor.reference);
    if(p.actor.reference.startsWith("Patient")){
      patientId=p.actor.reference.split("/")[1];
      //print(patientId);
      b.entry.forEach((e){
        if(e.resource is Patient && e.resource.id == patientId)
          ret = e.resource;
          return ret;
      });
    }
  });
  return ret;
}

String formatDate(String ts){
  DateTime dt = DateTime.parse(ts);
  //DateFormat.y
  return new DateFormat.yMd().add_jm().format(dt);
}