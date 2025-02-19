import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarHelper {
  static void showErrorSnackBar(String message, {String title = "Error"}) {
    final screenWidth = MediaQuery.of(Get.context!).size.width;
    // final margin = screenWidth >= 300 ? EdgeInsets.symmetric(horizontal: 300) : EdgeInsets.zero;
    final margin = EdgeInsets.symmetric(horizontal: screenWidth * 0.1);


    Get.snackbar(
      title == "Error" ? "Erreur" : "",
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      borderRadius: 20,
      margin: margin,
      duration: Duration(seconds: 3),
      icon: Icon(Icons.error, color: Colors.white),
      snackPosition: SnackPosition.TOP
    );
  }

  static void showSuccessSnackBar(String message, {String title = "Success"}) {
    final screenWidth = MediaQuery.of(Get.context!).size.width;
    // final margin = screenWidth >= 300 ? EdgeInsets.symmetric(horizontal: 300) : EdgeInsets.zero;
      final margin = EdgeInsets.symmetric(horizontal: screenWidth * 0.1);

    Get.snackbar(
      title == "Success" ? "Succès":"",
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      borderRadius: 20,
      margin: margin,
      duration: Duration(seconds: 3),
      icon: Icon(Icons.check_circle, color: Colors.white),
      snackPosition: SnackPosition.TOP
    );
  }
}
