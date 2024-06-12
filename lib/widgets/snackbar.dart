import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  static CustomSnackBar get instance => Get.find();

  static void showSnackBar({required BuildContext context,required String message,Duration duration = const Duration(seconds: 1),}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: duration,
      ),
    );
  }

  static void showSnackBarError({required BuildContext context,required String message,Duration duration = const Duration(seconds: 1),}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onError,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
        duration: duration,
      ),
    );
  }

}

