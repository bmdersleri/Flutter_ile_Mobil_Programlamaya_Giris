import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:localstore/localstore.dart';
import 'package:path_provider/path_provider.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

final List<CameraDescription> deviceCameras = [];
final db = Localstore.instance;
String appDocumentsPath = "";

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  await dotenv.load(fileName: ".env");

  deviceCameras.addAll(await availableCameras());
  Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
  appDocumentsPath = appDocumentsDirectory.path;

  seed();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(settingsController: settingsController));
}

void seed() async {
  var diagnosisTypes = await db.collection('diagnosisTypes').get();
  if (diagnosisTypes == null || diagnosisTypes.isEmpty == true) {
    List<Map<String, dynamic>> seed = [
      {
        "id": 1,
        "name": "Papiller adenokarsinom",
        "created_at": null,
        "updated_at": null,
        "deleted_at": null
      },
      {
        "id": 2,
        "name": "Coccidiosis",
        "created_at": null,
        "updated_at": null,
        "deleted_at": null
      },
      {
        "id": 3,
        "name": "Leptospira",
        "created_at": null,
        "updated_at": null,
        "deleted_at": null
      },
      {
        "id": 4,
        "name": "Fibroadenom",
        "created_at": null,
        "updated_at": null,
        "deleted_at": null
      },
      {
        "id": 5,
        "name": "Enteretoksemi",
        "created_at": null,
        "updated_at": null,
        "deleted_at": null
      },
      {
        "id": 6,
        "name": "Purulent Hemorajik Bronkopnömoni",
        "created_at": null,
        "updated_at": null,
        "deleted_at": null
      },
      {
        "id": 7,
        "name": "Toksikasyon",
        "created_at": null,
        "updated_at": null,
        "deleted_at": null
      },
      {
        "id": 8,
        "name": "Panleukopeni",
        "created_at": null,
        "updated_at": null,
        "deleted_at": null
      }
    ];
    seed.forEach((e) async {
      await db.collection('diagnosisTypes').doc(e["id"].toString()).set(e);
    });
  }

  var diseaseTypes = await db.collection('diseaseTypes').get();
  if (diseaseTypes == null || diseaseTypes.isEmpty == true) {
    List<Map<String, dynamic>> seed = [
      {
        "id": 1,
        "name": "Bilinmiyor",
        "created_at": "2022-03-30T17:43:12.000000Z",
        "updated_at": null,
        "deleted_at": null
      }
    ];
    seed.forEach((e) async {
      await db.collection('diseaseTypes').doc(e["id"].toString()).set(e);
    });
  }

  var examinationTypes = await db.collection('examinationTypes').get();
  if (examinationTypes == null || examinationTypes.isEmpty == true) {
    List<Map<String, dynamic>> seed = [
      {
        "id": 1,
        "name": "Biyopsi",
        "created_at": "2022-03-30T17:42:53.000000Z",
        "updated_at": "2022-03-30T16:36:36.000000Z",
        "deleted_at": null
      },
      {
        "id": 2,
        "name": "Sitoloji",
        "created_at": "2022-03-30T16:36:08.000000Z",
        "updated_at": "2022-03-30T16:36:36.000000Z",
        "deleted_at": null
      },
      {
        "id": 3,
        "name": "Nekropsi",
        "created_at": "2022-03-30T16:36:08.000000Z",
        "updated_at": "2022-03-30T16:36:36.000000Z",
        "deleted_at": null
      }
    ];
    seed.forEach((e) async {
      await db.collection('examinationTypes').doc(e["id"].toString()).set(e);
    });
  }

  var genera = await db.collection('genera').get();
  if (genera == null || genera.isEmpty == true) {
    List<Map<String, dynamic>> seed = [
      {
        "id": 1,
        "breed_id": 1,
        "name": "Rottweiler",
      },
      {
        "id": 2,
        "breed_id": 1,
        "name": "Dogo",
      },
      {
        "id": 3,
        "breed_id": 1,
        "name": "Sharpei",
      },
      {
        "id": 4,
        "breed_id": 2,
        "name": "Mix",
      },
      {
        "id": 5,
        "breed_id": 3,
        "name": "Halep",
      },
      {
        "id": 6,
        "breed_id": 4,
        "name": "Zwartbles",
      },
      {
        "id": 7,
        "breed_id": 5,
        "name": "CD-1",
      },
      {
        "id": 8,
        "breed_id": 3,
        "name": "Saanen",
      },
      {
        "id": 9,
        "breed_id": 6,
        "name": "Holstein",
      },
      {
        "id": 10,
        "breed_id": 9,
        "name": "Merinos",
      },
      {
        "id": 11,
        "breed_id": 3,
        "name": "Kıl",
      },
      {
        "id": 12,
        "breed_id": 6,
        "name": "Simmental",
      },
      {
        "id": 13,
        "breed_id": 9,
        "name": "Sakız",
      }
    ];
    seed.forEach((e) async {
      await db.collection('genera').doc(e["id"].toString()).set(e);
    });
  }

  var specimenOwners = await db.collection('specimenOwners').get();
  if (specimenOwners == null || specimenOwners.isEmpty == true) {
    List<Map<String, dynamic>> seed = [
      {
        "id": 1,
        "name": "Esra Arslan",
        "phone_number": "12313123",
        "address_city_id": 1,
        "address_district_id": 1,
        "address": "açık adres",
        "created_at": null,
        "updated_at": null,
        "deleted_at": null
      },
      {
        "id": 2,
        "name": "Burdur Belediyesi Hayvan Barınağı",
        "phone_number": "12313123",
        "address_city_id": 1,
        "address_district_id": 1,
        "address": "açık adres",
        "created_at": null,
        "updated_at": null,
        "deleted_at": null
      },
      {
        "id": 3,
        "name": "Helal Köy Tarım Hayvancılık Anonim Şirketi",
        "phone_number": "12313123",
        "address_city_id": 1,
        "address_district_id": 1,
        "address": "açık adres",
        "created_at": null,
        "updated_at": null,
        "deleted_at": null
      },
      {
        "id": 4,
        "name": "Ali Tuğrap Doğan",
        "phone_number": "12313123",
        "address_city_id": 1,
        "address_district_id": 1,
        "address": "açık adres",
        "created_at": null,
        "updated_at": null,
        "deleted_at": null
      }
    ];
    seed.forEach((e) async {
      await db.collection('specimenOwners').doc(e["id"].toString()).set(e);
    });
  }

  var statusTypes = await db.collection('statusTypes').get();
  if (statusTypes == null || statusTypes.isEmpty == true) {
    List<Map<String, dynamic>> seed = [
      {
        "id": 1,
        "name": "Bekliyor",
        "created_at": "2022-03-30T17:43:12.000000Z",
        "updated_at": "2022-03-30T14:52:12.000000Z",
        "deleted_at": null
      },
      {
        "id": 2,
        "name": "İncelemede",
        "created_at": "2022-03-30T14:52:12.000000Z",
        "updated_at": "2022-03-30T14:52:12.000000Z",
        "deleted_at": null
      },
      {
        "id": 3,
        "name": "Sonuçlandı",
        "created_at": "2022-03-30T16:05:07.000000Z",
        "updated_at": "2022-03-30T16:05:07.000000Z",
        "deleted_at": null
      },
      {
        "id": 4,
        "name": "Onaylandı",
        "created_at": "2022-03-30T16:05:07.000000Z",
        "updated_at": "2022-03-30T14:52:12.000000Z",
        "deleted_at": null
      }
    ];
    seed.forEach((e) async {
      await db.collection('statusTypes').doc(e["id"].toString()).set(e);
    });
  }

  var users = await db.collection('users').get();
  if (users == null || users.isEmpty == true) {
    List<Map<String, dynamic>> seed = [
      {
        "id": 1,
        "first_name": "Leyla",
        "last_name": "Vetir",
        "email": "eposta",
        "email_verified_at": null,
        "profile_image_path": "Users/ProfileImages/woman-default.png",
        "created_at": null,
        "updated_at": null,
        "deleted_at": null
      },
      {
        "id": 2,
        "first_name": "Ahmet",
        "last_name": "Çetinkaya",
        "email": "eposta2",
        "email_verified_at": null,
        "profile_image_path": "Users/ProfileImages/man-default.png",
        "created_at": null,
        "updated_at": null,
        "deleted_at": null
      },
      {
        "id": 3,
        "first_name": "Derya",
        "last_name": "Ayyıldız",
        "email": "eposta3",
        "email_verified_at": null,
        "profile_image_path": "Users/ProfileImages/woman-default.png",
        "created_at": null,
        "updated_at": null,
        "deleted_at": null
      }
    ];
    seed.forEach((e) async {
      await db.collection('users').doc(e["id"].toString()).set(e);
    });
  }

  var pathologyReportsTotal =
      await db.collection('pathologyReports').doc("total").get();
  if (pathologyReportsTotal == null) {
    await db.collection('pathologyReports').doc("total").set({"total": 1});
  }
}
