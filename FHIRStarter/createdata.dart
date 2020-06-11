import 'dart:io';
import 'api.dart';
import 'fhir.dart';
import 'fhir-base.dart';

void main() async {
  String baseURL =
      "https://r9rtfzdz-rich1.interopland.com/five-lakes-health-system/fhir/";
  String token = "";
  ResourceApiService ras = new ResourceApiService(baseURL, token);


//-----------------SET UP DATA------------------------

  Practitioner practitioner = createPractitionerObject("Dr", "Vladimer", "Acula");
  practitioner = await ras.create("Practitioner", practitioner);
  print("Practitioner/" + practitioner.id);

  Patient patient = createPatientObject("John", "Smith", "3820 Remington Rd", "Cedar Park", "TX", "78613");
  patient = await ras.create("Patient", patient);
  print("Patient/"+ patient.id);
  
  Appointment appointment = createAppointmentObject(patient.id
    , patient.name[0].given[0] + " " + patient.name[0].family
    , practitioner.id, practitioner.name[0].prefix[0] + " " + practitioner.name[0].family
    ,  "2019-11-12T09:00:00Z"
    , "2019-11-12T10:00:00Z");
  appointment = await ras.create("Appointment", appointment);
  print("Appointment/"+ appointment.id);

  patient = createPatientObject("Jane", "Doe", "3003 McElroy", "Austin", "TX", "78757");
  patient = await ras.create("Patient", patient);
  print("Patient/"+ patient.id);
  appointment = createAppointmentObject(patient.id
    , patient.name[0].given[0] + " " + patient.name[0].family
    , practitioner.id, practitioner.name[0].prefix[0] + " " + practitioner.name[0].family
    ,  "2019-11-12T12:00:00Z"
    , "2019-11-12T13:00:00Z");
  appointment = await ras.create("Appointment", appointment);
  print("Appointment/"+ appointment.id);

  patient = createPatientObject("Jimmy", "Johnson", "106 Rio Bravo", "Georgetown", "TX", "78628");
  patient = await ras.create("Patient", patient);
  print("Patient/"+ patient.id);
  appointment = createAppointmentObject(patient.id
    , patient.name[0].given[0] + " " + patient.name[0].family
    , practitioner.id, practitioner.name[0].prefix[0] + " " + practitioner.name[0].family
    ,  "2019-11-12T12:00:00Z"
    , "2019-11-12T13:00:00Z");
  appointment = await ras.create("Appointment", appointment);
  print("Appointment/"+ appointment.id);

  exit(0);
}


Patient createPatientObject(firstname, lastname, line, city, state, zip) {
  Patient ret = new Patient();
  ret.resourceType = "Patient";
  //ret.id = "new";
  ret.active = true;
  ret.birthDate = DateTime.parse("1970-07-16");
  ret.gender = "male";

  ret.name = [];
  ret.name.add(new HumanName());
  ret.name[0].family = lastname;
  ret.name[0].given = [];
  ret.name[0].given.add(firstname);
  //ret.name[0].given.add("Richard");

  ret.telecom = [];
  ret.telecom.add(new ContactPoint());
  ret.telecom[0].system = "phone";
  ret.telecom[0].value = "512-277-4832";
  ret.telecom[0].use = "mobile";
  
  ret.address = [];
  ret.address.add(new Address());
  ret.address[0].line = [];
  ret.address[0].line.add(line);
  ret.address[0].type="postal";
  ret.address[0].use="home";
  ret.address[0].city=city;
  ret.address[0].state=state;
  ret.address[0].postalCode=zip;
  return ret;
}

Practitioner createPractitionerObject(String prefix, String firstname, String lastname){
  Practitioner ret = new Practitioner();
  ret.resourceType = "Practitioner";
  //ret.id = "richpractitioner1";
  ret.active = true;

  ret.name = [];
  ret.name.add(new HumanName());
  ret.name[0].family = lastname;
  ret.name[0].given = [];
  ret.name[0].given.add(firstname);
  ret.name[0].prefix = [];
  ret.name[0].prefix.add(prefix);
  
  return ret;
}

Appointment createAppointmentObject(String patientId, String patientName, String practitionerId, String practitionerName, String startTime, String endTime){
  Appointment ret = new Appointment();
  ret.resourceType="Appointment";
  ret.id="richAppointment";
  ret.status="booked";
  ret.description="In home visit";
  ret.participant = [];
  ret.participant.add(new AppointmentParticipant());
  ret.participant[0].actor = new Reference();
  ret.participant[0].actor.reference="Patient/"+ patientId;
  ret.participant[0].actor.display=patientName;
  ret.participant.add(new AppointmentParticipant());
  ret.participant[1].actor = new Reference();
  ret.participant[1].actor.reference="Practitioner/"+ practitionerId;
  ret.participant[1].actor.display=practitionerName;
  ret.start = startTime;
  ret.end = endTime;
  return ret;
}
