import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme_flutter/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class OwnerService extends StatefulWidget {
  const OwnerService({Key? key}) : super(key: key);

  @override
  _OwnerServiceState createState() => _OwnerServiceState();
}

class _OwnerServiceState extends State<OwnerService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Services'),
        centerTitle: false,
      ),
      body: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  var ff = FirebaseFirestore.instance.collection('services').snapshots();

  navigateToDetail(DocumentSnapshot service) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => DetailPage(
                  service: service,
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('services').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  title: Text(
                    (index + 1).toString() +
                        ". " +
                        snapshot.data!.docs[index]['namesurname'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      "- Brand and Model : " +
                          snapshot.data!.docs[index]['brand'] +
                          " " +
                          snapshot.data!.docs[index]['bmodel'],
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  onTap: () {
                    navigateToDetail(snapshot.data!.docs[index]);
                  },
                );
              },
            );
          }),
    );
  }
}

class DetailPage extends StatefulWidget {
  DetailPage({Key? key, required this.service}) : super(key: key);

  final DocumentSnapshot service;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
            title: Text('Service Sheet'),
            centerTitle: false,
            bottom: const TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  child: Text('Informations',
                      style: TextStyle(color: Colors.white)),
                ),
                Tab(
                  child: Text('Service', style: TextStyle(color: Colors.white)),
                ),
              ],
              labelColor: Colors.white,
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(children: [
                  const SizedBox(
                    height: 54,
                  ),
                  RowProperties(
                      firstBox: "Name Surname :   ",
                      secondBox: widget.service['namesurname']),
                  const SizedBox(
                    height: 40,
                  ),
                  RowProperties(
                      firstBox: 'Car Brand :   ',
                      secondBox: widget.service['brand']),
                  const SizedBox(
                    height: 40,
                  ),
                  RowProperties(
                      firstBox: 'Car Model :   ',
                      secondBox: widget.service['bmodel']),
                  const SizedBox(
                    height: 40,
                  ),
                  RowProperties(
                      firstBox: 'The instant mileage of the car :   ',
                      secondBox: widget.service['kmnow']),
                  const SizedBox(
                    height: 40,
                  ),
                  RowProperties(
                      firstBox: 'The new service mileage of the car :   ',
                      secondBox: widget.service['kmtogo']),
                  const SizedBox(
                    height: 64,
                  ),
                ]),
              ),
              InfoOut(service: widget.service['trufal']),
            ],
          )),
    );
  }
}

// Row Section
class RowProperties extends StatefulWidget {
  final String firstBox;
  final String secondBox;
  const RowProperties(
      {Key? key, required this.firstBox, required this.secondBox})
      : super(key: key);

  @override
  _RowPropertiesState createState() => _RowPropertiesState();
}

class _RowPropertiesState extends State<RowProperties> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Text(
              widget.firstBox,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
          ),
          Container(
            child: Text(
              widget.secondBox,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
          ),
        ],
      ),
    );
  }
}

class InfoOut extends StatefulWidget {
  final List<dynamic> service;

  InfoOut({Key? key, required this.service}) : super(key: key);

  @override
  _InfoOutState createState() => _InfoOutState();
}

class _InfoOutState extends State<InfoOut> {
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

  icerikDegistir(List<Map> liste) {
    List<dynamic> a = widget.service.toList();
    for (int i = 0; i < 8; i++) {
      liste[i]["isChecked"] = a[i];
    }
  }

  List<bool> degisken = [false];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextButton(
              onPressed: icerikDegistir(availableHobbies), child: Text("")),
          const SizedBox(height: 0),
          const SizedBox(height: 0),
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
          const SizedBox(height: 10),
        ]),
      ),
    );
  }
}
