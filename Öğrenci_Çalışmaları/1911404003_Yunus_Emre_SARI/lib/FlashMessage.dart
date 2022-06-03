import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class FlashMessage{

  static void ShowFlashMessage({
    required BuildContext? context,
    required String text,
    int miliseconds = 2000,
  }) {
    showFlash(
      context: context!,
      duration: Duration(milliseconds: miliseconds),
      builder: (context, controller) {
        return Flash(
          controller: controller,
          constraints: BoxConstraints(maxWidth: phoneWidth*0.8),
          behavior: FlashBehavior.floating,
          position: FlashPosition.top,
          enableVerticalDrag: true,
          boxShadows: kElevationToShadow[15],
          backgroundColor: appColors.clrGrey,
          margin: EdgeInsets.only(top: 25),
          borderRadius: BorderRadius.circular(10),
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          child: FlashBar(
            content: Text(text,textAlign: TextAlign.center,),
          ),
        );
      },
    );
  }

}





