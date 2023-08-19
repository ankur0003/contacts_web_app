import 'package:contacts_web_app/app/common/GetResponse.dart';
import 'package:contacts_web_app/app/common/Storage.dart';
import 'package:contacts_web_app/app/common/widget_utils.dart';
import 'package:contacts_web_app/app/data/ApiProvider.dart';
import 'package:contacts_web_app/app/data/ApiResponse.dart';
import 'package:contacts_web_app/app/data/models/MyContacts.dart';
import 'package:contacts_web_app/app/data/models/UserDetail.dart';
import 'package:contacts_web_app/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ApiProvider _apiProvider = Get.find();
  final user = UserDetail().obs;
  RxList<MyContacts> myContacts = RxList([]);
  var nameCtr = TextEditingController();
  var emailCtr = TextEditingController();
  var phoneCtr = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getUserDetail();
  }

  void getUserDetail() {
    LoadingDialog();
    _apiProvider.getCurrentUserDetails().then((value) {
      CloseDialog();
      print("cajkbcjashbcjhsdcbhjsdc${value.body?.username}");
      var response = ApiResponse.instance.getResponse(value);
      if (response != null && response.success) {
        user.value = response.data!;
        fetchContacts();
      } else if (response?.code == 401) {
        ShowDialog(null, () {
          Storage.clear();
          Get.offAllNamed(Routes.LOGIN);
        });
      }else{
        ShowSnackbar(response?.error ?? "Error");

      }
    });
  }

  void fetchContacts() {
    _apiProvider.fetchContacts().then((value) {
      print("My contacts===> $value");
      var response = ApiResponse.instance.getResponse(value);
      if (response != null && response.success) {
        GetResponse _response = response.data;
        if(myContacts.isNotEmpty){
          myContacts.clear();
        }
        myContacts.value = _response.list as List<MyContacts>;
      }else{
        ShowSnackbar(response?.error ?? "Error");

      }
    });
  }

  void addContact() {
    LoadingDialog();
    var map = {
      "name": nameCtr.text.trim(),
      "email": emailCtr.text.trim(),
      "phone": phoneCtr.text.trim()
    };
    _apiProvider.addContact(map).then((value) {
      CloseDialog();
      var response = ApiResponse.instance.getResponse(value);
      if (response != null && response.success) {
        ShowDialog("Contact Addedd Successfully", () {
          CloseDialog();
          fetchContacts();
        }, title: "Success", btnText: "Ok");
      }else{
        ShowSnackbar(response?.error ?? "Error");
      }
    });
  }


  deleteContact(String id) {
    LoadingDialog();
    _apiProvider.deleteContact(id).then((value) {
      CloseDialog();
      var response = ApiResponse.instance.getResponse(value);
      if(response!=null && response.success){
        ShowSnackbar("Contact Deleted Succesfully");
        fetchContacts();
      }else{
        ShowSnackbar(response?.error ?? "Error");

      }
    });
  }
}
