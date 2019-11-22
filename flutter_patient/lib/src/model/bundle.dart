// To parse this JSON data, do
//
//     final patient = patientFromJson(jsonString);

import 'dart:convert';

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


List<Patient> patientFromJson(String str) => List<Patient>.from(json.decode(str).map((x) => Patient.fromJson(x)));

String patientToJson(List<Patient> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Patient {
    String resourceType;
    String id;
    Meta meta;
    FHIRText text;
    List<PatientExtension> extension;
    List<Identifier> identifier;
    List<Name> name;
    List<Telecom> telecom;
    String gender;
    DateTime birthDate;
    DateTime deceasedDateTime;
    List<Address> address;
    MaritalStatus maritalStatus;
    bool multipleBirthBoolean;
    List<Communication> communication;

    Patient({
        this.resourceType,
        this.id,
        this.meta,
        this.text,
        this.extension,
        this.identifier,
        this.name,
        this.telecom,
        this.gender,
        this.birthDate,
        this.deceasedDateTime,
        this.address,
        this.maritalStatus,
        this.multipleBirthBoolean,
        this.communication,
    });

    factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        resourceType: json["resourceType"] == null ? null : json["resourceType"],
        id: json["id"] == null ? null : json["id"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        text: json["text"] == null ? null : FHIRText.fromJson(json["text"]),
        extension: json["extension"] == null ? null : List<PatientExtension>.from(json["extension"].map((x) => PatientExtension.fromJson(x))),
        identifier: json["identifier"] == null ? null : List<Identifier>.from(json["identifier"].map((x) => Identifier.fromJson(x))),
        name: json["name"] == null ? null : List<Name>.from(json["name"].map((x) => Name.fromJson(x))),
        telecom: json["telecom"] == null ? null : List<Telecom>.from(json["telecom"].map((x) => Telecom.fromJson(x))),
        gender: json["gender"] == null ? null : json["gender"],
        birthDate: json["birthDate"] == null ? null : DateTime.parse(json["birthDate"]),
        deceasedDateTime: json["deceasedDateTime"] == null ? null : DateTime.parse(json["deceasedDateTime"]),
        address: json["address"] == null ? null : List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
        maritalStatus: json["maritalStatus"] == null ? null : MaritalStatus.fromJson(json["maritalStatus"]),
        multipleBirthBoolean: json["multipleBirthBoolean"] == null ? null : json["multipleBirthBoolean"],
        communication: json["communication"] == null ? null : List<Communication>.from(json["communication"].map((x) => Communication.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "resourceType": resourceType == null ? null : resourceType,
        "id": id == null ? null : id,
        "meta": meta == null ? null : meta.toJson(),
        "text": text == null ? null : text.toJson(),
        "extension": extension == null ? null : List<dynamic>.from(extension.map((x) => x.toJson())),
        "identifier": identifier == null ? null : List<dynamic>.from(identifier.map((x) => x.toJson())),
        "name": name == null ? null : List<dynamic>.from(name.map((x) => x.toJson())),
        "telecom": telecom == null ? null : List<dynamic>.from(telecom.map((x) => x.toJson())),
        "gender": gender == null ? null : gender,
        "birthDate": birthDate == null ? null : "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "deceasedDateTime": deceasedDateTime == null ? null : deceasedDateTime.toIso8601String(),
        "address": address == null ? null : List<dynamic>.from(address.map((x) => x.toJson())),
        "maritalStatus": maritalStatus == null ? null : maritalStatus.toJson(),
        "multipleBirthBoolean": multipleBirthBoolean == null ? null : multipleBirthBoolean,
        "communication": communication == null ? null : List<dynamic>.from(communication.map((x) => x.toJson())),
    };
}

class Address {
    List<AddressExtension> extension;
    List<String> line;
    String city;
    String state;
    String postalCode;
    String country;

    Address({
        this.extension,
        this.line,
        this.city,
        this.state,
        this.postalCode,
        this.country,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        extension: json["extension"] == null ? null : List<AddressExtension>.from(json["extension"].map((x) => AddressExtension.fromJson(x))),
        line: json["line"] == null ? null : List<String>.from(json["line"].map((x) => x)),
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        postalCode: json["postalCode"] == null ? null : json["postalCode"],
        country: json["country"] == null ? null : json["country"],
    );

    Map<String, dynamic> toJson() => {
        "extension": extension == null ? null : List<dynamic>.from(extension.map((x) => x.toJson())),
        "line": line == null ? null : List<dynamic>.from(line.map((x) => x)),
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "postalCode": postalCode == null ? null : postalCode,
        "country": country == null ? null : country,
    };
}

class AddressExtension {
    List<PurpleExtension> extension;
    String url;

    AddressExtension({
        this.extension,
        this.url,
    });

    factory AddressExtension.fromJson(Map<String, dynamic> json) => AddressExtension(
        extension: json["extension"] == null ? null : List<PurpleExtension>.from(json["extension"].map((x) => PurpleExtension.fromJson(x))),
        url: json["url"] == null ? null : json["url"],
    );

    Map<String, dynamic> toJson() => {
        "extension": extension == null ? null : List<dynamic>.from(extension.map((x) => x.toJson())),
        "url": url == null ? null : url,
    };
}

class PurpleExtension {
    String url;
    double valueDecimal;

    PurpleExtension({
        this.url,
        this.valueDecimal,
    });

    factory PurpleExtension.fromJson(Map<String, dynamic> json) => PurpleExtension(
        url: json["url"] == null ? null : json["url"],
        valueDecimal: json["valueDecimal"] == null ? null : json["valueDecimal"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "valueDecimal": valueDecimal == null ? null : valueDecimal,
    };
}

class Communication {
    MaritalStatus language;

    Communication({
        this.language,
    });

    factory Communication.fromJson(Map<String, dynamic> json) => Communication(
        language: json["language"] == null ? null : MaritalStatus.fromJson(json["language"]),
    );

    Map<String, dynamic> toJson() => {
        "language": language == null ? null : language.toJson(),
    };
}

class MaritalStatus {
    List<Coding> coding;
    String text;

    MaritalStatus({
        this.coding,
        this.text,
    });

    factory MaritalStatus.fromJson(Map<String, dynamic> json) => MaritalStatus(
        coding: json["coding"] == null ? null : List<Coding>.from(json["coding"].map((x) => Coding.fromJson(x))),
        text: json["text"] == null ? null : json["text"],
    );

    Map<String, dynamic> toJson() => {
        "coding": coding == null ? null : List<dynamic>.from(coding.map((x) => x.toJson())),
        "text": text == null ? null : text,
    };
}

class Coding {
    String system;
    String code;
    String display;

    Coding({
        this.system,
        this.code,
        this.display,
    });

    factory Coding.fromJson(Map<String, dynamic> json) => Coding(
        system: json["system"] == null ? null : json["system"],
        code: json["code"] == null ? null : json["code"],
        display: json["display"] == null ? null : json["display"],
    );

    Map<String, dynamic> toJson() => {
        "system": system == null ? null : system,
        "code": code == null ? null : code,
        "display": display == null ? null : display,
    };
}

class PatientExtension {
    List<FluffyExtension> extension;
    String url;
    String valueString;
    String valueCode;
    ValueAddress valueAddress;
    double valueDecimal;

    PatientExtension({
        this.extension,
        this.url,
        this.valueString,
        this.valueCode,
        this.valueAddress,
        this.valueDecimal,
    });

    factory PatientExtension.fromJson(Map<String, dynamic> json) => PatientExtension(
        extension: json["extension"] == null ? null : List<FluffyExtension>.from(json["extension"].map((x) => FluffyExtension.fromJson(x))),
        url: json["url"] == null ? null : json["url"],
        valueString: json["valueString"] == null ? null : json["valueString"],
        valueCode: json["valueCode"] == null ? null : json["valueCode"],
        valueAddress: json["valueAddress"] == null ? null : ValueAddress.fromJson(json["valueAddress"]),
        valueDecimal: json["valueDecimal"] == null ? null : json["valueDecimal"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "extension": extension == null ? null : List<dynamic>.from(extension.map((x) => x.toJson())),
        "url": url == null ? null : url,
        "valueString": valueString == null ? null : valueString,
        "valueCode": valueCode == null ? null : valueCode,
        "valueAddress": valueAddress == null ? null : valueAddress.toJson(),
        "valueDecimal": valueDecimal == null ? null : valueDecimal,
    };
}

class FluffyExtension {
    String url;
    Coding valueCoding;
    String valueString;

    FluffyExtension({
        this.url,
        this.valueCoding,
        this.valueString,
    });

    factory FluffyExtension.fromJson(Map<String, dynamic> json) => FluffyExtension(
        url: json["url"] == null ? null : json["url"],
        valueCoding: json["valueCoding"] == null ? null : Coding.fromJson(json["valueCoding"]),
        valueString: json["valueString"] == null ? null : json["valueString"],
    );

    Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "valueCoding": valueCoding == null ? null : valueCoding.toJson(),
        "valueString": valueString == null ? null : valueString,
    };
}

class ValueAddress {
    String city;
    String state;
    String country;

    ValueAddress({
        this.city,
        this.state,
        this.country,
    });

    factory ValueAddress.fromJson(Map<String, dynamic> json) => ValueAddress(
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        country: json["country"] == null ? null : json["country"],
    );

    Map<String, dynamic> toJson() => {
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "country": country == null ? null : country,
    };
}

class Identifier {
    String system;
    String value;
    MaritalStatus type;

    Identifier({
        this.system,
        this.value,
        this.type,
    });

    factory Identifier.fromJson(Map<String, dynamic> json) => Identifier(
        system: json["system"] == null ? null : json["system"],
        value: json["value"] == null ? null : json["value"],
        type: json["type"] == null ? null : MaritalStatus.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "system": system == null ? null : system,
        "value": value == null ? null : value,
        "type": type == null ? null : type.toJson(),
    };
}

class Meta {
    String versionId;
    DateTime lastUpdated;

    Meta({
        this.versionId,
        this.lastUpdated,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        versionId: json["versionId"] == null ? null : json["versionId"],
        lastUpdated: json["lastUpdated"] == null ? null : DateTime.parse(json["lastUpdated"]),
    );

    Map<String, dynamic> toJson() => {
        "versionId": versionId == null ? null : versionId,
        "lastUpdated": lastUpdated == null ? null : lastUpdated.toIso8601String(),
    };
}

class Name {
    String use;
    String family;
    List<String> given;
    List<String> prefix;

    Name({
        this.use,
        this.family,
        this.given,
        this.prefix,
    });

    factory Name.fromJson(Map<String, dynamic> json) => Name(
        use: json["use"] == null ? null : json["use"],
        family: json["family"] == null ? null : json["family"],
        given: json["given"] == null ? null : List<String>.from(json["given"].map((x) => x)),
        prefix: json["prefix"] == null ? null : List<String>.from(json["prefix"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "use": use == null ? null : use,
        "family": family == null ? null : family,
        "given": given == null ? null : List<dynamic>.from(given.map((x) => x)),
        "prefix": prefix == null ? null : List<dynamic>.from(prefix.map((x) => x)),
    };
}

class Telecom {
    String system;
    String value;
    String use;

    Telecom({
        this.system,
        this.value,
        this.use,
    });

    factory Telecom.fromJson(Map<String, dynamic> json) => Telecom(
        system: json["system"] == null ? null : json["system"],
        value: json["value"] == null ? null : json["value"],
        use: json["use"] == null ? null : json["use"],
    );

    Map<String, dynamic> toJson() => {
        "system": system == null ? null : system,
        "value": value == null ? null : value,
        "use": use == null ? null : use,
    };
}

class FHIRText {
    String status;
    String div;

    FHIRText({
        this.status,
        this.div,
    });

    factory FHIRText.fromJson(Map<String, dynamic> json) => FHIRText(
        status: json["status"] == null ? null : json["status"],
        div: json["div"] == null ? null : json["div"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "div": div == null ? null : div,
    };
}
