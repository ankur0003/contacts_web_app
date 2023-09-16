import 'package:get/get_connect/http/src/response/response.dart';

abstract class ApiHelper{
  Future<Response> login(Map<String,String> map);
  Future<Response> getCurrentUserDetails();
  Future<Response> addContact(Map<String,String> map);
  Future<Response> fetchContacts();
  Future<Response> deleteContact(String id);
  Future<Response> updateContact(String id);
  Future<Response> getAllData();


}