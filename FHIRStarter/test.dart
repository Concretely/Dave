//import 'dart:convert';
//import 'fhir.dart';
import 'package:intl/intl.dart';

void main(){
  String ts = "2019-11-12T12:00:00Z";
  DateTime dt = DateTime.parse(ts);
  //DateFormat.y
  print(new DateFormat.yMd().add_jm().format(dt));
  /*
  Money m = new Money();
  m.currency="USD";
  m.value=null;
  print(json.encode(m.toJson()));
*/
}