import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vet_project_flutter_frontend/src/settings/ThemeColors.dart';

class AboutUsScreenWidget extends StatelessWidget {
  static const String routeName = "aboutUs";

  const AboutUsScreenWidget({Key? key}) : super(key: key);

  void _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hakkımızda'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          ListTile(
            leading: const Text("Ana Geliştirici"),
            title: const Text("Ahmet Çetinkaya"),
            subtitle: InkWell(
                child: const Text(
                  'ahmetcetinkaya7@outlook.com',
                  style: TextStyle(
                      color: ThemeColors.primary, fontWeight: FontWeight.bold),
                ),
                onTap: () => _launchUrl(
                      'mailto:ahmetcetinkaya7@outlook.com',
                    )),
          )
        ]),
      ),
    );
  }
}
