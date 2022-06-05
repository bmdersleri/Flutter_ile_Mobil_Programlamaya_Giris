import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/list_of_todo_model.dart';
import '../../providers/export_providers.dart';
import '../widgets/app_title.dart';
import '../widgets/custom_button.dart';
import 'backup_list.dart';

class BackupAndRestorePage extends ConsumerWidget {
  const BackupAndRestorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storage = ref.watch(storageProvider);
    void _showAlert(String msg) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Tamam',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            )
          ],
        ),
      );
    }

    Future<File?> _writeListOfTodoModel() async {
      ListOfTodoModel listOfTodoModel = ref.watch(todoListProvider);

      File? file = await storage.writeData(listOfTodoModel);
      if (file != null) {
        _showAlert('Yedek oluşturuldu.');
        return file;
      } else {
        _showAlert(
            'Yedekleme yapılırken bazı hatalar oluştu.\nDepolama izninin verilip verilmediğini "uygulama bilgisi"nden kontrol edin.');
        return null;
      }
    }

    void _readListOfTodoModelFromFilePicker() async {
      ListOfTodoModel? listOfTodoModel = await storage.readFromFilePicker();
      if (listOfTodoModel != null) {
        ref.read(todoListProvider.notifier)
          ..overrideData(listOfTodoModel)
          ..saveData();
        _showAlert('Dosyadan veri yüklendi');
      }
      if (listOfTodoModel == null) {
        _showAlert('Veri yüklenemiyor. Geçerli bir dosya seçin.');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(
          leadingTitle: 'Yedekle & Geri Yükle',
        ),
        actions: const [
          Icon(
            Icons.ac_unit,
            color: Colors.transparent,
          ),
          Icon(
            Icons.ac_unit,
            color: Colors.transparent,
          )
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButton(
              'Yedek oluştur',
              onTap: _writeListOfTodoModel,
            ),
            CustomButton(
              'Yedekten geri yükle',
              onTap: () async {
                List<String> listOfFiles = await storage.getListOfBackups();
                listOfFiles = listOfFiles.reversed.toList();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BackupList(
                      listOfFiles: listOfFiles,
                    ),
                  ),
                );
              },
            ),
            CustomButton(
              'Depolamadan yükle',
              onTap: _readListOfTodoModelFromFilePicker,
            ),
          ],
        ),
      ),
    );
  }
}
