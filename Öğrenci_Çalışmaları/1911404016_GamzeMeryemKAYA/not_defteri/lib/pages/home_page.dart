import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:not_defteri/pages/login_page.dart';
import 'package:not_defteri/pages/note_add_page.dart';
import 'package:not_defteri/providers/all_providers.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late FirebaseFirestore _firestore;
  late FirebaseAuth _auth;
  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
    _auth = FirebaseAuth.instance;
    notlariGetir();
  }

  Map<String, Color> renkler = {
    'Kırmızı': Colors.red,
    'Turuncu': Colors.orange,
    'Yeşil': Colors.green
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Ana Sayfa'),
        actions: [
          IconButton(
              onPressed: () async {
                await _auth
                    .signOut()
                    .whenComplete(() => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                        (route) => false));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteAddPage(),
              ));
        },
        child: const Icon(Icons.note_add),
      ),
      body: SafeArea(
          child: ref.watch(tumNotlarProvider) == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ref.watch(tumNotlarProvider)!.isEmpty
                  ? const Center(
                      child: Text('Kayıtlı Not Yok ! ! !'),
                    )
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: ref.watch(seciliButonProvider)[0]
                                        ? Colors.green
                                        : Colors.blue),
                                onPressed: () {
                                  ref
                                      .read(seciliButonProvider.notifier)
                                      .update((state) => [true, false, false]);
                                  List<
                                          QueryDocumentSnapshot<
                                              Map<String, dynamic>>>
                                      tamamlananlar = [];
                                  for (var element
                                      in ref.watch(tumNotlarProvider)!) {
                                    element.data()['tamamlandiMi']
                                        ? tamamlananlar.add(element)
                                        : null;
                                  }
                                  ref
                                      .read(tamamlananNotlarProvider.notifier)
                                      .update((state) => tamamlananlar);
                                },
                                child: const Text('Tamamlananlar')),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: ref.watch(seciliButonProvider)[1]
                                        ? Colors.green
                                        : Colors.blue),
                                onPressed: () {
                                  ref
                                      .read(seciliButonProvider.notifier)
                                      .update((state) => [false, true, false]);
                                },
                                child: const Text('Hepsi')),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: ref.watch(seciliButonProvider)[2]
                                        ? Colors.green
                                        : Colors.blue),
                                onPressed: () {
                                  ref
                                      .read(seciliButonProvider.notifier)
                                      .update((state) => [false, false, true]);
                                  List<
                                          QueryDocumentSnapshot<
                                              Map<String, dynamic>>>
                                      devamedenler = [];
                                  for (var element
                                      in ref.watch(tumNotlarProvider)!) {
                                    element.data()['tamamlandiMi']
                                        ? null
                                        : devamedenler.add(element);
                                  }
                                  ref
                                      .read(devamedenNotlarProvider.notifier)
                                      .update((state) => devamedenler);
                                },
                                child: const Text('Devam Edenler'))
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: ref.watch(seciliButonProvider)[1]
                                ? ref.watch(tumNotlarProvider)!.length
                                : ref.watch(seciliButonProvider)[0]
                                    ? ref
                                        .watch(tamamlananNotlarProvider)!
                                        .length
                                    : ref
                                        .watch(devamedenNotlarProvider)!
                                        .length,
                            itemBuilder: (context, index) {
                              var gosterilecekNotlar =
                                  ref.watch(seciliButonProvider)[1]
                                      ? ref.watch(tumNotlarProvider)!
                                      : ref.watch(seciliButonProvider)[0]
                                          ? ref.watch(tamamlananNotlarProvider)!
                                          : ref.watch(devamedenNotlarProvider)!;
                              var tarih = (gosterilecekNotlar[index]
                                      .data()['tarih'] as Timestamp)
                                  .toDate();
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Map<String, dynamic> seciliNot =
                                        gosterilecekNotlar[index].data();
                                    ref
                                        .read(secilenGunProvider.notifier)
                                        .update((state) =>
                                            (seciliNot['tarih'] as Timestamp)
                                                .toDate());
                                    ref
                                        .read(onemDerecesiProvider.notifier)
                                        .update((state) =>
                                            seciliNot['onemDerecesi']);
                                    seciliNot['resimUrl'] != null
                                        ? ref
                                            .read(resimWidgetProvider.notifier)
                                            .update((state) => ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.network(
                                                  seciliNot['resimUrl'],
                                                  fit: BoxFit.fill,
                                                )))
                                        : null;
                                    seciliNot['resimUrl'] != null
                                        ? ref
                                            .read(resimUrlProvider.notifier)
                                            .update((state) =>
                                                seciliNot['resimUrl'])
                                        : null;
                                    ref
                                        .read(tamamlandiMiProvider.notifier)
                                        .update((state) =>
                                            seciliNot['tamamlandiMi']);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NoteAddPage(
                                            seciliNot: seciliNot,
                                          ),
                                        ));
                                  },
                                  child: Material(
                                    elevation: 16,
                                    borderRadius: BorderRadius.circular(15),
                                    child: Dismissible(
                                      direction: DismissDirection.startToEnd,
                                      background: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.delete),
                                          Text(' Bu Not Silindi')
                                        ],
                                      ),
                                      key: Key(gosterilecekNotlar[index].id),
                                      onDismissed: (direction) {
                                        notSil(
                                            gosterilecekNotlar[index].data());
                                      },
                                      child: ListTile(
                                        leading: gosterilecekNotlar[index]
                                                .data()['tamamlandiMi']
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Icon(
                                                    Icons.check,
                                                    color: Colors.green,
                                                    size: 30,
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Icon(
                                                    Icons.access_time_outlined,
                                                    color: Colors.grey,
                                                    size: 30,
                                                  ),
                                                ],
                                              ),
                                        title: Text(
                                          gosterilecekNotlar[index]
                                              .data()['baslik'],
                                          style: TextStyle(
                                              decoration: gosterilecekNotlar[
                                                          index]
                                                      .data()['tamamlandiMi']
                                                  ? TextDecoration.lineThrough
                                                  : null),
                                        ),
                                        subtitle: Text(DateFormat('dd.MM.yyyy')
                                            .format(tarih)),
                                        trailing: CircleAvatar(
                                          backgroundColor: renkler[
                                              gosterilecekNotlar[index]
                                                  .data()['onemDerecesi']],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )),
    );
  }

  void notlariGetir() async {
    debugPrint('1. yer');
    try {
      await _firestore
          .collection(_auth.currentUser!.email.toString())
          .get()
          .then((value) {
        debugPrint('2. yer');
        var notlar = value.docs;
        debugPrint('3. yer');
        if (notlar.isNotEmpty) {
          ref.read(tumNotlarProvider.notifier).update((state) => notlar);
          List<String> notBasliklari = [];
          for (var element in notlar) {
            notBasliklari.add(element.data()['baslik']);
          }
          ref
              .read(notBasliklariProvider.notifier)
              .update((state) => notBasliklari);
        } else {
          ref.read(tumNotlarProvider.notifier).update((state) => []);
          ref.read(notBasliklariProvider.notifier).update((state) => []);
        }
      });
    } catch (e) {
      debugPrint('HATA : ------>>>>>> ${e.toString()}');
    }
  }

  void notSil(Map<String, dynamic> silinecekNot) async {
    await _firestore
        .doc(
            '${_auth.currentUser!.email.toString()}/${silinecekNot['baslik'].toString().replaceAll(' ', '').trim()}')
        .delete()
        .whenComplete(() async {
      if (silinecekNot['resimUrl'] != null) {
        FirebaseStorage.instance
            .ref('resimler/${silinecekNot['baslik']}')
            .delete();
      }

      notlariGetir();
    });
  }
}
