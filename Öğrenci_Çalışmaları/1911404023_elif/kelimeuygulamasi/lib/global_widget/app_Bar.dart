import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSize appBar(context,
    {@required Widget? left,
    @required Widget? center,
    Widget? right,
    Function? leftWidgetOnClick}) {
  return PreferredSize(
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width * 0.2,
              child: InkWell(
                onTap: () => leftWidgetOnClick!(),
                child: left,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.5,
              child: center,
            ),
            Container(
              alignment: Alignment.centerRight,
              width: MediaQuery.of(context).size.width * 0.2,
              child: right,
            )
          ],
        ),
      ),
      preferredSize: Size.fromHeight(50));
}