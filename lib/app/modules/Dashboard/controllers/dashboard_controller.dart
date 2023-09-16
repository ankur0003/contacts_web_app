import 'package:contacts_web_app/app/common/widget_utils.dart';
import 'package:contacts_web_app/app/data/ApiProvider.dart';
import 'package:contacts_web_app/app/data/models/AllData.dart';
import 'package:contacts_web_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final ApiProvider _provider = Get.find();
  var allData = AllData().obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    fetchAllData();

  }
  void fetchAllData(){
    LoadingDialog();
    _provider.getAllData().then((value) {
      CloseDialog();
      if(value.status.isOk && value.body!=null){
        allData.value = value.body as AllData;
      }
    });
  }
  @override
  void onClose() {
    super.onClose();
  }

  void backToLogin() {
    Get.offNamed(Routes.LOGIN);
  }

}
