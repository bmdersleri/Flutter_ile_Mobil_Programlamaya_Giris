import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pop_notes/screens/about_me.dart';
import 'package:pop_notes/screens/my_note.dart';
import 'controller.dart';

class NoteList extends StatelessWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NoteController nc = Get.put(NoteController());
    Widget getNoteList() {
      return Obx(
        () => nc.notes.isEmpty
            ? Center(
                child: SizedBox(
                    height: 300, child: Image.asset('lib/assets/heart.png')),
              )
            : Column(
                children: [
                  Expanded(
                    flex: 10,
                    child: ListView.builder(
                        itemCount: nc.notes.length,
                        itemBuilder: (context, index) => Card(
                              child: ListTile(
                                  title: Text(nc.notes[index].title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500)),
                                  leading: Text(
                                    "${index + 1}.",
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  trailing: Wrap(children: <Widget>[
                                    IconButton(
                                        icon: const Icon(Icons.create),
                                        onPressed: () =>
                                            Get.to(MyNote(index: index))),
                                    IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          Get.defaultDialog(
                                              titleStyle: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              titlePadding: EdgeInsets.fromLTRB(
                                                  64, 48, 64, 24),
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      64, 24, 64, 48),
                                              title:
                                                  'Do you want to delete this note?',
                                              middleText: nc.notes[index].title,
                                              onCancel: () => Get.back(),
                                              confirmTextColor: Colors.white,
                                              onConfirm: () {
                                                nc.notes.removeAt(index);
                                                Get.back();
                                              });
                                        })
                                  ])),
                            )),
                  ),
                  Expanded(
                    child: MaterialButton(
                        hoverElevation: 0,
                        child: Container(
                            height: 64,
                            child: Image.asset(
                              'lib/assets/About.png',
                            )),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AboutMePage()),
                          );
                        }),
                  ),
                ],
              ),
      );
    }

    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xffFFC803),
            appBar: AppBar(
              toolbarHeight: 120,
              elevation: 0,
              backgroundColor: Color(0xffFFC803),
              centerTitle: true,
              title: SizedBox(
                  width: 140, child: Image.asset('lib/assets/logo.png')),
            ),
            floatingActionButton: FloatingActionButton(
              elevation: 0,
              hoverElevation: 0,
              hoverColor: Color.fromARGB(255, 16, 155, 230),
              child: const Icon(
                Icons.add,
                color: Colors.black,
                size: 32,
              ),
              onPressed: () {
                Get.to(MyNote(
                  index: null,
                ));
              },
            ),
            body: Padding(
                padding: const EdgeInsets.all(24), child: getNoteList())));
  }
}
