import 'package:flutter/material.dart';

class MessageSnackBar {
  void showSuccessSnackBar(
      {required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: Theme.of(context).textTheme.headline2,
      ),
      backgroundColor: Colors.greenAccent,
    ));
  }

  void showErrorSnackBar(
      {required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: Theme.of(context).textTheme.headline2,
      ),
      backgroundColor: Colors.redAccent,
    ));
  }
}
