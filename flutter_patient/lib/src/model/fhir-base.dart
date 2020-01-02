import 'dart:convert';


//------------------------------HELPER CLASSES
class Address {
  String use;
  String type;
  List<String> line;
  String city;
  String district;
  String state;
  String postalCode;

  Address(
      {this.use,
      this.type,
      this.line,
      this.city,
      this.district,
      this.state,
      this.postalCode});

  Address.fromJson(Map<String, dynamic> json) {
    use = json['use'];
    type = json['type'];
    if(json['line'] != null)
      line = json['line'].cast<String>();
    else
      line = null;
    city = json['city'];
    district = json['district'];
    state = json['state'];
    postalCode = json['postalCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.use != null) {
      data['use'] = this.use;
    }
    if (this.type != null) {
      data['type'] = this.type;
    }
    if (this.line != null) {
      data['line'] = this.line;
    }
    if (this.city != null) {
      data['city'] = this.city;
    }
    if (this.district != null) {
      data['district'] = this.district;
    }
    if (this.state != null) {
      data['state'] = this.state;
    }
    if (this.postalCode != null) {
      data['postalCode'] = this.postalCode;
    }
    return data;
  }
}

class Extension {
  String url;
  String valueString;
  CodeableConcept valueCodeableConcept;

  Extension({
    this.url,
    this.valueString,
    this.valueCodeableConcept,
  });

  factory Extension.fromRawJson(String str) =>
      Extension.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Extension.fromJson(Map<String, dynamic> json) => Extension(
        url: json["url"] == null ? null : json["url"],
        valueString: json["valueString"] == null ? null : json["valueString"],
        valueCodeableConcept: json["valueCodeableConcept"] == null
            ? null
            : CodeableConcept.fromJson(json["valueCodeableConcept"]),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.url != null) {
      data['url'] = this.url;
    }
    if (this.valueString != null) {
      data['valueString'] = this.valueString;
    }
    if (this.valueCodeableConcept != null) {
      data['valueCodeableConcept'] = this.valueCodeableConcept.toJson();
    }
    return data;
  }
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

  factory Coding.fromRawJson(String str) => Coding.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Coding.fromJson(Map<String, dynamic> json) => Coding(
        system: json["system"] == null ? null : json["system"],
        code: json["code"] == null ? null : json["code"],
        display: json["display"] == null ? null : json["display"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (this.system != null) data["system"] = this.system;
    if (this.code != null) data["code"] = this.code;
    if (this.display != null) data["display"] = this.display;
    return data;
  }
}

class Identifier {
  String use;
  CodeableConcept type;
  String system;
  String value;

  Identifier({
    this.use,
    this.type,
    this.system,
    this.value,
  });

  factory Identifier.fromRawJson(String str) =>
      Identifier.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Identifier.fromJson(Map<String, dynamic> json) => Identifier(
        use: json["use"] == null ? null : json["use"],
        type: json["type"] == null
            ? null
            : CodeableConcept.fromJson(json["type"]),
        system: json["system"] == null ? null : json["system"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.use != null) {
      data['use'] = this.use;
    }
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    if (this.system != null) {
      data['system'] = this.system;
    }
    if (this.value != null) {
      data['value'] = this.value;
    }
    return data;
  }
}

class Meta {
  String versionId;
  DateTime lastUpdated;

  Meta({
    this.versionId,
    this.lastUpdated,
  });

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        versionId: json["versionId"] == null ? null : json["versionId"],
        lastUpdated: json["lastUpdated"] == null
            ? null
            : DateTime.parse(json["lastUpdated"]),
      );
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.versionId != null) {
      data['versionId'] = this.versionId;
    }
    if (this.lastUpdated != null) {
      data['lastUpdated'] = lastUpdated.toIso8601String();
    }
    return data;
  }
}

class HumanName {
  String use;
  String text;
  String family;
  List<String> given;
  List<String> prefix;
  List<String> suffix;
  List<Period> period;

  HumanName(
      {this.use,
      this.text,
      this.family,
      this.given,
      this.prefix,
      this.suffix,
      this.period});

  factory HumanName.fromRawJson(String str) =>
      HumanName.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HumanName.fromJson(Map<String, dynamic> json) => HumanName(
        use: json["use"] == null ? null : json["use"],
        text: json["use"] == null ? null : json["text"],
        family: json["family"] == null ? null : json["family"],
        given: json["given"] == null
            ? null
            : List<String>.from(json["given"].map((x) => x)),
        prefix: json["prefix"] == null
            ? null
            : List<String>.from(json["prefix"].map((x) => x)),
        suffix: json["suffix"] == null
            ? null
            : List<String>.from(json["suffix"].map((x) => x)),
        period: json["period"] == null
            ? null
            : List<Period>.from(json["period"].map((x) => x)),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.use != null) {
      data['use'] = this.use;
    }
    if (this.text != null) {
      data['text'] = this.text;
    }
    if (this.family != null) {
      data['family'] = this.family;
    }
    if (this.given != null) {
      data['given'] = List<dynamic>.from(given.map((x) => x));
    }
    if (this.prefix != null) {
      data['prefix'] = List<dynamic>.from(prefix.map((x) => x));
    }
    if (this.suffix != null) {
      data['suffix'] = List<dynamic>.from(suffix.map((x) => x));
    }
    if (this.period != null) {
      data['period'] = List<dynamic>.from(period.map((x) => x));
    }
    return data;
  }
}

class FHIRText {
  String status;
  String div;

  FHIRText({
    this.status,
    this.div,
  });

  factory FHIRText.fromRawJson(String str) =>
      FHIRText.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FHIRText.fromJson(Map<String, dynamic> json) => FHIRText(
        status: json["status"] == null ? null : json["status"],
        div: json["div"] == null ? null : json["div"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (this.status != null) data["status"] = status;
    if (this.div != null) data["div"] = div;
    return data;
  }
}

class Response {
  String status;
  String etag;

  Response({
    this.status,
    this.etag,
  });

  factory Response.fromRawJson(String str) =>
      Response.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        status: json["status"] == null ? null : json["status"],
        etag: json["etag"] == null ? null : json["etag"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (this.status != null) data["status"] = this.status;
    if (this.etag != null) data["etag"] = this.etag;
    return data;
  }
}

class Search {
  String mode;

  Search({
    this.mode,
  });

  factory Search.fromRawJson(String str) => Search.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Search.fromJson(Map<String, dynamic> json) => Search(
        mode: json["mode"] == null ? null : json["mode"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (this.mode != null) data["mode"] = mode;
    return data;
  }
}

class Link {
  String relation;
  String url;

  Link({
    this.relation,
    this.url,
  });

  factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        relation: json["relation"] == null ? null : json["relation"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (this.relation != null) data["relation"] = relation;
    if (this.url != null) data["url"] = url;
    return data;
  }
}

class Dosage {
  int sequence;
  String text;
  Timing timing;
  CodeableConcept route;
  List<DoseAndRate> doseAndRate;

  Dosage({
    this.sequence,
    this.text,
    this.timing,
    this.route,
    this.doseAndRate,
  });

  factory Dosage.fromJson(Map<String, dynamic> json) => Dosage(
        sequence: json["sequence"] == null ? null : json["sequence"],
        text: json["text"] == null ? null : json["text"],
        timing: json["timing"] == null ? null : Timing.fromJson(json["timing"]),
        route: json["route"] == null
            ? null
            : CodeableConcept.fromJson(json["route"]),
        doseAndRate: json["doseAndRate"] == null
            ? null
            : List<DoseAndRate>.from(
                json["doseAndRate"].map((x) => DoseAndRate.fromJson(x))),
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (this.sequence != null) data["sequence"] = this.sequence;
    if (this.text != null) data["text"] = this.text;
    if (this.timing != null) data["timing"] = this.timing.toJson();
    if (this.route != null) data["route"] = this.route.toJson();
    if (this.doseAndRate != null)
      data["doseAndRate"] =
          List<dynamic>.from(doseAndRate.map((x) => x.toJson()));
    return data;
  }
}

class DoseAndRate {
  CodeableConcept type;

  DoseAndRate({
    this.type,
  });

  factory DoseAndRate.fromJson(Map<String, dynamic> json) => DoseAndRate(
        type: json["type"] == null
            ? null
            : CodeableConcept.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (this.type != null) data["type"] = this.type.toJson();
    return data;
  }
}

class Timing {
  Repeat repeat;

  Timing({
    this.repeat,
  });

  factory Timing.fromJson(Map<String, dynamic> json) => Timing(
        repeat: json["repeat"] == null ? null : Repeat.fromJson(json["repeat"]),
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (this.repeat != null) data["repeat"] = this.repeat.toJson();
    return data;
  }
}

class Repeat {
  int frequency;
  double period;
  String periodUnit;

  Repeat({
    this.frequency,
    this.period,
    this.periodUnit,
  });

  factory Repeat.fromJson(Map<String, dynamic> json) => Repeat(
        frequency: json["frequency"] == null ? null : json["frequency"],
        period: json["period"] == null ? null : json["period"],
        periodUnit: json["periodUnit"] == null ? null : json["periodUnit"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (this.frequency != null) data["frequency"] = frequency;
    if (this.period != null) data["period"] = period;
    if (this.periodUnit != null) data["periodUnit"] = periodUnit;
    return data;
  }
}

class EncounterParticipant {
  Period period;
  Reference individual;

  EncounterParticipant({this.period, this.individual});

  EncounterParticipant.fromJson(Map<String, dynamic> json) {
    period =
        json['period'] != null ? new Period.fromJson(json['period']) : null;
    individual = json['individual'] != null
        ? new Reference.fromJson(json['individual'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.period != null) {
      data['period'] = this.period.toJson();
    }
    if (this.individual != null) {
      data['individual'] = this.individual.toJson();
    }
    return data;
  }
}

class Reference {
  String reference;
  String display;

  Reference({
    this.reference,
    this.display,
  });

  factory Reference.fromRawJson(String str) =>
      Reference.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Reference.fromJson(Map<String, dynamic> json) => Reference(
        reference: json["reference"] == null ? null : json["reference"],
        display: json["display"] == null ? null : json["display"],
      );

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = {};
        if(this.reference != null) data["reference"] = this.reference;
        if(this.display != null) data["display"] = this.display;
        return data;
      }
}

class Period {
  DateTime start;
  DateTime end;

  Period({
    this.start,
    this.end,
  });

  factory Period.fromRawJson(String str) => Period.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Period.fromJson(Map<String, dynamic> json) => Period(
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        end: json["end"] == null ? null : DateTime.parse(json["end"]),
      );

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = {};
        if(this.start != null) data["start"] =  start.toIso8601String();
        if(this.end != null) data["end"] =  end.toIso8601String();
        print(data["start"]);
        print(data["end"]);
        return data;
      }
}
class CodeableConcept {
  List<Coding> coding;
  String text;

  CodeableConcept({
    this.coding,
    this.text,
  });

  factory CodeableConcept.fromRawJson(String str) =>
      CodeableConcept.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CodeableConcept.fromJson(Map<String, dynamic> json) =>
      CodeableConcept(
        coding: json["coding"] == null
            ? null
            : List<Coding>.from(json["coding"].map((x) => Coding.fromJson(x))),
        text: json["text"] == null ? null : json["text"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.text != null) {
      data['text'] = this.text;
    }
    if (this.coding != null) {
      data['coding'] = List<dynamic>.from(coding.map((x) => x.toJson()));
    }
    return data;
  }
}

class PractitionerQualification {
  List<Identifier> identifier;
  CodeableConcept code;

  PractitionerQualification({
    this.identifier,
    this.code,
  });

  factory PractitionerQualification.fromRawJson(String str) =>
      PractitionerQualification.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PractitionerQualification.fromJson(Map<String, dynamic> json) => PractitionerQualification(
        identifier: json["identifier"] == null
            ? null
            : List<Identifier>.from(
                json["identifier"].map((x) => Identifier.fromJson(x))),
        code: json["code"] == null
            ? null
            : CodeableConcept.fromJson(json["code"]),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.code != null) {
      data['code'] = this.code;
    }
    if (this.identifier != null) {
      data['identifier'] =
          List<dynamic>.from(identifier.map((x) => x.toJson()));
    }
    return data;
  }
}

class Quantity {
  int value;
  String unit;

  Quantity({
    this.value,
    this.unit,
  });

  factory Quantity.fromRawJson(String str) =>
      Quantity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Quantity.fromJson(Map<String, dynamic> json) => Quantity(
        value: json["value"] == null ? null : json["value"],
        unit: json["unit"] == null ? null : json["unit"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.value != null) {
      data['value'] = this.value;
    }
    if (this.unit != null) {
      data['unit'] = this.unit;
    }
    return data;
  }
}

class ContactPoint {
  String use;
  CodeableConcept type;
  String system;
  String value;

  ContactPoint({
    this.use,
    this.type,
    this.system,
    this.value,
  });

  factory ContactPoint.fromRawJson(String str) =>
      ContactPoint.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContactPoint.fromJson(Map<String, dynamic> json) => ContactPoint(
        use: json["use"] == null ? null : json["use"],
        type: json["type"] == null
            ? null
            : CodeableConcept.fromJson(json["type"]),
        system: json["system"] == null ? null : json["system"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.system != null) {
      data['system'] = this.system;
    }
    if (this.value != null) {
      data['value'] = this.value;
    }
    if (this.use != null) {
      data['use'] = this.use;
    }
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    return data;
  }
}

class Diagnosis {
  int sequence;
  Reference diagnosisReference;

  Diagnosis({
    this.sequence,
    this.diagnosisReference,
  });

  factory Diagnosis.fromRawJson(String str) =>
      Diagnosis.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Diagnosis.fromJson(Map<String, dynamic> json) => Diagnosis(
        sequence: json["sequence"] == null ? null : json["sequence"],
        diagnosisReference: json["diagnosisReference"] == null
            ? null
            : Reference.fromJson(json["diagnosisReference"]),
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> ret = {};
    if (sequence != null) ret["sequence"] = sequence;
    if (diagnosisReference != null)
      ret["diagnosisReference"] = diagnosisReference.toJson();
    return ret;
  }
}

class Item {
  int sequence;
  List<Reference> encounter;
  List<int> diagnosisSequence;

  Item({
    this.sequence,
    this.encounter,
    this.diagnosisSequence,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        sequence: json["sequence"] == null ? null : json["sequence"],
        encounter: json["encounter"] == null
            ? null
            : List<Reference>.from(
                json["encounter"].map((x) => Reference.fromJson(x))),
        diagnosisSequence: json["diagnosisSequence"] == null
            ? null
            : List<int>.from(json["diagnosisSequence"].map((x) => x)),
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> ret = {};
    if (sequence != null) ret["sequence"] = sequence;
    if (encounter != null)
      ret["encounter"] = List<dynamic>.from(encounter.map((x) => x.toJson()));
    if (diagnosisSequence != null)
      ret["diagnosisSequence"] =
          List<dynamic>.from(diagnosisSequence.map((x) => x));
    return ret;
  }
}

class Money {
  double value;
  String currency;

  Money({
    this.value,
    this.currency,
  });

  factory Money.fromRawJson(String str) => Money.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Money.fromJson(Map<String, dynamic> json) => Money(
        value: json["value"] == null ? null : json["value"].toDouble(),
        currency: json["currency"] == null ? null : json["currency"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> ret = {};
    if (value != null) ret["value"] = value;
    if (currency != null) ret["currency"] = currency;
    return ret;
  }
}

class Performer {
  Reference actor;

  Performer({this.actor});

  Performer.fromJson(Map<String, dynamic> json) {
    actor = json['actor'] != null ? new Reference.fromJson(json['actor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.actor != null) {
      data['actor'] = this.actor.toJson();
    }
    return data;
  }
}

class Location {
    Reference location;

    Location({
        this.location,
    });

    factory Location.fromRawJson(String str) => Location.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        location: json["location"] == null ? null : Reference.fromJson(json["location"]),
    );

    Map<String, dynamic> toJson() => {
        "location": location == null ? null : location.toJson(),
    };
}

class AppointmentParticipant {
  List<CodeableConcept> type;
  Reference actor;
  String status;

  AppointmentParticipant({this.type, this.actor, this.status});

  AppointmentParticipant.fromJson(Map<String, dynamic> json) {
    if (json['type'] != null) {
      type = new List<CodeableConcept>();
      json['type'].forEach((v) {
        type.add(new CodeableConcept.fromJson(v));
      });
    }
    actor = json['actor'] != null ? new Reference.fromJson(json['actor']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.type != null) {
      data['type'] = this.type.map((v) => v.toJson()).toList();
    }
    if (this.actor != null) {
      data['actor'] = this.actor.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status;
    }
    return data;
  }
}

class ClaimResponseItem {
  int itemSequence;
  List<ClaimResponseAdjudication> adjudication;

  ClaimResponseItem({this.itemSequence, this.adjudication});

  ClaimResponseItem.fromJson(Map<String, dynamic> json) {
    itemSequence = json['itemSequence'];
    if (json['adjudication'] != null) {
      adjudication = new List<ClaimResponseAdjudication>();
      json['adjudication'].forEach((v) {
        adjudication.add(new ClaimResponseAdjudication.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.itemSequence != null) {
      data['itemSequence'] = this.itemSequence;
    }
    if (this.adjudication != null) {
      data['adjudication'] = this.adjudication.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClaimResponseAdjudication {
  CodeableConcept category;
  Money amount;

  ClaimResponseAdjudication({this.category, this.amount});

  ClaimResponseAdjudication.fromJson(Map<String, dynamic> json) {
    category = json['category'] != null
        ? new CodeableConcept.fromJson(json['category'])
        : null;
    amount =
        json['amount'] != null ? new Money.fromJson(json['amount']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    if (this.amount != null) {
      data['amount'] = this.amount.toJson();
    }
    return data;
  }
}

class ClaimResponseInsurance {
  int sequence;
  bool focal;
  Reference coverage;

  ClaimResponseInsurance({this.sequence, this.focal, this.coverage});

  ClaimResponseInsurance.fromJson(Map<String, dynamic> json) {
    sequence = json['sequence'];
    focal = json['focal'];
    coverage = json['coverage'] != null
        ? new Reference.fromJson(json['coverage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sequence != null) {
      data['sequence'] = this.sequence;
    }
    if (this.focal != null) {
      data['focal'] = this.focal;
    }
    if (this.coverage != null) {
      data['coverage'] = this.coverage.toJson();
    }
    return data;
  }
}
