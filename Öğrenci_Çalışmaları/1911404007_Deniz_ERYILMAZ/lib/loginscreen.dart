import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutnix/home.dart';
import 'package:flutter/material.dart';
import 'package:dartssh2/dartssh2.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

//----------------------------- STATES
class _HomeState extends State<Home> {
  StreamSubscription? connection;
  bool isoffline = false;
  String sshIP = '';
  String sshUsername = '';
  String sshPassword = '';

  @override
  void initState() {
    connection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi) {
        setState(() {
          isoffline = false;
        });
      } else {
        setState(() {
          isoffline = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    connection!.cancel();
    super.dispose();
  }

  sshConnect() async {
    SSHClient? client;
    try {
      client = SSHClient(
        await SSHSocket.connect(sshIP, 22),
        username: sshUsername,
        onPasswordRequest: () => sshPassword,
      );
      _navigateToHome(client);
    } catch (e) {
      //client = null;
      //isConnectedSSH = false;
      debugPrint("Connection refused");
      debugPrint("Error:" + e.toString());
      showDialog(context: context, builder: (context) => const ErrorWidget());
    }
  }

  _navigateToHome(SSHClient client) async {
    await Future.delayed(const Duration(milliseconds: 5000), () {});
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => UsefulPage(
                sshIP: sshIP,
                sshPassword: sshPassword,
                sshUsername: sshUsername)));
  }

//------------------------------- STATELESS WIDGETS
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("SSHx Alpha 0.0.1")),
        backgroundColor: Colors.purple,
      ),
      body: Center(
          child: ListView(children: [
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(bottom: 30),
          color: isoffline ? Colors.red : Colors.lightGreen,
          //red color on offline, green on online
          padding: const EdgeInsets.all(10),
          child: Text(
            isoffline
                ? "Wi-Fi Connection : Offline"
                : "Wi-Fi Connection : Online",
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (val) {
              setState(() {
                sshIP = val;
              });
            },
            decoration: InputDecoration(
                labelText: 'SSH: Local Machine IP',
                hintText: '192.168.x.x',
                icon: const Icon(Icons.computer),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (val) {
              setState(() {
                sshUsername = val;
              });
            },
            decoration: InputDecoration(
                labelText: 'SSH: Username',
                hintText: 'Example: root',
                icon: const Icon(Icons.person),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: TextField(
            keyboardType: TextInputType.text,
            onChanged: (val) {
              setState(() {
                sshPassword = val;
              });
            },
            obscureText: true,
            decoration: InputDecoration(
                labelText: 'SSH: Password',
                hintText: '*************',
                icon: const Icon(Icons.password),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: ButtonTheme(
              height: 56,
              child: TextButton(
                  child: const Text('Login',
                      style: TextStyle(color: Colors.black87, fontSize: 20)),
                  onPressed: () => {sshConnect()})),
        )
      ])),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text("Couldnt connect SSH..."),
    );
  }
}
