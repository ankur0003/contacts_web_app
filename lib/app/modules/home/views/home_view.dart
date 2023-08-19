import 'package:contacts_web_app/app/common/Storage.dart';
import 'package:contacts_web_app/app/common/widget_utils.dart';
import 'package:contacts_web_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                ShowDialog("You will be logged out...!", () {
                  Storage.clear();
                  Get.offAllNamed(Routes.LOGIN);
                },btnText: "Logout");
              },
              icon: Icon(Icons.power_settings_new))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _AddContactsDialog(
              controller.nameCtr, controller.emailCtr, controller.phoneCtr, () {
                if(controller.nameCtr.text.isEmpty || controller.emailCtr.text.isEmpty || controller.phoneCtr.text.isEmpty){
                  ShowSnackbar("Please enter all the required fields");
                  return;
                }
            CloseDialog();
            controller.addContact();
          });
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Obx(
            () => Text(
              "Welcome ${controller.user.value.username ?? ""}",
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Obx(
              () =>controller.myContacts.isEmpty?

                  Text("No Contacts Yet.\nStart Adding Contacts")
                  : ListView.builder(
                itemBuilder: (_, index) {
                  var data = controller.myContacts.value[index];
                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction)=>controller.deleteContact(data.sId!),
                    key: Key(data.email!),
                    background: Container(
                        color:Colors.red,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.delete,color: Colors.white,)).paddingSymmetric(horizontal: 22),
                    ),

                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data.name}",
                            style: CustomTextStyle(weight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${data.email}",
                                style: CustomTextStyle(
                                    weight: FontWeight.w500, color: Colors.grey),
                              ),
                              Text(
                                "${data.phone}",
                                style: CustomTextStyle(
                                    weight: FontWeight.w500, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 16, vertical: 12),
                    ),
                  );
                },
                itemCount: controller.myContacts.value.length,
              ),
            ),
          )
          /* CustomTextFormField(
              TextEditingController(), "Name", " Enter your name"),
          SizedBox(height: 20,),
          CustomTextFormField(TextEditingController(), "Designation",
              " Enter your designation"),*/
        ],
      ).paddingAll(16),
    );
  }

  _AddContactsDialog(
      TextEditingController nameCtr,
      TextEditingController emailCtr,
      TextEditingController phoneCtr,
      VoidCallback tap) {
    return Get.defaultDialog(
    title:"Add Contact",
    content:  SingleChildScrollView(
        child: Center(
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(nameCtr, "Enter your Name", "Name"),
                SizedBox(
                  height: 16,
                ),
                CustomTextFormField(emailCtr, "Enter your Email", "Email"),
                SizedBox(
                  height: 16,
                ),
                CustomTextFormField(phoneCtr, "Enter your Phone", "Phone"),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: Get.width*0.3,
                  child: ElevatedButton(
                    onPressed:  tap,
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        padding: const EdgeInsets.all(22),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22))),
                    child: const Text("Add"),
                  ),
                ),
              ],
            ),
          ),
        ).paddingAll(12),
      ),
      barrierDismissible: true,
    );
  }
}
