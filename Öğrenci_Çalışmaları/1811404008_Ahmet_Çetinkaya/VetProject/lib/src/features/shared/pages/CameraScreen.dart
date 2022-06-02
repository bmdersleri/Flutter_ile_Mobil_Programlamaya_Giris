import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vet_project_flutter_frontend/main.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() {
    return _CameraScreenState();
  }
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      deviceCameras.first,
      ResolutionPreset.max,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _takePhoto() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();

      Navigator.pop<XFile>(context, image);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(),
            floatingActionButton: FloatingActionButton(
              onPressed: _takePhoto,
              child: const Icon(Icons.camera_alt),
              heroTag: "macroscopicCameraButton",
            ),
            body: Center(child: _controller.buildPreview()),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
