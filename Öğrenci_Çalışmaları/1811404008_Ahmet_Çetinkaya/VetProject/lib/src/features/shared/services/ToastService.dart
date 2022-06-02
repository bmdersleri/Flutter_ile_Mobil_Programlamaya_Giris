import 'package:flutter/material.dart';

class ToastService {
  static showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 35),
    ));
  }
}
