import 'package:flutter/material.dart';
import 'package:get/get.dart';

ShowDialog(String? msg, VoidCallback? onTap,{String title="Alert",String btnText = "Login"}) {
  return Get.defaultDialog(
    title: title,
    barrierDismissible: false,
    content: Text(msg ?? "Session Expired \n Please Login Again"),
    confirm: onTap == null
        ? const SizedBox.shrink()
        : MaterialButton(
            onPressed: () => onTap.call(),
            child: Text(btnText),
          ),
  );
}

LoadingDialog() {
  return Get.dialog(
      Center(
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          height: 60,
          width: 60,
          child: const CircularProgressIndicator(
            color: Colors.blue,
            strokeWidth: 2,
          ),
        ),
      ),
      barrierDismissible: false);
}

CloseDialog() {
  if (Get.isDialogOpen!) {
    Get.back();
  }
}

CustomTextFormField(TextEditingController controller,String hintText,String labelText){
  return TextFormField(

    controller:controller ,

    decoration: InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 14),
      isDense: true,
      hintText: hintText,
      labelText: labelText,
      enabledBorder: _Outlineborder(Colors.black),
      focusedBorder: _Outlineborder(Colors.black),
    ),
  );
}
_Outlineborder(Color color){
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(color: color)
  );
}

TextStyle CustomTextStyle({FontWeight weight = FontWeight.normal,Color color = Colors.black}){
  return TextStyle(
    fontWeight: weight,
    color: color
  );
}

ShowSnackbar(String message,{String title="Alert"}){
  return Get.snackbar(title, message,duration: Duration(seconds: 3));
}

