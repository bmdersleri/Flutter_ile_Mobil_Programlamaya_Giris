import 'dart:convert';
import 'dart:async';
import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';

class UsefulPage extends StatefulWidget {
  final String sshIP;
  final String sshUsername;
  final String sshPassword;

  // ignore: use_key_in_widget_constructors
  const UsefulPage(
      {required this.sshIP,
      required this.sshPassword,
      required this.sshUsername});

  @override
  _UsefulState createState() => _UsefulState();
}

class _UsefulState extends State<UsefulPage> {
  String commandSSH = '';
  String outCommand = '';
  String fullOutput = '';
  String dir = '';
  String comp = '';

  bool isConnected = false;
  late SSHClient client;

  @override
  initState() {
    if (isConnected == false) {
      connectSSH();
    }

    super.initState();
    setState(() {});
  }

  waitForSeconds(int milsec) async {
    await Future.delayed(Duration(milliseconds: milsec), () {});
  }

  Future<void> connectSSH() async {
    //CONNECT
    client = SSHClient(
      await SSHSocket.connect(widget.sshIP, 22),
      username: widget.sshUsername,
      onPasswordRequest: () => widget.sshPassword,
    );

    isConnected = true;
    //GET COMPUTER NAME
    final compname = await client.run('uname -n', stderr: false);
    comp = utf8.decode(compname);
    comp = comp.replaceAll(RegExp(r"\s+"), "");
    comp = comp + '@' + widget.sshUsername;
  }

  executeCommand(String commandSSH) async {
    if (commandSSH.isEmpty) {
      // no code
    } else if (commandSSH == 'clear') {
      fullOutput = ' ';
      outCommand = ' ';
    } else {
      final command = await client.run(commandSSH);
      outCommand = utf8.decode(command);
      waitForSeconds(200);
      appendText(outCommand);
      commandSSH = '';
      outCommand = '';
      setState(() {});
    }
  }

  appendText(String text) async =>
      fullOutput += '$comp > $commandSSH\n$outCommand\n';

  final _commandController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("SSHx Alpha 0.0.1")),
          backgroundColor: Colors.purple,
        ),
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    fullOutput,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.black87,
                    border: Border.all(
                        style: BorderStyle.solid, color: Colors.black)),
              )),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: _commandController,
                  onChanged: (val) {
                    commandSSH = val;
                  },
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            executeCommand(commandSSH);

                            _commandController.clear();
                          });
                        },
                        child: const Icon(Icons.send),
                      ),
                      labelText: 'Command',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0))),
                ),
              ),
            ],
          ),
        ));

    // TEXT BOX FOR COMMANDS
  }
}
