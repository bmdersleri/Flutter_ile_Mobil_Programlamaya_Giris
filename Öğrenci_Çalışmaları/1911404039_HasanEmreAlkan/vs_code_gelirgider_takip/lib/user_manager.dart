import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vs_code_gelirgider_takip/user.dart';

class UserManager {
  Stream<List<User>> readUser() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

  Future createUser(User user) async {
    final docIslem = FirebaseFirestore.instance.collection('users').doc();
    user.id = docIslem.id;
    final json = user.toJson();

    await docIslem.set(json);
  }
}
