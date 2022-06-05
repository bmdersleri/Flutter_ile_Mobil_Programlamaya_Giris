import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/constants.dart';
import '../widgets/app_title.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _launchUrl(String _url) async {
      await canLaunch(_url) ? await launch(_url) : throw '$_url başlatılamadı.';
    }

    return Scaffold(
      appBar: AppBar(
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
        title: const AppBarTitle(
          leadingTitle: 'Hakkımızda',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Image.asset(
                'assets/images/Logo.png',height: 300,
              ),
            const SizedBox(
              height: 8,
            ),
            const AppBarTitle(
              trailingTitle: 'My Starry Tasks',
              fontSize: 36,
            ),
            const AppBarTitle(
              leadingTitle: 'by',
              fontSize: 16,
            ),
            const AppBarTitle(
              trailingTitle: 'Furkan AKKULAK',
              fontSize: 20,
            ),
            const SizedBox(
              height: 48,
            ),
            const Spacer(),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => _launchUrl(fbUrl),
                  icon: const Icon(
                    CarbonIcons.logo_instagram,
                    size: 32,
                    color: Color.fromARGB(255, 0, 132, 255),
                  ),
                ),
                IconButton(
                  onPressed: () => _launchUrl(mailUrl),
                  icon: const Icon(
                    CarbonIcons.email,
                    size: 32,
                    color: Color.fromARGB(255, 0, 132, 255),
                  ),
                ),
                IconButton(
                  onPressed: () => _launchUrl(githubUrl),
                  icon: const Icon(
                    CarbonIcons.logo_github,
                    size: 32,
                    color: Color.fromARGB(255, 0, 132, 255),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
