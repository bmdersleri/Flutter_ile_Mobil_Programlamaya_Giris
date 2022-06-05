import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hayvantakipsistemi/model/veriler.dart';

class Bilgiler extends StatefulWidget {
  var resim;
  var icerik;
  var icon;
  bool deger;
  Bilgiler(
      {Key? key,
      required this.icerik,
      required this.deger,
      required this.icon,
      required this.resim,})
      : super(key: key);

  @override
  State<Bilgiler> createState() => _BilgilerState();
}

class _BilgilerState extends State<Bilgiler> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 12,bottom: 3),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
            ),
            border: Border.all(width: 2, color: Color(0xFF375BA3)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: widget.icerik,flex: 6,),
                  Expanded(
                    flex: 2,
                    child: CircleAvatar(
                radius: 40.0,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(widget.resim)),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 3,
          top:4,
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: widget.icon,
          ),
        ),

      ],
    );
  }
}
