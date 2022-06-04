
import 'package:flutter/material.dart';

class fur extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text('لذت غلبه بر نفس'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,

          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 540,
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white54,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 28, right: 5),
                  child: Text(''
                       'هرچند کسانی که به برخی از کارها و خوشی‌های زودگذر روی می‌آورند، لذت‌های گذرایی دارند، اما دختر و پسری که عفت و پاک‌دامنی پیشه می‌کنند، لذت و حلاوتی بس بزرگ‌تر و فراتر از شهوت‌رانان و بدکاران می‌یابند، رادمردی و انسانیت راستین این است که شخص بتواند به وقتش به نفس خود نه بگوید و شهوتش را در قید و کنترل خویش درآورد؛ نه آنکه خودش در بند شهوت و هوای خویش قرار بگیرد. برعکس کسی که در پی شهوت خویش حرکت می‌کند و اسیر هوای نفسش می‌گردد، بیشتر به حیوانی می‌ماند که هیچ مانع و نیروی بازدارنده‌ای میان او و شهوت افسار گسیخته‌اش وجود ندارد',
                    style: TextStyle(
                      fontFamily: 'NotoNastaliqUrdu',
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
          ],
        ),

      ),
      );



  }
}