import 'dart:convert';
import 'fhir-base.dart';

Resource getResource(json) {
  if(json == null) return null;
  if(json["resourceType"] == "Patient") return Patient.fromJson(json);
  if(json["resourceType"]=="Procedure") return Procedure.fromJson(json);
  if(json["resourceType"]=="Encounter") return Encounter.fromJson(json);
  if(json["resourceType"]=="Appointment") return Appointment.fromJson(json);
  if(json["resourceType"]=="Slot") return Slot.fromJson(json);
  if(json["resourceType"]=="Slot") return Slot.fromJson(json);
  if(json["resourceType"]=="Observation") return Observation.fromJson(json);
  if(json["resourceType"]=="Condition") return Condition.fromJson(json);
  if(json["resourceType"]=="DiagnosticReport") return DiagnosticReport.fromJson(json);
  if(json["resourceType"]=="MedicationRequest") return MedicationRequest.fromJson(json);
  if(json["resourceType"]=="CarePlan") return CarePlan.fromJson(json);
  if(json["resourceType"]=="Practitioner") return Practitioner.fromJson(json);
  if(json["resourceType"]=="AllergyIntolerance") return AllergyIntolerance.fromJson(json);
  
  return Resource.fromJson(json);
}

//------------------------------BUNDLE------------------------------------------------------
class Bundle {
  String resourceType;
  String id;
  Meta meta;
  String type;
  int total;
  List<Link> link;
  List<Entry> entry;

  Bundle({
    this.resourceType,
    this.id,
    this.meta,
    this.type,
    this.total,
    this.link,
    this.entry,
  });

  factory Bundle.fromRawJson(String str) => Bundle.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bundle.fromJson(Map<String, dynamic> json) => Bundle(
        resourceType:
            json["resourceType"] == null ? null : json["resourceType"],
        id: json["id"] == null ? null : json["id"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        type: json["type"] == null ? null : json["type"],
        total: json["total"] == null ? null : json["total"],
        link: json["link"] == null
            ? null
            : List<Link>.from(json["link"].map((x) => Link.fromJson(x))),
        entry: json["entry"] == null
            ? null
            : List<Entry>.from(json["entry"].map((x) => Entry.fromJson(x))),
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (this.resourceType != null) data["resourceType"] = resourceType;
    if (this.id != null) data["id"] = this.id;
    if (this.meta != null) data["meta"] = this.meta.toJson();
    if (this.type != null) data["type"] = this.type;
    if (this.total != null) data["total"] = this.total;
    if (this.link != null)
      data["link"] = List<dynamic>.from(link.map((x) => x.toJson()));
    if (this.entry != null)
      data["entry"] = List<dynamic>.from(entry.map((x) => x.toJson()));
    return data;
  }
}

class Entry {
  String fullUrl;
  Resource resource;
  Search search;
  Response response;

  Entry({
    this.fullUrl,
    this.resource,
    this.search,
    this.response,
  });

  factory Entry.fromRawJson(String str) => Entry.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Entry.fromJson(Map<String, dynamic> json) => Entry(
        fullUrl: json["fullUrl"] == null ? null : json["fullUrl"],

        //This line is the magic
        resource: getResource(json["resource"]),
        search: json["search"] == null ? null : Search.fromJson(json["search"]),
        response: json["response"] == null
            ? null
            : Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (this.fullUrl != null) data["fullUrl"] = fullUrl;
    if (this.resource != null) data["resource"] = resource;
    if (this.search != null) data["search"] = search;
    if (this.response != null) data["response"] = response;
    return data;
  }
}

class Resource {
  String resourceType;
  String id;
  Meta meta;
  FHIRText text;

  Resource({
    this.resourceType,
    this.id,
    this.meta,
    this.text,
  });

  factory Resource.fromRawJson(String str) =>
      Resource.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
        resourceType:
            json["resourceType"] == null ? null : json["resourceType"],
        id: json["id"] == null ? null : json["id"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        text: json["text"] == null ? null : FHIRText.fromJson(json["text"]),
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (this.resourceType != null) data["resourceType"] = this.resourceType;
    if (this.id != null) data["id"] = this.id;
    if (this.meta != null) data["meta"] = this.meta.toJson();
    if (this.text != null) data["text"] = this.text.toJson();
    return data;
  }
}

//-------------------------------------------------RESOURCES---------------------------------------------

class Patient extends Resource {
  String resourceType;
  String id;
  Meta meta;
  FHIRText text;
  List<Extension> extension;
  List<Identifier> identifier;
  bool active;
  List<HumanName> name;
  List<ContactPoint> telecom;
  String gender;
  DateTime birthDate;
  List<Address> address;
  List<Reference> generalPractitioner;

  Patient(
      {this.resourceType,
      this.id,
      this.meta,
      this.text,
      this.extension,
      this.identifier,
      this.active,
      this.name,
      this.telecom,
      this.gender,
      this.birthDate,
      this.address,
      this.generalPractitioner});
  factory Patient.fromRawJson(String str) =>
      Patient.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
  
  Patient.fromJson(Map<String, dynamic> json) {
    resourceType = json['resourceType'];
    id = json['id'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    text = json['text'] != null ? new FHIRText.fromJson(json['text']) : null;
    if (json['extension'] != null) {
      extension = new List<Extension>();
      json['extension'].forEach((v) {
        extension.add(new Extension.fromJson(v));
      });
    }
    if (json['identifier'] != null) {
      identifier = new List<Identifier>();
      json['identifier'].forEach((v) {
        identifier.add(new Identifier.fromJson(v));
      });
    }
    active = json['active'];
    if (json['name'] != null) {
      name = new List<HumanName>();
      json['name'].forEach((v) {
        name.add(new HumanName.fromJson(v));
      });
    }
    if (json['telecom'] != null) {
      telecom = new List<ContactPoint>();
      json['telecom'].forEach((v) {
        telecom.add(new ContactPoint.fromJson(v));
      });
    }
    gender = json['gender'];
    if (json['birthDate'] != null)
      birthDate = DateTime.parse(json['birthDate']);

    if (json['address'] != null) {
      address = new List<Address>();
      json['address'].forEach((v) {
        address.add(new Address.fromJson(v));
      });
    }
    if (json['generalPractitioner'] != null) {
      generalPractitioner = new List<Reference>();
      json['generalPractitioner'].forEach((v) {
        generalPractitioner.add(new Reference.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resourceType != null) {
      data['resourceType'] = this.resourceType;
    }
    if (this.id != null) {
      data['id'] = this.id;
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.text != null) {
      data['text'] = this.text.toJson();
    }
    if (this.extension != null) {
      data['extension'] = this.extension.map((v) => v.toJson()).toList();
    }
    if (this.identifier != null) {
      data['identifier'] = this.identifier.map((v) => v.toJson()).toList();
    }
    if (this.active != null) {
      data['active'] = this.active;
    }
    if (this.name != null) {
      data['name'] = this.name.map((v) => v.toJson()).toList();
    }
    if (this.telecom != null) {
      data['telecom'] = this.telecom.map((v) => v.toJson()).toList();
    }
    if (this.gender != null) {
      data['gender'] = this.gender;
    }
    if (this.birthDate != null) {
      data['birthDate'] =
          "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}";
    }
    if (this.address != null) {
      data['address'] = this.address.map((v) => v.toJson()).toList();
    }
    if (this.generalPractitioner != null) {
      data['generalPractitioner'] =
          this.generalPractitioner.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Procedure extends Resource{
  String resourceType;
  String id;
  Meta meta;
  List<Extension> extension;
  List<Identifier> identifier;
  String status;
  CodeableConcept code;
  Reference subject;
  Reference encounter;
  Period performedPeriod;
  List<Performer> performer;
  Reference location;

  Procedure(
      {this.resourceType,
      this.id,
      this.meta,
      this.extension,
      this.identifier,
      this.status,
      this.code,
      this.subject,
      this.encounter,
      this.performedPeriod,
      this.performer,
      this.location});

  factory Procedure.fromRawJson(String str) =>
      Procedure.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  Procedure.fromJson(Map<String, dynamic> json) {
    resourceType = json['resourceType'];
    id = json['id'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['extension'] != null) {
      extension = new List<Extension>();
      json['extension'].forEach((v) {
        extension.add(new Extension.fromJson(v));
      });
    }
    if (json['identifier'] != null) {
      identifier = new List<Identifier>();
      json['identifier'].forEach((v) {
        identifier.add(new Identifier.fromJson(v));
      });
    }
    status = json['status'];
    code = json['code'] != null ? new CodeableConcept.fromJson(json['code']) : null;
    subject =
        json['subject'] != null ? new Reference.fromJson(json['subject']) : null;
    encounter = json['encounter'] != null
        ? new Reference.fromJson(json['encounter'])
        : null;
    performedPeriod = json['performedPeriod'] != null
        ? new Period.fromJson(json['performedPeriod'])
        : null;
    if (json['performer'] != null) {
      performer = new List<Performer>();
      json['performer'].forEach((v) {
        performer.add(new Performer.fromJson(v));
      });
    }
    location = json['location'] != null
        ? new Reference.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resourceType != null) {
      data['resourceType'] = this.resourceType;
    }
    if (this.id != null) {
      data['id'] = this.id;
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.extension != null) {
      data['extension'] = this.extension.map((v) => v.toJson()).toList();
    }
    if (this.identifier != null) {
      data['identifier'] = this.identifier.map((v) => v.toJson()).toList();
    }
    if (this.status != null) {
      data['status'] = this.status;
    }
    if (this.code != null) {
      data['code'] = this.code.toJson();
    }
    if (this.subject != null) {
      data['subject'] = this.subject.toJson();
    }
    if (this.encounter != null) {
      data['encounter'] = this.encounter.toJson();
    }
    if (this.performedPeriod != null) {
      data['performedPeriod'] = this.performedPeriod.toJson();
    }
    if (this.performer != null) {
      data['performer'] = this.performer.map((v) => v.toJson()).toList();
    }
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    return data;
  }
}


class Encounter extends Resource{
  String resourceType;
  String id;
  Meta meta;
  List<Extension> extension;
  String status;
  Coding encounterClass;
  List<CodeableConcept> type;
  Reference subject;
  List<EncounterParticipant> participant;
  List<Reference> appointment;
  Period period;
  List<CodeableConcept> reasonCode;
  List<Location> location;
  Reference serviceProvider;

  Encounter(
      {this.resourceType,
      this.id,
      this.meta,
      this.extension,
      this.status,
      this.encounterClass,
      this.type,
      this.subject,
      this.participant,
      this.appointment,
      this.period,
      this.reasonCode,
      this.location,
      this.serviceProvider});

  Encounter.fromJson(Map<String, dynamic> json) {
    resourceType = json['resourceType'];
    id = json['id'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['extension'] != null) {
      extension = new List<Extension>();
      json['extension'].forEach((v) {
        extension.add(new Extension.fromJson(v));
      });
    }
    status = json['status'];
    encounterClass =
        json['class'] != null ? new Coding.fromJson(json['class']) : null;
    if (json['type'] != null) {
      type = new List<CodeableConcept>();
      json['type'].forEach((v) {
        type.add(new CodeableConcept.fromJson(v));
      });
    }
    subject =
        json['subject'] != null ? new Reference.fromJson(json['subject']) : null;
    if (json['participant'] != null) {
      participant = new List<EncounterParticipant>();
      json['participant'].forEach((v) {
        participant.add(new EncounterParticipant.fromJson(v));
      });
    }
    if (json['appointment'] != null) {
      appointment = new List<Reference>();
      json['appointment'].forEach((v) {
        appointment.add(new Reference.fromJson(v));
      });
    }
    period =
        json['period'] != null ? new Period.fromJson(json['period']) : null;
    if (json['reasonCode'] != null) {
      reasonCode = new List<CodeableConcept>();
      json['reasonCode'].forEach((v) {
        reasonCode.add(new CodeableConcept.fromJson(v));
      });
    }
    if (json['location'] != null) {
      location = new List<Location>();
      json['location'].forEach((v) {
        location.add(new Location.fromJson(v));
      });
    }
    serviceProvider = json['serviceProvider'] != null
        ? new Reference.fromJson(json['serviceProvider'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resourceType != null) {
      data['resourceType'] = this.resourceType;
    }
    if (this.id != null) {
      data['id'] = this.id;
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.extension != null) {
      data['extension'] = this.extension.map((v) => v.toJson()).toList();
    }
    if (this.status != null) {
      data['status'] = this.status;
    }
    if (this.encounterClass != null) {
      data['class'] = this.encounterClass.toJson();
    }
    if (this.type != null) {
      data['type'] = this.type.map((v) => v.toJson()).toList();
    }
    if (this.subject != null) {
      data['subject'] = this.subject.toJson();
    }
    if (this.participant != null) {
      data['participant'] = this.participant.map((v) => v.toJson()).toList();
    }
    if (this.appointment != null) {
      data['appointment'] = this.appointment.map((v) => v.toJson()).toList();
    }
    if (this.period != null) {
      data['period'] = this.period.toJson();
    }
    if (this.reasonCode != null) {
      data['reasonCode'] = this.reasonCode.map((v) => v.toJson()).toList();
    }
    if (this.location != null) {
      data['location'] = this.location.map((v) => v.toJson()).toList();
    }
    if (this.serviceProvider != null) {
      data['serviceProvider'] = this.serviceProvider.toJson();
    }
    return data;
  }
}


class Appointment extends Resource{
  String resourceType;
  String id;
  Meta meta;
  List<Extension> extension;
  String status;
  List<CodeableConcept> serviceCategory;
  List<CodeableConcept> serviceType;
  List<CodeableConcept> specialty;
  CodeableConcept appointmentType;
  List<CodeableConcept> reasonCode;
  int priority;
  String description;
  String start;
  String end;
  int minutesDuration;
  List<Reference> slot;
  String created;
  List<AppointmentParticipant> participant;
  List<Period> requestedPeriod;

  Appointment(
      {this.resourceType,
      this.id,
      this.meta,
      this.extension,
      this.status,
      this.serviceCategory,
      this.serviceType,
      this.specialty,
      this.appointmentType,
      this.reasonCode,
      this.priority,
      this.description,
      this.start,
      this.end,
      this.minutesDuration,
      this.slot,
      this.created,
      this.participant,
      this.requestedPeriod});

  Appointment.fromJson(Map<String, dynamic> json) {
    resourceType = json['resourceType'];
    id = json['id'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['extension'] != null) {
      extension = new List<Extension>();
      json['extension'].forEach((v) {
        extension.add(new Extension.fromJson(v));
      });
    }
    status = json['status'];
    if (json['serviceCategory'] != null) {
      serviceCategory = new List<CodeableConcept>();
      json['serviceCategory'].forEach((v) {
        serviceCategory.add(new CodeableConcept.fromJson(v));
      });
    }
    if (json['serviceType'] != null) {
      serviceType = new List<CodeableConcept>();
      json['serviceType'].forEach((v) {
        serviceType.add(new CodeableConcept.fromJson(v));
      });
    }
    if (json['specialty'] != null) {
      specialty = new List<CodeableConcept>();
      json['specialty'].forEach((v) {
        specialty.add(new CodeableConcept.fromJson(v));
      });
    }
    appointmentType = json['appointmentType'] != null
        ? new CodeableConcept.fromJson(json['appointmentType'])
        : null;
    if (json['reasonCode'] != null) {
      reasonCode = new List<CodeableConcept>();
      json['reasonCode'].forEach((v) {
        reasonCode.add(new CodeableConcept.fromJson(v));
      });
    }
    priority = json['priority'];
    description = json['description'];
    start = json['start'];
    end = json['end'];
    minutesDuration = json['minutesDuration'];
    if (json['slot'] != null) {
      slot = new List<Reference>();
      json['slot'].forEach((v) {
        slot.add(new Reference.fromJson(v));
      });
    }
    created = json['created'];
    if (json['participant'] != null) {
      participant = new List<AppointmentParticipant>();
      json['participant'].forEach((v) {
        participant.add(new AppointmentParticipant.fromJson(v));
      });
    }
    if (json['requestedPeriod'] != null) {
      requestedPeriod = new List<Period>();
      json['requestedPeriod'].forEach((v) {
        requestedPeriod.add(new Period.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resourceType != null) {
      data['resourceType'] = this.resourceType;
    }
    if (this.id != null) {
      data['id'] = this.id;
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.extension != null) {
      data['extension'] = this.extension.map((v) => v.toJson()).toList();
    }
    if (this.status != null) {
      data['status'] = this.status;
    }
    if (this.serviceCategory != null) {
      data['serviceCategory'] =
          this.serviceCategory.map((v) => v.toJson()).toList();
    }
    if (this.serviceType != null) {
      data['serviceType'] = this.serviceType.map((v) => v.toJson()).toList();
    }
    if (this.specialty != null) {
      data['specialty'] = this.specialty.map((v) => v.toJson()).toList();
    }
    if (this.appointmentType != null) {
      data['appointmentType'] = this.appointmentType.toJson();
    }
    if (this.reasonCode != null) {
      data['reasonCode'] = this.reasonCode.map((v) => v.toJson()).toList();
    }
    if (this.priority != null) {
      data['priority'] = this.priority;
    }
    if (this.description != null) {
      data['description'] = this.description;
    }
    if (this.start != null) {
      data['start'] = this.start;
    }
    if (this.end != null) {
      data['end'] = this.end;
    }
    if (this.minutesDuration != null) {
      data['minutesDuration'] = this.minutesDuration;
    }
    if (this.slot != null) {
      data['slot'] = this.slot.map((v) => v.toJson()).toList();
    }
    if (this.created != null) {
      data['created'] = this.created;
    }
    if (this.participant != null) {
      data['participant'] = this.participant.map((v) => v.toJson()).toList();
    }
    if (this.requestedPeriod != null) {
      data['requestedPeriod'] =
          this.requestedPeriod.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Slot extends Resource{
  String resourceType;
  String id;
  Meta meta;
  List<Extension> extension;
  List<CodeableConcept> serviceCategory;
  List<CodeableConcept> serviceType;
  List<CodeableConcept> specialty;
  CodeableConcept appointmentType;
  Reference schedule;
  String status;
  String start;
  String end;
  bool overbooked;
  String comment;

  Slot(
      {this.resourceType,
      this.id,
      this.meta,
      this.extension,
      this.serviceCategory,
      this.serviceType,
      this.specialty,
      this.appointmentType,
      this.schedule,
      this.status,
      this.start,
      this.end,
      this.overbooked,
      this.comment});

  Slot.fromJson(Map<String, dynamic> json) {
    resourceType = json['resourceType'];
    id = json['id'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['extension'] != null) {
      extension = new List<Extension>();
      json['extension'].forEach((v) {
        extension.add(new Extension.fromJson(v));
      });
    }
    if (json['serviceCategory'] != null) {
      serviceCategory = new List<CodeableConcept>();
      json['serviceCategory'].forEach((v) {
        serviceCategory.add(new CodeableConcept.fromJson(v));
      });
    }
    if (json['serviceType'] != null) {
      serviceType = new List<CodeableConcept>();
      json['serviceType'].forEach((v) {
        serviceType.add(new CodeableConcept.fromJson(v));
      });
    }
    if (json['specialty'] != null) {
      specialty = new List<CodeableConcept>();
      json['specialty'].forEach((v) {
        specialty.add(new CodeableConcept.fromJson(v));
      });
    }
    appointmentType = json['appointmentType'] != null
        ? new CodeableConcept.fromJson(json['appointmentType'])
        : null;
    schedule = json['schedule'] != null
        ? new Reference.fromJson(json['schedule'])
        : null;
    status = json['status'];
    start = json['start'];
    end = json['end'];
    overbooked = json['overbooked'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resourceType != null) {
      data['resourceType'] = this.resourceType;
    }
    if (this.id != null) {
      data['id'] = this.id;
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.extension != null) {
      data['extension'] = this.extension.map((v) => v.toJson()).toList();
    }
    if (this.serviceCategory != null) {
      data['serviceCategory'] =
          this.serviceCategory.map((v) => v.toJson()).toList();
    }
    if (this.serviceType != null) {
      data['serviceType'] = this.serviceType.map((v) => v.toJson()).toList();
    }
    if (this.specialty != null) {
      data['specialty'] = this.specialty.map((v) => v.toJson()).toList();
    }
    if (this.appointmentType != null) {
      data['appointmentType'] = this.appointmentType.toJson();
    }
    if (this.schedule != null) {
      data['schedule'] = this.schedule.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status;
    }
    if (this.start != null) {
      data['start'] = this.start;
    }
    if (this.end != null) {
      data['end'] = this.end;
    }
    if (this.overbooked != null) {
      data['overbooked'] = this.overbooked;
    }
    if (this.comment != null) {
      data['comment'] = this.comment;
    }
    return data;
  }
}


class Observation extends Resource{
  String resourceType;
  String id;
  Meta meta;
  List<Extension> extension;
  List<Identifier> identifier;
  String status;
  List<CodeableConcept> category;
  CodeableConcept code;
  Reference subject;
  Reference encounter;
  String effectiveDateTime;
  List<Reference> performer;
  Quantity valueQuantity;

  Observation(
      {this.resourceType,
      this.id,
      this.meta,
      this.extension,
      this.identifier,
      this.status,
      this.category,
      this.code,
      this.subject,
      this.encounter,
      this.effectiveDateTime,
      this.performer,
      this.valueQuantity});

  Observation.fromJson(Map<String, dynamic> json) {
    resourceType = json['resourceType'];
    id = json['id'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['extension'] != null) {
      extension = new List<Extension>();
      json['extension'].forEach((v) {
        extension.add(new Extension.fromJson(v));
      });
    }
    if (json['identifier'] != null) {
      identifier = new List<Identifier>();
      json['identifier'].forEach((v) {
        identifier.add(new Identifier.fromJson(v));
      });
    }
    status = json['status'];
    if (json['category'] != null) {
      category = new List<CodeableConcept>();
      json['category'].forEach((v) {
        category.add(new CodeableConcept.fromJson(v));
      });
    }
    code = json['code'] != null ? new CodeableConcept.fromJson(json['code']) : null;
    subject =
        json['subject'] != null ? new Reference.fromJson(json['subject']) : null;
    encounter = json['encounter'] != null
        ? new Reference.fromJson(json['encounter'])
        : null;
    effectiveDateTime = json['effectiveDateTime'];
    if (json['performer'] != null) {
      performer = new List<Reference>();
      json['performer'].forEach((v) {
        performer.add(new Reference.fromJson(v));
      });
    }
    valueQuantity = json['valueQuantity'] != null
        ? new Quantity.fromJson(json['valueQuantity'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resourceType != null) {
      data['resourceType'] = this.resourceType;
    }
    if (this.id != null) {
      data['id'] = this.id;
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.extension != null) {
      data['extension'] = this.extension.map((v) => v.toJson()).toList();
    }
    if (this.identifier != null) {
      data['identifier'] = this.identifier.map((v) => v.toJson()).toList();
    }
    if (this.status != null) {
      data['status'] = this.status;
    }
    if (this.category != null) {
      data['category'] = this.category.map((v) => v.toJson()).toList();
    }
    if (this.code != null) {
      data['code'] = this.code.toJson();
    }
    if (this.subject != null) {
      data['subject'] = this.subject.toJson();
    }
    if (this.encounter != null) {
      data['encounter'] = this.encounter.toJson();
    }
    if (this.effectiveDateTime != null) {
      data['effectiveDateTime'] = this.effectiveDateTime;
    }
    if (this.performer != null) {
      data['performer'] = this.performer.map((v) => v.toJson()).toList();
    }
    if (this.valueQuantity != null) {
      data['valueQuantity'] = this.valueQuantity.toJson();
    }
    return data;
  }
}


class DiagnosticReport extends Resource{
  String resourceType;
  String id;
  Meta meta;
  FHIRText text;
  List<Extension> extension;
  List<Identifier> identifier;
  String status;
  CodeableConcept code;
  Reference subject;
  Reference encounter;
  Period effectivePeriod;
  String issued;
  List<Reference> performer;
  List<Reference> result;

  DiagnosticReport(
      {this.resourceType,
      this.id,
      this.meta,
      this.text,
      this.extension,
      this.identifier,
      this.status,
      this.code,
      this.subject,
      this.encounter,
      this.effectivePeriod,
      this.issued,
      this.performer,
      this.result});

  DiagnosticReport.fromJson(Map<String, dynamic> json) {
    resourceType = json['resourceType'];
    id = json['id'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    text = json['text'] != null ? new FHIRText.fromJson(json['text']) : null;
    if (json['extension'] != null) {
      extension = new List<Extension>();
      json['extension'].forEach((v) {
        extension.add(new Extension.fromJson(v));
      });
    }
    if (json['identifier'] != null) {
      identifier = new List<Identifier>();
      json['identifier'].forEach((v) {
        identifier.add(new Identifier.fromJson(v));
      });
    }
    status = json['status'];
    code = json['code'] != null ? new CodeableConcept.fromJson(json['code']) : null;
    subject =
        json['subject'] != null ? new Reference.fromJson(json['subject']) : null;
    encounter = json['encounter'] != null
        ? new Reference.fromJson(json['encounter'])
        : null;
    effectivePeriod = json['effectivePeriod'] != null
        ? new Period.fromJson(json['effectivePeriod'])
        : null;
    issued = json['issued'];
    if (json['performer'] != null) {
      performer = new List<Reference>();
      json['performer'].forEach((v) {
        performer.add(new Reference.fromJson(v));
      });
    }
    if (json['result'] != null) {
      result = new List<Reference>();
      json['result'].forEach((v) {
        result.add(new Reference.fromJson(v));
      });
    }
  }

  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resourceType != null) {
      data['resourceType'] = this.resourceType;
    }
    if (this.id != null) {
      data['id'] = this.id;
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.text != null) {
      data['text'] = this.text.toJson();
    }
    if (this.extension != null) {
      data['extension'] = this.extension.map((v) => v.toJson()).toList();
    }
    if (this.identifier != null) {
      data['identifier'] = this.identifier.map((v) => v.toJson()).toList();
    }
    if (this.status != null) {
      data['status'] = this.status;
    }
    if (this.code != null) {
      data['code'] = this.code.toJson();
    }
    if (this.subject != null) {
      data['subject'] = this.subject.toJson();
    }
    if (this.encounter != null) {
      data['encounter'] = this.encounter.toJson();
    }
    if (this.effectivePeriod != null) {
      data['effectivePeriod'] = this.effectivePeriod.toJson();
    }
    if (this.issued != null) {
      data['issued'] = this.issued;
    }
    if (this.performer != null) {
      data['performer'] = this.performer.map((v) => v.toJson()).toList();
    }
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Condition extends Resource{
  String resourceType;
  String id;
  Meta meta;
  List<Extension> extension;
  List<Identifier> identifier;
  CodeableConcept clinicalStatus;
  CodeableConcept verificationStatus;
  CodeableConcept code;
  Reference subject;
  Reference encounter;
  String onsetDateTime;
  String abatementDateTime;
  String recordedDate;
  Reference asserter;

  Condition(
      {this.resourceType,
      this.id,
      this.meta,
      this.extension,
      this.identifier,
      this.clinicalStatus,
      this.verificationStatus,
      this.code,
      this.subject,
      this.encounter,
      this.onsetDateTime,
      this.abatementDateTime,
      this.recordedDate,
      this.asserter});

  Condition.fromJson(Map<String, dynamic> json) {
    resourceType = json['resourceType'];
    id = json['id'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['extension'] != null) {
      extension = new List<Extension>();
      json['extension'].forEach((v) {
        extension.add(new Extension.fromJson(v));
      });
    }
    if (json['identifier'] != null) {
      identifier = new List<Identifier>();
      json['identifier'].forEach((v) {
        identifier.add(new Identifier.fromJson(v));
      });
    }
    clinicalStatus = json['clinicalStatus'] != null
        ? new CodeableConcept.fromJson(json['clinicalStatus'])
        : null;
    verificationStatus = json['verificationStatus'] != null
        ? new CodeableConcept.fromJson(json['verificationStatus'])
        : null;
    code = json['code'] != null ? new CodeableConcept.fromJson(json['code']) : null;
    subject =
        json['subject'] != null ? new Reference.fromJson(json['subject']) : null;
    encounter = json['encounter'] != null
        ? new Reference.fromJson(json['encounter'])
        : null;
    onsetDateTime = json['onsetDateTime'];
    abatementDateTime = json['abatementDateTime'];
    recordedDate = json['recordedDate'];
    asserter = json['asserter'] != null
        ? new Reference.fromJson(json['asserter'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resourceType != null) {
      data['resourceType'] = this.resourceType;
    }
    if (this.id != null) {
      data['id'] = this.id;
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.extension != null) {
      data['extension'] = this.extension.map((v) => v.toJson()).toList();
    }
    if (this.identifier != null) {
      data['identifier'] = this.identifier.map((v) => v.toJson()).toList();
    }
    if (this.clinicalStatus != null) {
      data['clinicalStatus'] = this.clinicalStatus.toJson();
    }
    if (this.verificationStatus != null) {
      data['verificationStatus'] = this.verificationStatus.toJson();
    }
    if (this.code != null) {
      data['code'] = this.code.toJson();
    }
    if (this.subject != null) {
      data['subject'] = this.subject.toJson();
    }
    if (this.encounter != null) {
      data['encounter'] = this.encounter.toJson();
    }
    if (this.onsetDateTime != null) {
      data['onsetDateTime'] = this.onsetDateTime;
    }
    if (this.abatementDateTime != null) {
      data['abatementDateTime'] = this.abatementDateTime;
    }
    if (this.recordedDate != null) {
      data['recordedDate'] = this.recordedDate;
    }
    if (this.asserter != null) {
      data['asserter'] = this.asserter.toJson();
    }
    return data;
  }
}


class MedicationRequest extends Resource{
  String resourceType;
  String id;
  Meta meta;
  List<Extension> extension;
  List<Identifier> identifier;
  String status;
  String intent;
  Reference medicationReference;
  Reference subject;
  Reference encounter;
  String authoredOn;
  Reference requester;
  List<CodeableConcept> reasonCode;

  MedicationRequest(
      {this.resourceType,
      this.id,
      this.meta,
      this.extension,
      this.identifier,
      this.status,
      this.intent,
      this.medicationReference,
      this.subject,
      this.encounter,
      this.authoredOn,
      this.requester,
      this.reasonCode});

  MedicationRequest.fromJson(Map<String, dynamic> json) {
    resourceType = json['resourceType'];
    id = json['id'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['extension'] != null) {
      extension = new List<Extension>();
      json['extension'].forEach((v) {
        extension.add(new Extension.fromJson(v));
      });
    }
    if (json['identifier'] != null) {
      identifier = new List<Identifier>();
      json['identifier'].forEach((v) {
        identifier.add(new Identifier.fromJson(v));
      });
    }
    status = json['status'];
    intent = json['intent'];
    medicationReference = json['medicationReference'] != null
        ? new Reference.fromJson(json['medicationReference'])
        : null;
    subject =
        json['subject'] != null ? new Reference.fromJson(json['subject']) : null;
    encounter = json['encounter'] != null
        ? new Reference.fromJson(json['encounter'])
        : null;
    authoredOn = json['authoredOn'];
    requester = json['requester'] != null
        ? new Reference.fromJson(json['requester'])
        : null;
    if (json['reasonCode'] != null) {
      reasonCode = new List<CodeableConcept>();
      json['reasonCode'].forEach((v) {
        reasonCode.add(new CodeableConcept.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resourceType != null) {
      data['resourceType'] = this.resourceType;
    }
    if (this.id != null) {
      data['id'] = this.id;
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.extension != null) {
      data['extension'] = this.extension.map((v) => v.toJson()).toList();
    }
    if (this.identifier != null) {
      data['identifier'] = this.identifier.map((v) => v.toJson()).toList();
    }
    if (this.status != null) {
      data['status'] = this.status;
    }
    if (this.intent != null) {
      data['intent'] = this.intent;
    }
    if (this.medicationReference != null) {
      data['medicationReference'] = this.medicationReference.toJson();
    }
    if (this.subject != null) {
      data['subject'] = this.subject.toJson();
    }
    if (this.encounter != null) {
      data['encounter'] = this.encounter.toJson();
    }
    if (this.authoredOn != null) {
      data['authoredOn'] = this.authoredOn;
    }
    if (this.requester != null) {
      data['requester'] = this.requester.toJson();
    }
    if (this.reasonCode != null) {
      data['reasonCode'] = this.reasonCode.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CarePlan extends Resource{
  String resourceType;
  String id;
  Meta meta;
  List<Extension> extension;
  List<Identifier> identifier;
  String status;
  List<CodeableConcept> category;
  Reference subject;
  Reference encounter;
  Period period;
  Reference author;

  CarePlan(
      {this.resourceType,
      this.id,
      this.meta,
      this.extension,
      this.identifier,
      this.status,
      this.category,
      this.subject,
      this.encounter,
      this.period,
      this.author});

  CarePlan.fromJson(Map<String, dynamic> json) {
    resourceType = json['resourceType'];
    id = json['id'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['extension'] != null) {
      extension = new List<Extension>();
      json['extension'].forEach((v) {
        extension.add(new Extension.fromJson(v));
      });
    }
    if (json['identifier'] != null) {
      identifier = new List<Identifier>();
      json['identifier'].forEach((v) {
        identifier.add(new Identifier.fromJson(v));
      });
    }
    status = json['status'];
    if (json['category'] != null) {
      category = new List<CodeableConcept>();
      json['category'].forEach((v) {
        category.add(new CodeableConcept.fromJson(v));
      });
    }
    subject =
        json['subject'] != null ? new Reference.fromJson(json['subject']) : null;
    encounter = json['encounter'] != null
        ? new Reference.fromJson(json['encounter'])
        : null;
    period =
        json['period'] != null ? new Period.fromJson(json['period']) : null;
    author =
        json['author'] != null ? new Reference.fromJson(json['author']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resourceType != null) {
      data['resourceType'] = this.resourceType;
    }
    if (this.id != null) {
      data['id'] = this.id;
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.extension != null) {
      data['extension'] = this.extension.map((v) => v.toJson()).toList();
    }
    if (this.identifier != null) {
      data['identifier'] = this.identifier.map((v) => v.toJson()).toList();
    }
    if (this.status != null) {
      data['status'] = this.status;
    }
    if (this.category != null) {
      data['category'] = this.category.map((v) => v.toJson()).toList();
    }
    if (this.subject != null) {
      data['subject'] = this.subject.toJson();
    }
    if (this.encounter != null) {
      data['encounter'] = this.encounter.toJson();
    }
    if (this.period != null) {
      data['period'] = this.period.toJson();
    }
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    return data;
  }
}


class Practitioner extends Resource{
  String resourceType;
  String id;
  Meta meta;
  List<Extension> extension;
  List<Identifier> identifier;
  bool active;
  List<HumanName> name;
  List<ContactPoint> telecom;
  List<Address> address;
  String gender;
  String birthDate;
  List<PractitionerQualification> qualification;

  Practitioner(
      {this.resourceType,
      this.id,
      this.meta,
      this.extension,
      this.identifier,
      this.active,
      this.name,
      this.telecom,
      this.address,
      this.gender,
      this.birthDate,
      this.qualification});

  Practitioner.fromJson(Map<String, dynamic> json) {
    resourceType = json['resourceType'];
    id = json['id'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['extension'] != null) {
      extension = new List<Extension>();
      json['extension'].forEach((v) {
        extension.add(new Extension.fromJson(v));
      });
    }
    if (json['identifier'] != null) {
      identifier = new List<Identifier>();
      json['identifier'].forEach((v) {
        identifier.add(new Identifier.fromJson(v));
      });
    }
    active = json['active'];
    if (json['name'] != null) {
      name = new List<HumanName>();
      json['name'].forEach((v) {
        name.add(new HumanName.fromJson(v));
      });
    }
    if (json['telecom'] != null) {
      telecom = new List<ContactPoint>();
      json['telecom'].forEach((v) {
        telecom.add(new ContactPoint.fromJson(v));
      });
    }
    if (json['address'] != null) {
      address = new List<Address>();
      json['address'].forEach((v) {
        address.add(new Address.fromJson(v));
      });
    }
    gender = json['gender'];
    birthDate = json['birthDate'];
    if (json['qualification'] != null) {
      qualification = new List<PractitionerQualification>();
      json['qualification'].forEach((v) {
        qualification.add(new PractitionerQualification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resourceType != null) {
      data['resourceType'] = this.resourceType;
    }
    if (this.id != null) {
      data['id'] = this.id;
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.extension != null) {
      data['extension'] = this.extension.map((v) => v.toJson()).toList();
    }
    if (this.identifier != null) {
      data['identifier'] = this.identifier.map((v) => v.toJson()).toList();
    }
    if (this.active != null) {
      data['active'] = this.active;
    }
    if (this.name != null) {
      data['name'] = this.name.map((v) => v.toJson()).toList();
    }
    if (this.telecom != null) {
      data['telecom'] = this.telecom.map((v) => v.toJson()).toList();
    }
    if (this.address != null) {
      data['address'] = this.address.map((v) => v.toJson()).toList();
    }
    if (this.gender != null) {
      data['gender'] = this.gender;
    }
    if (this.birthDate != null) {
      data['birthDate'] = this.birthDate;
    }
    if (this.qualification != null) {
      data['qualification'] =
          this.qualification.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllergyIntolerance extends Resource{
  String resourceType;
  String id;
  Meta meta;
  List<Extension> extension;
  List<Identifier> identifier;
  CodeableConcept clinicalStatus;
  CodeableConcept verificationStatus;
  String criticality;
  CodeableConcept code;
  Reference patient;
  String onsetDateTime;
  String recordedDate;
  Reference recorder;

  AllergyIntolerance(
      {this.resourceType,
      this.id,
      this.meta,
      this.extension,
      this.identifier,
      this.clinicalStatus,
      this.verificationStatus,
      this.criticality,
      this.code,
      this.patient,
      this.onsetDateTime,
      this.recordedDate,
      this.recorder});

  AllergyIntolerance.fromJson(Map<String, dynamic> json) {
    resourceType = json['resourceType'];
    id = json['id'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['extension'] != null) {
      extension = new List<Extension>();
      json['extension'].forEach((v) {
        extension.add(new Extension.fromJson(v));
      });
    }
    if (json['identifier'] != null) {
      identifier = new List<Identifier>();
      json['identifier'].forEach((v) {
        identifier.add(new Identifier.fromJson(v));
      });
    }
    clinicalStatus = json['clinicalStatus'] != null
        ? new CodeableConcept.fromJson(json['clinicalStatus'])
        : null;
    verificationStatus = json['verificationStatus'] != null
        ? new CodeableConcept.fromJson(json['verificationStatus'])
        : null;
    criticality = json['criticality'];
    code = json['code'] != null ? new CodeableConcept.fromJson(json['code']) : null;
    patient =
        json['patient'] != null ? new Reference.fromJson(json['patient']) : null;
    onsetDateTime = json['onsetDateTime'];
    recordedDate = json['recordedDate'];
    recorder = json['recorder'] != null
        ? new Reference.fromJson(json['recorder'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resourceType != null) {
      data['resourceType'] = this.resourceType;
    }
    if (this.id != null) {
      data['id'] = this.id;
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.extension != null) {
      data['extension'] = this.extension.map((v) => v.toJson()).toList();
    }
    if (this.identifier != null) {
      data['identifier'] = this.identifier.map((v) => v.toJson()).toList();
    }
    if (this.clinicalStatus != null) {
      data['clinicalStatus'] = this.clinicalStatus.toJson();
    }
    if (this.verificationStatus != null) {
      data['verificationStatus'] = this.verificationStatus.toJson();
    }
    if (this.criticality != null) {
      data['criticality'] = this.criticality;
    }
    if (this.code != null) {
      data['code'] = this.code.toJson();
    }
    if (this.patient != null) {
      data['patient'] = this.patient.toJson();
    }
    if (this.onsetDateTime != null) {
      data['onsetDateTime'] = this.onsetDateTime;
    }
    if (this.recordedDate != null) {
      data['recordedDate'] = this.recordedDate;
    }
    if (this.recorder != null) {
      data['recorder'] = this.recorder.toJson();
    }
    return data;
  }
}



class Claim extends Resource{
  String resourceType;
  String id;
  Meta meta;
  List<Extension> extension;
  List<Identifier> identifier;
  String status;
  CodeableConcept type;
  String use;
  Reference patient;
  Period billablePeriod;
  Reference insurer;
  Reference provider;
  Reference facility;
  List<Diagnosis> diagnosis;
  List<Item> item;
  Money total;

  Claim(
      {this.resourceType,
      this.id,
      this.meta,
      this.extension,
      this.identifier,
      this.status,
      this.type,
      this.use,
      this.patient,
      this.billablePeriod,
      this.insurer,
      this.provider,
      this.facility,
      this.diagnosis,
      this.item,
      this.total});

  Claim.fromJson(Map<String, dynamic> json) {
    resourceType = json['resourceType'];
    id = json['id'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['extension'] != null) {
      extension = new List<Extension>();
      json['extension'].forEach((v) {
        extension.add(new Extension.fromJson(v));
      });
    }
    if (json['identifier'] != null) {
      identifier = new List<Identifier>();
      json['identifier'].forEach((v) {
        identifier.add(new Identifier.fromJson(v));
      });
    }
    status = json['status'];
    type = json['type'] != null ? new CodeableConcept.fromJson(json['type']) : null;
    use = json['use'];
    patient =
        json['patient'] != null ? new Reference.fromJson(json['patient']) : null;
    billablePeriod = json['billablePeriod'] != null
        ? new Period.fromJson(json['billablePeriod'])
        : null;
    insurer =
        json['insurer'] != null ? new Reference.fromJson(json['insurer']) : null;
    provider = json['provider'] != null
        ? new Reference.fromJson(json['provider'])
        : null;
    facility = json['facility'] != null
        ? new Reference.fromJson(json['facility'])
        : null;
    if (json['diagnosis'] != null) {
      diagnosis = new List<Diagnosis>();
      json['diagnosis'].forEach((v) {
        diagnosis.add(new Diagnosis.fromJson(v));
      });
    }
    if (json['item'] != null) {
      item = new List<Item>();
      json['item'].forEach((v) {
        item.add(new Item.fromJson(v));
      });
    }
    total = json['total'] != null ? new Money.fromJson(json['total']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resourceType != null) {
      data['resourceType'] = this.resourceType;
    }
    if (this.id != null) {
      data['id'] = this.id;
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.extension != null) {
      data['extension'] = this.extension.map((v) => v.toJson()).toList();
    }
    if (this.identifier != null) {
      data['identifier'] = this.identifier.map((v) => v.toJson()).toList();
    }
    if (this.status != null) {
      data['status'] = this.status;
    }
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    if (this.use != null) {
      data['use'] = this.use;
    }
    if (this.patient != null) {
      data['patient'] = this.patient.toJson();
    }
    if (this.billablePeriod != null) {
      data['billablePeriod'] = this.billablePeriod.toJson();
    }
    if (this.insurer != null) {
      data['insurer'] = this.insurer.toJson();
    }
    if (this.provider != null) {
      data['provider'] = this.provider.toJson();
    }
    if (this.facility != null) {
      data['facility'] = this.facility.toJson();
    }
    if (this.diagnosis != null) {
      data['diagnosis'] = this.diagnosis.map((v) => v.toJson()).toList();
    }
    if (this.item != null) {
      data['item'] = this.item.map((v) => v.toJson()).toList();
    }
    if (this.total != null) {
      data['total'] = this.total.toJson();
    }
    return data;
  }
}

class ClaimResponse {
  String resourceType;
  String id;
  Meta meta;
  List<Extension> extension;
  List<Identifier> identifier;
  String status;
  Reference patient;
  String created;
  Reference insurer;
  Reference requestor;
  Reference request;
  String outcome;
  List<ClaimResponseItem> item;
  List<Money> total;
  List<ClaimResponseInsurance> insurance;

  ClaimResponse(
      {this.resourceType,
      this.id,
      this.meta,
      this.extension,
      this.identifier,
      this.status,
      this.patient,
      this.created,
      this.insurer,
      this.requestor,
      this.request,
      this.outcome,
      this.item,
      this.total,
      this.insurance});

  ClaimResponse.fromJson(Map<String, dynamic> json) {
    resourceType = json['resourceType'];
    id = json['id'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['extension'] != null) {
      extension = new List<Extension>();
      json['extension'].forEach((v) {
        extension.add(new Extension.fromJson(v));
      });
    }
    if (json['identifier'] != null) {
      identifier = new List<Identifier>();
      json['identifier'].forEach((v) {
        identifier.add(new Identifier.fromJson(v));
      });
    }
    status = json['status'];
    patient =
        json['patient'] != null ? new Reference.fromJson(json['patient']) : null;
    created = json['created'];
    insurer =
        json['insurer'] != null ? new Reference.fromJson(json['insurer']) : null;
    requestor = json['requestor'] != null
        ? new Reference.fromJson(json['requestor'])
        : null;
    request =
        json['request'] != null ? new Reference.fromJson(json['request']) : null;
    outcome = json['outcome'];
    if (json['item'] != null) {
      item = new List<ClaimResponseItem>();
      json['item'].forEach((v) {
        item.add(new ClaimResponseItem.fromJson(v));
      });
    }
    if (json['total'] != null) {
      total = new List<Money>();
      json['total'].forEach((v) {
        total.add(new Money.fromJson(v));
      });
    }
    if (json['insurance'] != null) {
      insurance = new List<ClaimResponseInsurance>();
      json['insurance'].forEach((v) {
        insurance.add(new ClaimResponseInsurance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resourceType != null) {
      data['resourceType'] = this.resourceType;
    }
    if (this.id != null) {
      data['id'] = this.id;
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.extension != null) {
      data['extension'] = this.extension.map((v) => v.toJson()).toList();
    }
    if (this.identifier != null) {
      data['identifier'] = this.identifier.map((v) => v.toJson()).toList();
    }
    if (this.status != null) {
      data['status'] = this.status;
    }
    if (this.patient != null) {
      data['patient'] = this.patient.toJson();
    }
    if (this.created != null) {
      data['created'] = this.created;
    }
    if (this.insurer != null) {
      data['insurer'] = this.insurer.toJson();
    }
    if (this.requestor != null) {
      data['requestor'] = this.requestor.toJson();
    }
    if (this.request != null) {
      data['request'] = this.request.toJson();
    }
    if (this.outcome != null) {
      data['outcome'] = this.outcome;
    }
    if (this.item != null) {
      data['item'] = this.item.map((v) => v.toJson()).toList();
    }
    if (this.total != null) {
      data['total'] = this.total.map((v) => v.toJson()).toList();
    }
    if (this.insurance != null) {
      data['insurance'] = this.insurance.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
