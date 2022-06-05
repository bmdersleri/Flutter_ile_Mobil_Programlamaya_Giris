
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final secilenGunProvider = StateProvider<DateTime>((ref) => DateTime.now(),);


final resimWidgetProvider = StateProvider<Widget?>((ref) => null);
final resimUrlProvider = StateProvider<String?>((ref) => null,);


final onemDerecesiProvider = StateProvider<String>((ref) => 'Yeşil');

final tumNotlarProvider = StateProvider<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>((ref) => null,);

final tamamlananNotlarProvider = StateProvider<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>((ref) => null,);

final devamedenNotlarProvider = StateProvider<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>((ref) => null,);

final notBasliklariProvider = StateProvider<List<String>>((ref) => [],);

final tamamlandiMiProvider = StateProvider<bool>((ref) => false,);

final seciliButonProvider = StateProvider<List<bool>>((ref) => [false, true, false],);