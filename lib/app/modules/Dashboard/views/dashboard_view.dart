import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashboardView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(
            'DashboardView is working',
            style: TextStyle(fontSize: 20),
          ),

          Expanded(
            child: Obx(
                ()=>ListView.builder(
                  itemCount: controller.allData.value.data?.length,

                    itemBuilder: (_,index){
                    var data = controller.allData.value.data?[index];
                      return ExpansionTile(
                        title: Text("${data?.username}"),
                        subtitle: Text("${data?.email}"),
                        children:List.generate(data!.contacts!.length, (childIndex) {
                          var childData = data.contacts![childIndex];
                          return Text("${childData.name}");
                        }),
                      );
                    }

                )
            ),
          )
        ],
      ),
    );
  }
}
