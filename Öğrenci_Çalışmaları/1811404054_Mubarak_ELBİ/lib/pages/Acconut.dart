import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAcconut extends StatefulWidget {
  const UserAcconut({Key? key}) : super(key: key);

  @override
  State<UserAcconut> createState() => _UserAcconutState();
}

class _UserAcconutState extends State<UserAcconut> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(110, 189, 189, 189),
        elevation: 1,
        title: Image(
          image: AssetImage("images/taldo__1_-removebg-preview.png"),
          height: 50,
        ),
      ),
      backgroundColor: Color.fromARGB(110, 189, 189, 189),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Text(
              "User Acconut",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Account",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),

            Row(
              children: [
                Text(
                  "" + user.email!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),

            SizedBox(
              height: 10,
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            //sign out button
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
