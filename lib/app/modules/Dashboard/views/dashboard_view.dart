import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () => controller.backToLogin(),
              child: Text("Back to Login",style: TextStyle(color: Colors.white),))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => controller.allData.value.data == null
                ? Center(child: Text("No Records Found"))
                : ListView.builder(
                    itemCount: controller.allData.value.data?.length,
                    itemBuilder: (_, index) {
                      var data = controller.allData.value.data?[index];
                      return Card(
                          child: ExpansionTile(
                        title: Text("${data?.username}"),
                        subtitle: Text("${data?.email}"),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        expandedAlignment: Alignment.centerLeft,

                        children:
                            List.generate(data!.contacts!.length, (childIndex) {
                          var childData = data.contacts![childIndex];
                          return Text("${childData.name}").marginSymmetric(horizontal: 16,vertical: 8);
                        }),
                      )).marginSymmetric(horizontal: 16, vertical: 4);
                    })),
          )
        ],
      ),
    );
  }
}
