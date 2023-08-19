import 'package:contacts_web_app/app/common/Constants.dart';
import 'package:contacts_web_app/app/common/GetResponse.dart';
import 'package:contacts_web_app/app/common/Storage.dart';
import 'package:contacts_web_app/app/data/ApiHelper.dart';
import 'package:contacts_web_app/app/data/models/AccessToken.dart';
import 'package:contacts_web_app/app/data/models/MyContacts.dart';
import 'package:contacts_web_app/app/data/models/UserDetail.dart';
import 'package:get/get.dart';

class ApiProvider extends GetConnect with ApiHelper {
  @override
  void onInit() {
    httpClient.baseUrl = "https://contacts-save.onrender.com/api/";

    addRequestModifier();
    addResponseModifier();
  }

  void addRequestModifier() {
    httpClient.addRequestModifier<dynamic>((request) {
      if (Storage.hasData(Constants.token)) {
        request.headers['Authorization'] =
            "Bearer ${Storage.get(Constants.token)}";
      }
      print(
         'REQUEST ║ ${request.method.toUpperCase()}\n'
            'url: ${request.url}\n'
            'Headers: ${request.headers}\n'
            'Body: ${request.files?.toString() ?? ''}\n',
      );

      return request;
    });
  }

  void addResponseModifier() {
    httpClient.addResponseModifier((request, response) {
      print(
         'Status Code: ${response.statusCode}\n'
            'Data: ${response.bodyString?.toString() ?? ''}',
      );
      return response;
    });
  }

  @override
  Future<Response<AccessToken>> login(Map<String, String> map) {
    return post("user/login", map,
        decoder: (data) => AccessToken.fromJson(data));
  }

  @override
  Future<Response<UserDetail>> getCurrentUserDetails() {
    return get("user/current", decoder: (data) => UserDetail.fromJson(data));
  }

  @override
  Future<Response> addContact(Map<String, String> map) {
    return post("contacts", map, decoder: (data) => MyContacts.fromJson(data));
  }

  @override
  Future<Response> deleteContact(String id) {
    return delete("contacts/${id}", decoder: (data) => MyContacts.fromJson(data));
  }

  @override
  Future<Response> fetchContacts() {
    return get("contacts",
        decoder: (data) =>
            GetResponse<MyContacts>.fromJson(data, (dynamic element) {
              return MyContacts.fromJson(element);
            }));
  }

  @override
  Future<Response> updateContact(String id) {
    // TODO: implement updateContact
    throw UnimplementedError();
  }
}
