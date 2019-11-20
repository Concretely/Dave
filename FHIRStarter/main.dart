import 'dart:io';
import 'api.dart';
import 'fhir.dart';
import 'fhir-base.dart';

void main() async {
  String baseURL =
      "https://r9rtfzdz-rich1.interopland.com/five-lakes-health-system/fhir/";
  String token =
      "aW50ZXJvcF9maGlyX3BpdDpaUWUzOWhuSTNUdndwT3lpMjBUdkU2c3h5UEc1TDdaMHk1UkQ=";
  ResourceApiService ras = new ResourceApiService(baseURL, token);
  Resource r = await ras.getById("AllergyIntolerance", "766");
  print(r.toRawJson());
  AllergyIntolerance ai = r;
  print(ai.patient.reference);
  List<String> s = ai.patient.reference.split("/");
  Resource p = await ras.getById(s[0], s[1]);
  print(p.toRawJson());

/*
  Patient p;
  Bundle b;
  List<String> ids = [];
  SearchApiService sas = new SearchApiService(baseURL, token);
  ResourceApiService ras = new ResourceApiService(baseURL, token);
  
  b = await sas.search("Patient", {"name": "folsom"});
  if (b.entry != null) {
    b.entry.forEach((e) {
      if (e.resource is Patient) {
        p = e.resource;
        //ras.delete("Patient", p.id);
        print(p.id + " " + p.name[0].family);
        ids.add(p.id);
      }
    });
  } else {
    print("No patients found");
  }

//  for(int i=0; i < ids.length; i++){
//    await ras.delete("Patient", ids[i]);
//  }

  
  print("----------------");

  Patient new_p = createPatientObject();
  print(new_p.toRawJson());
  await ras.create("Patient", new_p);

  print("-----------------");

  b = await sas.search("Patient", {"name": "folsom"});
  if (b.entry != null) {
    b.entry.forEach((e) {
      if (e.resource is Patient) {
        p = e.resource;
        print(p.id + " " + p.name[0].family);
      }
    });
  } else {
    print("No patients found");
  }

  await ras.delete("Patient", p.id);
*/
  exit(0);
}

Patient createPatientObject() {
  Patient ret = new Patient();
  ret.resourceType = "Patient";
  ret.id = "new";
  ret.active = true;
  ret.birthDate = DateTime.parse("1970-07-16");
  ret.gender = "male";

  ret.name = [];
  ret.name.add(new HumanName());
  ret.name[0].family = "Folsom";
  ret.name[0].given = [];
  ret.name[0].given.add("Rich");
  ret.name[0].given.add("Richard");

  ret.telecom = [];
  ret.telecom.add(new ContactPoint());
  ret.telecom[0].system = "phone";
  ret.telecom[0].value = "512-277-4832";
  ret.telecom[0].use = "mobile";
  return ret;
}
