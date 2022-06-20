import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int counter = 0;
  increment() {
    counter++;
    notifyListeners();
  }

  decrement() {
    counter--;
    notifyListeners();
  }
}
