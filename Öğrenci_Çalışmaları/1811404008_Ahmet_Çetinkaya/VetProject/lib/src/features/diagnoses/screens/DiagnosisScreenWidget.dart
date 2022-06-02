import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vet_project_flutter_frontend/src/features/anamnesisDiagnoses/screens/AnamnesisDiagnosisListScreenWidget.dart';
import 'package:vet_project_flutter_frontend/src/features/diagnoses/screens/DiagnosisFormScreenWidget.dart';
import 'package:vet_project_flutter_frontend/src/features/macroscopicDiagnoses/screens/MacroscopicDiagnosisListScreenWidget.dart';
import 'package:vet_project_flutter_frontend/src/features/microscopicDiagnoses/screens/MicroscopicDiagnosisListScreenWidget.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologicalDiagnoses/screens/PathologicalDiagnosisListScreenWidget.dart';
import 'package:vet_project_flutter_frontend/src/settings/ThemeColors.dart';

class DiagnosisScreenWidget extends StatelessWidget {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  String pathologyReportId;

  @override
  DiagnosisScreenWidget({Key? key, required this.pathologyReportId})
      : super(key: key);

  List<Widget> _buildScreens() {
    return [
      DiagnosisFormScreenWidget(pathologyReportId: pathologyReportId),
      AnamnesisDiagnosisListScreenWidget(diagnosisId: pathologyReportId),
      MacroscopicDiagnosisListScreenWidget(diagnosisId: pathologyReportId),
      MicroscopicDiagnosisListScreenWidget(diagnosisId: pathologyReportId),
      PathologicalDiagnosisListScreenWidget(diagnosisId: pathologyReportId)
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.where_to_vote),
        title: ("Bulgu Kaydı"),
        activeColorPrimary: ThemeColors.primary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.content_paste),
        title: ("Anamnez"),
        activeColorPrimary: ThemeColors.primary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.camera),
        title: ("Makroskobik"),
        activeColorPrimary: ThemeColors.primary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.biotech),
        title: ("Mikroskobik"),
        activeColorPrimary: ThemeColors.primary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.label),
        title: ("Patolojik"),
        activeColorPrimary: ThemeColors.primary,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      // Default is Colors.white.
      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true,
      // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: const Color.fromARGB(255, 230, 230, 230),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style9, // Choose the nav bar style with this property.
    );
  }
}
