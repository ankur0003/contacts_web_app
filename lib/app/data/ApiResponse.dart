import 'dart:convert';

import 'package:contacts_web_app/app/common/NetworkManager.dart';
import 'package:get/get_connect/connect.dart';

class ApiResponse {
  static const ApiResponse instance = ApiResponse._internal();

  factory ApiResponse() => instance;

  const ApiResponse._internal();

  APIManager<T>? getResponse<T>(Response<T> response) {
    final status = response.status;

    try {

      if (response.statusCode == 200 || response.statusCode == 201) {
        return APIManager<T>(success: true, data: response.body as T,code: response.statusCode);

      } else if (status.isUnauthorized) {
        return APIManager<T>(success: false, error: "Network Request Failed with status: ${response.statusCode}",code: response.statusCode);
      }else{
        return APIManager<T>(success: false, error: "Network Request Failed with status: ${response.statusCode}",code: response.statusCode);

      }
    }catch (e) {
      return APIManager(success: false,error: "An error occured: ${e.toString()}");
    }
    return null;
  }
}
