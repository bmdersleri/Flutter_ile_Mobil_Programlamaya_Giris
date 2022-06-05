import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:not_defteri/model/not.dart';
import 'package:not_defteri/pages/home_page.dart';
import 'package:not_defteri/providers/all_providers.dart';

class NoteAddPage extends ConsumerStatefulWidget {
  NoteAddPage({Key? key, this.seciliNot}) : super(key: key);
  Map<String, dynamic>? seciliNot;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NoteAddPageState();
}

class _NoteAddPageState extends ConsumerState<NoteAddPage> {
  late FirebaseFirestore _firestore;
  late FirebaseAuth _auth;
  TextEditingController notBaslikController = TextEditingController();
  TextEditingController notIcerikController = TextEditingController();
  final baslikKey = GlobalKey<FormState>();
  final icerikKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
    _auth = FirebaseAuth.instance;
    if (widget.seciliNot != null) {
      gelenDegerleriYerineKoy(widget.seciliNot!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        ref.read(secilenGunProvider.notifier).update((state) => DateTime.now());
        ref.read(onemDerecesiProvider.notifier).update((state) => 'Yeşil');
        ref.read(resimUrlProvider.notifier).update((state) => null);
        ref.read(resimWidgetProvider.notifier).update((state) => null);
        ref.read(tamamlandiMiProvider.notifier).update((state) => false);
        ref
            .read(seciliButonProvider.notifier)
            .update((state) => [false, true, false]);
        return Future.value(true);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: const Text('Not Kaydet'),
          actions: [
            IconButton(
                onPressed: () {
                  notuKaydet();
                },
                icon: const Icon(Icons.check))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Visibility(
                  visible: widget.seciliNot != null,
                  child: Expanded(
                    child: Center(
                      child: CheckboxListTile(
                        title: const Text('Tamamlandı Mı ?'),
                        value: ref.watch(tamamlandiMiProvider),
                        onChanged: (value) {
                          ref
                              .read(tamamlandiMiProvider.notifier)
                              .update((state) => !state);
                        },
                      ),
                    ),
                  )),
              Expanded(
                flex: 2,
                child: Center(
                  child: Form(
                    key: baslikKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      controller: notBaslikController,
                      decoration: InputDecoration(
                          label: const Text('Not Başlık'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Başlık kısmı boş bırakılamaz';
                        } else if (widget.seciliNot == null &&
                            ref
                                .watch(notBasliklariProvider)
                                .contains(value.trim())) {
                          return 'Bu başlık ile kayıtlı bir not var. Başka bir başlık girin.';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Center(
                  child: Form(
                    key: icerikKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      controller: notIcerikController,
                      maxLines: 10,
                      decoration: InputDecoration(
                          label: const Text('Not İçerik'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'İçerik kısmı boş bırakılamaz';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.date_range,
                        size: 40,
                      ),
                      Text(
                        DateFormat('dd.MM.yyyy')
                            .format(ref.watch(secilenGunProvider)),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final DateTime? secilen = await showDatePicker(
                            context: context,
                            initialDate: ref.watch(secilenGunProvider),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 3),
                          );
                          if (secilen != null &&
                              secilen != ref.watch(secilenGunProvider)) {
                            ref.read(secilenGunProvider.notifier).update(
                                  (state) => secilen,
                                );
                          }
                        },
                        child: const Text("Tarih Seç"),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Row(
                    children: [
                      const Expanded(
                          child: Text(
                        'Önem Derecesi',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                      Expanded(
                        child: Material(
                          borderRadius: BorderRadius.circular(15),
                          elevation: 16,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: DropdownButton<String>(
                                isExpanded: true,
                                borderRadius: BorderRadius.circular(20),
                                value: ref.watch(onemDerecesiProvider),
                                icon: const Icon(Icons.arrow_drop_down),
                                elevation: 16,
                                underline: const SizedBox(),
                                style: const TextStyle(
                                    color: Colors.black),
                                onChanged: (value) {
                                  ref
                                      .read(onemDerecesiProvider.notifier)
                                      .update((state) => value!);
                                },
                                items: [
                                  DropdownMenuItem<String>(
                                    value: 'Kırmızı',
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          color: Colors.red,
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                        ),
                                        const Text(
                                          'Çok Önemli',
                                        )
                                      ],
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Turuncu',
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          color: Colors.orange,
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                        ),
                                        const Text(
                                          'Önemli',
                                        )
                                      ],
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Yeşil',
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          color: Colors.green,
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                        ),
                                        const Text(
                                          'Önemsiz',
                                        )
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        if (notBaslikController.text.trim().isEmpty) {
                          showDialog(context: context, builder: (context) => AlertDialog(
                            content: const Text('Resim eklemek için öncelikle not başlığı girmelisiniz.'),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tamam'))
                            ],
                          ),);
                        } else {
                          final ImagePicker picker = ImagePicker();

                        XFile? file =
                            await picker.pickImage(source: ImageSource.gallery);
                        showDialog(
                          context: context,
                          builder: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        );
                        var resimref = FirebaseStorage.instance
                            .ref('resimler/${notBaslikController.text.trim()}');
                        var ekle = resimref.putFile(File(file!.path));

                        ekle.whenComplete(() async {
                          var url = await resimref.getDownloadURL();
                          ref
                              .read(resimWidgetProvider.notifier)
                              .update((state) => ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    url,
                                    fit: BoxFit.fill,
                                  )));
                          ref.read(resimUrlProvider.notifier).update((state) {
                            Navigator.pop(context);
                            return url;
                          });
                        });
                          
                        }
                        
                      },
                      child: ref.watch(resimWidgetProvider) ??
                          Container(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                              child: Icon(
                                Icons.add_circle_outline,
                                size: 50,
                              ),
                            ),
                          ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> notuKaydet() async {
    if (baslikKey.currentState!.validate() &&
        icerikKey.currentState!.validate()) {
      var eklenecekNot = Note(
          tarih: ref.watch(
              secilenGunProvider), //DateFormat('dd.MM.yyyy').format(ref.watch(secilenGunProvider)),
          onemDerecesi: ref.watch(onemDerecesiProvider),
          baslik: notBaslikController.text.trim(),
          icerik: notIcerikController.text.trim(),
          resimUrl: ref.watch(resimUrlProvider),
          tamamlandiMi: ref.watch(tamamlandiMiProvider));

      if (widget.seciliNot == null) {
        await _firestore
            .doc(
                '${_auth.currentUser!.email.toString()}/${notBaslikController.text.replaceAll(' ', '').trim()}')
            .set(eklenecekNot.toMap())
            .whenComplete(() => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
                (route) => false));
      } else {
        await _firestore
            .doc(
                '${_auth.currentUser!.email.toString()}/${widget.seciliNot!['baslik'].toString().replaceAll(' ', '').trim()}')
            .delete()
            .whenComplete(() async {
          await _firestore
              .doc(
                  '${_auth.currentUser!.email.toString()}/${notBaslikController.text.replaceAll(' ', '').trim()}')
              .set(eklenecekNot.toMap())
              .whenComplete(() => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                  (route) => false));
        });
      }
      ref.read(secilenGunProvider.notifier).update((state) => DateTime.now());
      ref.read(onemDerecesiProvider.notifier).update((state) => 'Yeşil');
      ref.read(resimUrlProvider.notifier).update((state) => null);
      ref.read(resimWidgetProvider.notifier).update((state) => null);
      ref.read(tamamlandiMiProvider.notifier).update((state) => false);
      ref
          .read(seciliButonProvider.notifier)
          .update((state) => [false, true, false]);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Alanları doğru doldurduğunuzdan emin olun.')));
    }
  }

  void gelenDegerleriYerineKoy(Map<String, dynamic> gelenNot) async {
    notBaslikController.text = gelenNot['baslik'];
    notIcerikController.text = gelenNot['icerik'];
  }
}
