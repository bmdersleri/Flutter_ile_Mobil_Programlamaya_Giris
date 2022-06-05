import 'dart:async';

import 'package:flutter/material.dart';

class BottomNavigatorBarSayfa extends StatefulWidget {
  BottomNavigatorBarSayfa(
      {Key? key,
      required this.hinttext,
      required this.bottomtext,
      required this.onpress})
      : super(key: key);
  String? hinttext;
  var onpress;
  String? bottomtext;
  @override
  State<BottomNavigatorBarSayfa> createState() =>
      _BottomNavigatorBarSayfaState();
}

class _BottomNavigatorBarSayfaState extends State<BottomNavigatorBarSayfa> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 16),
        child: Container(
            padding: EdgeInsets.only(right: 35, left: 35),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              gradient: LinearGradient(
                colors: [Color(0xFF375BA3), Color(0xFF29E3D7)],
                begin: FractionalOffset.centerLeft,
                end: FractionalOffset.centerRight,
              ),
            ),
            child: TextButton(
              onPressed: () {
                widget.onpress;
                startTimer(widget.hinttext!);
              },
              child: Text(
                widget.bottomtext!,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            )));
  }

  Timer? _timer;
  void startTimer(String hinttext) {
    int _start = 50;
    const oneSec = const Duration(milliseconds: 10);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            Navigator.pop(context);
            Navigator.pop(context);
          });
        } else if (_start == 50) {
          _start--;
          showDialog(
            context: context,
            builder: (context) {
              return Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  GestureDetector(
                    onTap: (() {
                      Navigator.pop(context);
                    }),
                    child: Container(
                      width: 180,
                      height: 30,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF375BA3), Color(0xFF29E3D7)],
                          begin: FractionalOffset.centerLeft,
                          end: FractionalOffset.centerRight,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            hinttext,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "lucida",
                              fontSize: 12,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
}
