import 'package:flutter/material.dart';
import 'package:hayvantakipsistemi/model/tohumlamasayfasi/refreshTohumlama.dart';
import 'package:hayvantakipsistemi/model/tohumlamasayfasi/tohumlamaekle.dart';

class TohumlamaSayfasi extends StatefulWidget {
  const TohumlamaSayfasi({Key? key}) : super(key: key);

  @override
  State<TohumlamaSayfasi> createState() => _TohumlamaSayfasiState();
}

class _TohumlamaSayfasiState extends State<TohumlamaSayfasi> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/anasayfa');
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Color(0xFF375BA3),
                  size: 35,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/anasayfa');
                },
              ),
              title: Text(
                "Tohumlama",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Color(0xFF375BA3)),
              )),
          backgroundColor: Colors.white,
          floatingActionButton: GestureDetector(
            onTap: (() {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.9),
                        child: Scaffold(
                          appBar: AppBar(
                            backgroundColor: Colors.transparent,
                            automaticallyImplyLeading: false,
                            title: Text(
                              "Tohumlama Ekle",
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
                            child: TohumalamaEkleModal(sayfayonlendir: true),
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
          ),
          body: Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, top: 8),
              child: Column(children: [
                Expanded(child: RefreshTohumlama()),
              ]))),
    );
  }
}
