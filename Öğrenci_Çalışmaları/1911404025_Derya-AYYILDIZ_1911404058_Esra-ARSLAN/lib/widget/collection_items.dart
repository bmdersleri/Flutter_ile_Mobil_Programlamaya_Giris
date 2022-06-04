import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CollectionItems extends StatelessWidget {
  final ScrollController scrollController = ScrollController(
    initialScrollOffset: 215,
    keepScrollOffset: true,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25),
      width: MediaQuery.of(context).size.width,
      height: 260,
      child: ListView.builder(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: InkWell(
                     
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 130.0,
                            child: CircleAvatar(
                              backgroundImage: 
                              NetworkImage('https://uyg-ar.com/assets/img/team/team-7_600x600.jpg'),
                              radius: 125.0,
                            ),
                          ),
                          index == 1
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 15, right: 15),
                                  child: CircleAvatar(
                                      radius: 25.0,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        CupertinoIcons.heart_circle_fill,
                                        size: 50,
                                        color: Colors.orange,
                                      )),
                                )
                              : Container(),
                        ],
                      )),
                ),
                
              ],
            );
          }),
    );
  }
}
