import 'package:flutter/material.dart';

class AlertUtil {
  static void showAlert(BuildContext context, String title, String message,
      {String buttonText = "Tamam"}) {
    var alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(buttonText)),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}