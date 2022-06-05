
import 'package:flutter/material.dart';
import 'package:hayvantakipsistemi/model/bottomnavigatorbar.dart';

class FloatingActionButtonClass extends StatefulWidget {
  String baslik;
  String bottomtext;
  String hinttext;
  var height;
  var sayfa;
  FloatingActionButtonClass(
      {Key? key,
      required this.baslik,
      required this.sayfa,
      required this.height,
      required this.bottomtext,
      required this.hinttext,
      })
      : super(key: key);

  @override
  State<FloatingActionButtonClass> createState() =>
      _FloatingActionButtonClassState();
}

class _FloatingActionButtonClassState extends State<FloatingActionButtonClass> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (() {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: widget.height),
                    child: Scaffold(
                      bottomNavigationBar: BottomNavigatorBarSayfa(
                          onpress:(){
                            print("object");
                          },
                          bottomtext: widget.bottomtext,
                          hinttext: widget.hinttext),
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        automaticallyImplyLeading: false,
                        title: Text(
                          widget.baslik,
                          style: TextStyle(
                            color: Color(0xFF375BA3),
                          ),
                        ),
                        actions: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close),
                            color: Color(0xFF375BA3),
                          )
                        ],
                        elevation: 0,
                      ),
                      body: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: widget.sayfa,
                      ),
                    ),
                  ));
        }),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(34),
            gradient: LinearGradient(
              colors: [Color(0xFF375BA3), Color(0xFF29E3D7)],
              begin: FractionalOffset.centerLeft,
              end: FractionalOffset.centerRight,
            ),
          ),
          child: Icon(
            Icons.add,
            color: Colors.white.withOpacity(0.8),
            size: 35,
          ),
        ),
      );
  }
}
