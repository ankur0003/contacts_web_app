import 'package:contacts_web_app/app/common/Constants.dart';
import 'package:contacts_web_app/app/common/Storage.dart';
import 'package:contacts_web_app/app/data/ApiProvider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put<ApiProvider>(ApiProvider());

  runApp(const MyApp()
  );
}

class MyApp extends StatelessWidget{
const MyApp({Key? key}):super(key:key);
@override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      title: "Application",
      initialRoute:  AppPages.INITIAL,
      getPages: AppPages.routes,
    );

  }
}
