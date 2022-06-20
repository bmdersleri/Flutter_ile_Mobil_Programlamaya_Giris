import 'package:flutter/cupertino.dart';
import 'package:sut_cepte_mobile_app/model/maliyet_tip.dart';

class MalitetListelePoriver extends ChangeNotifier {
  List<MaliyetModel> _liste = [];

  void addItem(MaliyetModel model) {
    _liste.add(model);
    notifyListeners();
  }

  List getList() {
    return _liste;
  }

  void listRemove(int index) {
    _liste.removeAt(index);
    notifyListeners();
  }
}
