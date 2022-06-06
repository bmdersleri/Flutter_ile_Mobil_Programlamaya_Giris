import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme_flutter/utils/colors.dart';
import 'package:flutter/material.dart';

class ShowUsers extends StatefulWidget {
  const ShowUsers({Key? key}) : super(key: key);

  @override
  _ShowUsersState createState() => _ShowUsersState();
}

class _ShowUsersState extends State<ShowUsers> {
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
        title: const Text('Users'),
        centerTitle: false,
      ),
      body: ListPagee(),
    );
  }
}

class ListPagee extends StatefulWidget {
  ListPagee({Key? key}) : super(key: key);

  @override
  _ListPageeState createState() => _ListPageeState();
}

class _ListPageeState extends State<ListPagee> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
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
                  title: Container(
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            (index + 1).toString() + ". ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            snapshot.data!.docs[index]['username'],
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Text(
                          "Phone Number :",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        child: Text(
                          snapshot.data!.docs[index]['phonenumber'],
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}
