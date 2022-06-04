import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'forgot_pw_page.dart';

class UserSetting extends StatefulWidget {
  //const UserSetting({ Key? key }) : super(key: key);

  @override
  State<UserSetting> createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
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
              "User Settings",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Setting",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ForgotPassword(); //AlertDialog(
                    //title: Text("Change password"),
                    // );
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Change Password",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 15,
            ),

            //About AS
            Row(
              children: [
                Text(
                  "About As",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Cryptocurrency  prices application ")],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(" through it you can see current currency rates  ")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(" and price changes  and shows you the prices  ")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(" in Turkish lira. ")],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    " It is easy for you to search for currencies and their prices ")
              ],
            ),

            //
            Divider(
              height: 15,
              thickness: 2,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Developed by Mubarak Elmi",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "m-manblack@hotmail.com",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                )
              ],
            ),
            //sign out button
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Container(
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                      child: Text(
                    "Sign Out",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )),
                ),
              ),
            ),

            /* MaterialButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              color: Colors.deepPurple[200],
               
              child: Text(
                "Sign out",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )*/
          ],
        ),
      ),
    );
  }
}
