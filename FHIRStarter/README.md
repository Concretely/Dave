### FHIRStarter library 

Files:
* fhir.dart - Dart wrappers for FHIR resource
* fhir-base.dart - Dart wrappers for miscellaneous FHIR objects that aren't resources (Address, Telecom, etc...)
* api.dart - Handles HTTP requests

Examples:
* createdata.dart - Creates sample example practitioner, patient, and appointment resources and stores them in MiHIN's Ineroperability Land(IOL)
* getdata.dart - Retrieves created resources from IOL
* test.dart - just a file to test different things, in this case some date formatting
