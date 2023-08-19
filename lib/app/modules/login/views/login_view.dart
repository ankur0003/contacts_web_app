import 'package:contacts_web_app/app/common/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
                controller.emailController, "Enter your email", "Email"),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(controller.passwordController,
                "Enter  your password", "Password"),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              width: Get.width * 0.6,
              child: ElevatedButton(
                onPressed: () => controller.loginUser(),
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    padding: const EdgeInsets.all(22),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22))),
                child: const Text("Login"),
              ),
            )
          ],
        ).paddingAll(16),
      ),
    );
  }
}
