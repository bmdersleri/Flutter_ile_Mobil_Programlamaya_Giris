import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';
import 'package:vet_project_flutter_frontend/src/features/macroscopicDiagnoses/models/MacroscopicDiagnosis.dart';
import 'package:vet_project_flutter_frontend/src/features/macroscopicDiagnoses/services/MacroscopicDiagnosesService.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/services/ToastService.dart';

class MacroscopicDiagnosesGallery extends StatefulWidget {
  final MacroscopicDiagnosesService macroscopicDiagnosesService =
      MacroscopicDiagnosesService();
  final MacroscopicDiagnosis? macroscopicDiagnosis;
  final String _domainURL = dotenv.env['DOMAIN_URL'] as String;
  List<XFile> filesToUpload = [];

  MacroscopicDiagnosesGallery(
      {Key? key, required this.macroscopicDiagnosis, filesToUpload})
      : super(key: key) {
    if (filesToUpload != null) this.filesToUpload.addAll(filesToUpload);
  }

  @override
  _MacroscopicDiagnosesGalleryState createState() {
    return _MacroscopicDiagnosesGalleryState();
  }
}

class _MacroscopicDiagnosesGalleryState
    extends State<MacroscopicDiagnosesGallery> {
  List filesPaths = [];
  int _filesToUploadCountTemp = 0;

  @override
  void initState() {
    super.initState();
    if (widget.macroscopicDiagnosis != null) getAllFiles();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getAllFiles() async {
    var response = await widget.macroscopicDiagnosesService
        .getAllFiles(widget.macroscopicDiagnosis?.id as int);
    if (response.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }
    if (!mounted) return;
    setState(() {
      filesPaths = jsonDecode(response.body);
    });
  }

  _checkIsRequiredRefresh() {
    if (_filesToUploadCountTemp > 0 &&
        widget.filesToUpload.length != _filesToUploadCountTemp) {
      getAllFiles();
      _filesToUploadCountTemp = widget.filesToUpload.length;
    } else {
      _filesToUploadCountTemp = widget.filesToUpload.length;
    }
  }

  _showSwipeImageGallery({int initialIndex = 0}) {
    SwipeImageGallery(
            context: context,
            itemBuilder: (context, index) {
              String filePath = filesPaths[index];
              return Image.file(File(filePath), height: 100);
            },
            itemCount: filesPaths.length,
            initialIndex: initialIndex)
        .show();
  }

  _showSwipeImageToUploadGallery({int initialIndex = 0}) {
    SwipeImageGallery(
            context: context,
            itemBuilder: (context, index) {
              XFile file = widget.filesToUpload[index];
              return Image.file(File(file.path));
            },
            itemCount: widget.filesToUpload.length,
            initialIndex: initialIndex)
        .show();
  }

  @override
  Widget build(BuildContext context) {
    _checkIsRequiredRefresh();

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ...filesPaths.take(4).toList().asMap().entries.map((entry) {
                int index = entry.key;
                String filePath = entry.value;
                return Expanded(
                  child: InkWell(
                    onTap: () => _showSwipeImageGallery(initialIndex: index),
                    child: Hero(
                        tag: filePath,
                        child: Image.file(File(filePath), height: 130)),
                  ),
                );
              }).toList(),
              if (filesPaths.length > 4)
                Center(
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => _showSwipeImageGallery(initialIndex: 4),
                  ),
                )
            ],
          ),

          //# filesToUpload
          if (widget.filesToUpload.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child:
                      Text("Yüklenmeyi bekliyor:", textAlign: TextAlign.start),
                ),
                Row(
                  children: [
                    ...widget.filesToUpload
                        .take(4)
                        .toList()
                        .asMap()
                        .entries
                        .map((entry) {
                      int index = entry.key;
                      XFile file = entry.value;
                      return Expanded(
                        child: InkWell(
                          onTap: () => _showSwipeImageToUploadGallery(
                              initialIndex: index),
                          child: Hero(
                              tag: file.name,
                              child: Image.file(
                                File(file.path),
                                height: 130,
                              )),
                        ),
                      );
                    }).toList(),
                    if (widget.filesToUpload.length > 4)
                      Center(
                        child: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () =>
                              _showSwipeImageToUploadGallery(initialIndex: 4),
                        ),
                      )
                  ],
                )
              ],
            )
        ],
      ),
    );
  }
}
