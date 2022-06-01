import 'package:flutter/material.dart';


class GradientBackground extends StatefulWidget {

  final List<Widget> children;
  final int color1;
  final int color2;
  final int color3;

  const GradientBackground({Key? key,required this.color1,required this.color2,required this.color3,required this.children}) : super(key: key);

  @override
  State<GradientBackground> createState() => _GradientBackgroundState();
}

class _GradientBackgroundState extends State<GradientBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.1,0.4,1],
            colors: [
              Color(widget.color1),
              Color(widget.color2),
              Color(widget.color3),
            ],
          ),
        ),
      child: Column(
        children: widget.children,
      ),
    );
  }
}
