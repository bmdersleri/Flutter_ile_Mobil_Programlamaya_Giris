import 'package:flutter/material.dart';

class FilterValues{

  static List<String> listSelectedGenres = ["Action"];
  static List<String> listSelectedTypes = ["Movie","Series"];
  static double? imdbSelectedValue = 0;
  static TextEditingController minYearController = TextEditingController();
  static TextEditingController maxYearController = TextEditingController();


  static double GetMinImdbValue(String val){

    double minIMDB=0;
    if(val == "Rated Over 7") minIMDB = 7;
    else if(val == "Rated Over 7.5") minIMDB = 7.5;
    else if(val == "Rated Over 8") minIMDB = 8;
    else if(val == "Rated Over 8.5") minIMDB = 8.5;
    else if(val == "Rated Over 9") minIMDB = 9;

    return minIMDB;
  }


  static String GetImdbSelectedValue(){

    String selectedVal ="Ignore This Filter";
    if(imdbSelectedValue == 7) selectedVal = "Rated Over 7";
    else if(imdbSelectedValue == 7.5) selectedVal = "Rated Over 7.5";
    else if(imdbSelectedValue == 8) selectedVal = "Rated Over 8";
    else if(imdbSelectedValue == 8.5) selectedVal = "Rated Over 8.5";
    else if(imdbSelectedValue == 9) selectedVal = "Rated Over 9";

    return selectedVal;
  }

}