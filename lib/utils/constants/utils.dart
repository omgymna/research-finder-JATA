import 'package:flutter/material.dart';
import '../../main.dart';
import 'colors.dart';

class Utils{

  static progressDialog({
    required BuildContext context,
    required String text,
  }) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: Colors.white,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: AppColor.primaryColor,),
              SizedBox(height: w*.05,),
              Text(text, textAlign: TextAlign.center, style: const TextStyle(
                  fontSize: 18, color: Colors.black, decoration: TextDecoration.none
              ), )
            ],),
        ));
  }

  static void toast(BuildContext context, String message){
    var snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}
