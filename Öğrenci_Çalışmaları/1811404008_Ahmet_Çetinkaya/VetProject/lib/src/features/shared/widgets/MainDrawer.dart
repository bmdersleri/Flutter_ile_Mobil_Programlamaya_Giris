import 'package:flutter/material.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologyReports/pages/PathologyReportListPageWidget.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/screens/AboutUsScreenWidget.dart';
import 'package:vet_project_flutter_frontend/src/settings/ThemeColors.dart';
import 'package:vet_project_flutter_frontend/src/settings/settings_view.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              Image(image: AssetImage("assets/images/vet_logo.png")),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Patoloji Ana Bilim Dalı Veri Yönetim Yazılımı",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                  color: ThemeColors.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        ListTile(
          onTap: () => Navigator.pushReplacementNamed(
              context, PathologyReportListPageWidget.routeName),
          leading: const Icon(Icons.feed),
          title: const Text("Patoloji Kayıtları"),
        ),
        const Spacer(),
        ListTile(
          onTap: () => Navigator.pushNamed(context, SettingsView.routeName),
          leading: const Icon(Icons.settings),
          title: const Text("Ayarlar"),
        ),
        ListTile(
          onTap: () =>
              Navigator.pushNamed(context, AboutUsScreenWidget.routeName),
          leading: const Icon(Icons.info),
          title: const Text("Hakkımızda"),
        ),
      ],
    );
  }
}
