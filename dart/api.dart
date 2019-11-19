import 'package:http/http.dart' show Client;
import 'fhir.dart';
import 'dart:convert';


class SearchApiService {
  String baseUrl;
  String token;
  Client client = Client();
  
  SearchApiService(this.baseUrl, this.token);

  
  Future<Bundle> search(String resource, [Map<String,String> criteria= null]) async{
    String criteriastr="";
    if(criteria != null)
      criteria.forEach((k,v) => criteriastr +=(k + "=" + v + "&"));
    String url=baseUrl + "/" + resource +"?"+ criteriastr +"_format=json&_count=500";
    final response = await  client.get(url, headers: {"content-type": "application/fhir+json", "Authorization": "Basic $token"});
    return Bundle.fromRawJson(response.body);
  }
}

class ResourceApiService {
  String baseUrl;
  String token;
  Client client = Client();
  
  ResourceApiService(this.baseUrl, this.token);

  
  Future<Resource> getById(String resourceType, String Id) async{
    String url=baseUrl + resourceType +"/"+ Id +"?_format=json";
    final response = await  client.get(url, headers: {"content-type": "application/fhir+json", "Authorization": "Basic $token"});
    return getResource(json.decode(response.body));
    
  }
  Future<int> create(String resourceType, Resource resource) async{
    String url=baseUrl + resourceType;
   
    final response = await client.post(url, body: resource.toRawJson(), headers: {"content-type": "application/fhir+json", "Authorization": "Basic $token"});
     return response.statusCode;
  }
  Future<int> delete(String resourceType, String Id) async{
    String url=baseUrl + resourceType +"/"+ Id;
    final response = await  client.delete(url, headers: {"content-type": "application/fhir+json", "Authorization": "Basic $token"});
    return response.statusCode;
  }
  Future<int> update(String resourceType, Resource resource) async{
    String url=baseUrl + resourceType+"/"+resource.id;
    final response = await client.put(url, body: resource.toRawJson(), headers: {"content-type": "application/fhir+json", "Authorization": "Basic $token"});
    return response.statusCode;
  }

}
