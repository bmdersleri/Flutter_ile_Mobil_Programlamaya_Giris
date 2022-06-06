import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme_flutter/models/services.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<dynamic> uploadService({
    required String namesurname,
    required String brand,
    required String bmodel,
    required String kmnow,
    required String kmtogo,
    required List<bool> trufal,
  }) async {
    String res = "Some error occurred";

    try {
      String serviceId = const Uuid().v1();

      if (namesurname.isNotEmpty ||
          brand.isNotEmpty ||
          bmodel.isNotEmpty ||
          kmnow.isNotEmpty ||
          kmtogo.isNotEmpty ||
          trufal.isNotEmpty) {
        Services services = Services(
          namesurname: namesurname,
          brand: brand,
          bmodel: bmodel,
          kmnow: kmnow,
          kmtogo: kmtogo,
          serviceId: serviceId,
          datePublished: DateTime.now(),
          trufal: trufal,
        );

        await _firestore
            .collection('services')
            .doc(serviceId)
            .set(services.toJson());
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
