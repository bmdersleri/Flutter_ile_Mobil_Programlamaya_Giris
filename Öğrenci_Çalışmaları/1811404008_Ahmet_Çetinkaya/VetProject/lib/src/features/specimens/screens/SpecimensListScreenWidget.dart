import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vet_project_flutter_frontend/src/features/specimens/screens/SpecimenFormScreenWidget.dart';
import 'package:vet_project_flutter_frontend/src/features/specimens/widgets/SpecimensListWidget.dart';

class SpecimensListScreenWidget extends StatefulWidget {
  String? protocolNumber;

  SpecimensListScreenWidget({Key? key, this.protocolNumber}) : super(key: key);

  @override
  _SpecimensListScreenWidgetState createState() {
    return _SpecimensListScreenWidgetState();
  }
}

class _SpecimensListScreenWidgetState extends State<SpecimensListScreenWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _navigateToAddForm() {
    pushNewScreen(
      context,
      screen: SpecimenFormScreenWidget(
          pathologyReportIdToAdd: widget.protocolNumber),
      withNavBar: true, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.protocolNumber} Numuneler'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _navigateToAddForm,
        heroTag: "addSpecimenButton",
      ),
      body: SpecimensListWidget(protocolNumber: widget.protocolNumber),
    );
  }
}
