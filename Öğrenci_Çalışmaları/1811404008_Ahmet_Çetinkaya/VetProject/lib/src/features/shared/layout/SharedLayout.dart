import 'package:flutter/material.dart';
import 'package:vet_project_flutter_frontend/src/settings/settings_view.dart';

class SharedLayout extends StatefulWidget {
  final String title;
  final Widget? child;

  const SharedLayout({Key? key, this.title = "", this.child}) : super(key: key);

  @override
  _SharedLayoutState createState() {
    return _SharedLayoutState();
  }
}

class _SharedLayoutState extends State<SharedLayout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Navigate to the settings page. If the user leaves and returns
                // to the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
            ),
          ],
        ),

        // To work with lists that may contain a large number of items, it’s best
        // to use the ListView.builder constructor.
        //
        // In contrast to the default ListView constructor, which requires
        // building all Widgets up front, the ListView.builder constructor lazily
        // builds Widgets as they’re scrolled into view.
        body: widget.child);
  }
}
