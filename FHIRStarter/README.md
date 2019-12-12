### FHIRStarter library 

Files:
* fhir.dart - Dart wrappers for FHIR resource
* fhir-base.dart - Dart wrappers for miscellaneous FHIR objects that aren't resources (Address, Telecom, etc...)
* api.dart - Handles HTTP requests

Examples:
* createdata.dart - creates sample example practitioner, patient and appointment resources and stores them in MiHIN's Ineroperability Land(IOL)
* getdata.dart - retrieves created resources from IOL
