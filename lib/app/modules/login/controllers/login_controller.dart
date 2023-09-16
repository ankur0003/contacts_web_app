import 'package:contacts_web_app/app/common/Constants.dart';
import 'package:contacts_web_app/app/common/Storage.dart';
import 'package:contacts_web_app/app/common/widget_utils.dart';
import 'package:contacts_web_app/app/data/ApiProvider.dart';
import 'package:contacts_web_app/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ApiProvider _provider = Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    if (Storage.hasData(Constants.token)) {
      Get.offAllNamed(Routes.HOME);
    }
  }

  void loginUser() {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      ShowSnackbar("Please enter required Credentials");
      return;
    }
    var map = {
      "email": emailController.text.trim(),
      "password": passwordController.text.trim()
    };
    LoadingDialog();

    _provider.login(map).then((value) {
      if (value.status.isOk && value.body != null) {
        var token = value.body?.accessToken;
        CloseDialog();
        print("Access token $token");

        Storage.save(Constants.token, token);
        Get.offNamed(Routes.HOME);
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  void viewDashboard() {
    Get.offNamed(Routes.DASHBOARD);
  }
}
