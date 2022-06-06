import 'package:deneme_flutter/resources/firestore_methods.dart';
import 'package:deneme_flutter/utils/colors.dart';
import 'package:deneme_flutter/utils/utils.dart';
import 'package:deneme_flutter/widgets/text_field_input.dart';
import 'package:flutter/material.dart';

class CreateService extends StatefulWidget {
  const CreateService({Key? key}) : super(key: key);

  @override
  _CreateServiceState createState() => _CreateServiceState();
}

final TextEditingController _namesurnameController = TextEditingController();
final TextEditingController _brandController = TextEditingController();
final TextEditingController _bmodelController = TextEditingController();
final TextEditingController _kmnowController = TextEditingController();
final TextEditingController _kmtogoController = TextEditingController();
final TextEditingController _checklistController = TextEditingController();
bool _isLoading = false;

class _CreateServiceState extends State<CreateService> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Create Service'),
          centerTitle: false,
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child:
                    Text('Informations', style: TextStyle(color: Colors.white)),
              ),
              Tab(
                child: Text('Service', style: TextStyle(color: Colors.white)),
              ),
            ],
            labelColor: Colors.white,
          ),
        ),
        body: const TabBarView(
          children: [
            UserEnter(),
            ServiceEnter(),
          ],
        ),
      ),
    );
  }
}

class UserEnter extends StatefulWidget {
  const UserEnter({Key? key}) : super(key: key);

  @override
  _UserEnterState createState() => _UserEnterState();
}

class _UserEnterState extends State<UserEnter> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(
          height: 34,
        ),
        TextFieldInput(
          hintText: '  Enter your name and surname',
          textInputType: TextInputType.text,
          textEditingController: _namesurnameController,
        ),
        const SizedBox(
          height: 24,
        ),
        TextFieldInput(
          hintText: '  Enter your car brand',
          textInputType: TextInputType.text,
          textEditingController: _brandController,
        ),
        const SizedBox(
          height: 24,
        ),
        TextFieldInput(
          hintText: '  Enter your car model',
          textInputType: TextInputType.text,
          textEditingController: _bmodelController,
        ),
        const SizedBox(
          height: 24,
        ),
        TextFieldInput(
          hintText: '  Enter the instant mileage of the car',
          textInputType: TextInputType.text,
          textEditingController: _kmnowController,
        ),
        const SizedBox(
          height: 24,
        ),
        TextFieldInput(
          hintText: '  Enter the new service mileage of the car',
          textInputType: TextInputType.text,
          textEditingController: _kmtogoController,
        ),
        const SizedBox(
          height: 24,
        ),
      ]),
    ));
  }
}

class ServiceEnter extends StatefulWidget {
  const ServiceEnter({Key? key}) : super(key: key);

  @override
  _ServiceEnterState createState() => _ServiceEnterState();
}

class _ServiceEnterState extends State<ServiceEnter> {
  List<Map> availableHobbies = [
    {"name": "Engine Oil", "isChecked": false},
    {"name": "Oil Filter", "isChecked": false},
    {
      "name": "Air Filter",
      "isChecked": false,
    },
    {"name": "Diesel Fuil Filter", "isChecked": false},
    {"name": "Pollen Filter", "isChecked": false},
    {"name": "V Belt", "isChecked": false},
    {"name": "Front Brake Pads", "isChecked": false},
    {"name": "Rear Brake Pads", "isChecked": false}
  ];

  void createServ() async {
    setState(() {
      _isLoading = true;
    });

    String res = await FireStoreMethods().uploadService(
      namesurname: _namesurnameController.text,
      brand: _brandController.text,
      bmodel: _bmodelController.text,
      kmnow: _kmnowController.text,
      kmtogo: _kmtogoController.text,
      trufal: dogruYanlis,
    );

    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, "Service Saved");
    } else {
      showSnackBar(context, res);
    }

    setState(() {
      _isLoading = false;
    });
  }

  List<bool> dogruYanlis = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 0),
          const Divider(),
          const SizedBox(height: 10),
          Column(
              children: availableHobbies.map((hobby) {
            return CheckboxListTile(
                value: hobby["isChecked"],
                title: Text(hobby["name"]),
                onChanged: (newValue) {
                  setState(() {
                    hobby["isChecked"] = newValue;
                  });
                });
          }).toList()),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Center(
              child: TextButton(
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () {
                    List<Map> listMap = availableHobbies;
                    listMap.forEach((dynamic iceride) {
                      dogruYanlis.add(iceride["isChecked"]);
                    });
                    if (_namesurnameController.text == "" ||
                        _brandController.text == "" ||
                        _kmnowController.text == "" ||
                        _kmtogoController.text == "" ||
                        _bmodelController.text == "") {
                      showSnackBar(context, "This fields can't be empty.");
                    } else {
                      createServ();
                    }
                  }))
        ]),
      ),
    );
  }
}
