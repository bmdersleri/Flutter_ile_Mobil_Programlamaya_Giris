import 'package:cloud_firestore/cloud_firestore.dart';
import 'islem.dart';

class IslemManager {
  Stream<List<Islem>> readIslemler() => FirebaseFirestore.instance
      .collection('islemler')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Islem.fromJson(doc.data())).toList());

  Future createIslem(Islem islem) async {
    final docIslem = FirebaseFirestore.instance.collection('islemler').doc();
    islem.id = docIslem.id;
    final json = islem.toJson();

    await docIslem.set(json);
  }

}
