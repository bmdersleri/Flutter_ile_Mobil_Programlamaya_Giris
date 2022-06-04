import 'package:flutter/material.dart';

class UserFavAdd extends StatelessWidget {
  Function favClick;
  bool isFav;
  UserFavAdd({required this.isFav,required this.favClick,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          favClick();
        },
        icon: isFav == true ? Icon(
          Icons.favorite,
          size: 28,
          color: Colors.red,
        ) : Icon(Icons.favorite_outline,color: Colors.red,size: 28,)
        
    );
  }
}
