import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vet_project_flutter_frontend/src/features/analyses/screens/AnalysisScreenWidget.dart';
import 'package:vet_project_flutter_frontend/src/features/diagnoses/screens/DiagnosisScreenWidget.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologyReports/pages/PathologyReportFormPageWidget.dart';
import 'package:vet_project_flutter_frontend/src/features/specimens/screens/SpecimensListScreenWidget.dart';
import 'package:vet_project_flutter_frontend/src/settings/ThemeColors.dart';

class PathologyReportScreenWidget extends StatelessWidget {
  static const routeName = 'pathologyReport';
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  Map<String, dynamic>? _args;

  @override
  PathologyReportScreenWidget({Key? key}) : super(key: key);

  List<Widget> _buildScreens(BuildContext context) {
    String protocolNumber = _args!["protocolNumber"];
    return [PathologyReportFormPageWidget(protocolNumber: protocolNumber, parentContext: context), SpecimensListScreenWidget(protocolNumber: protocolNumber), DiagnosisScreenWidget(pathologyReportId: protocolNumber), AnalysisScreenWidget(pathologyReportId: protocolNumber)];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.feed),
        title: ("Patoloji"),
        activeColorPrimary: ThemeColors.primary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.pets),
        title: ("Numune"),
        activeColorPrimary: ThemeColors.primary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.where_to_vote),
        title: ("Bulgu"),
        activeColorPrimary: ThemeColors.primary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: ("Analiz"),
        activeColorPrimary: ThemeColors.primary,
      ),
    ];
  }

  void _getNavigationArgs(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    if (args != null) _args = args as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    _getNavigationArgs(context);
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(context),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.transparent,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style9,
    );
  }
}
