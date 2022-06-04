
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class about extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('در باره برنامه '),
          ],
        ),

        backgroundColor: Colors.teal,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 300,
              width: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white54,
          ),

          child: Padding(
            padding: const EdgeInsets.all(15),
            child:Container(
              child: Text(
                  'عنوان کتاب: سخنی با جوانان\n'
                   'نویسنده: محمد بن عبدالله الدویش\n'
                   'مترجم: محمد کیانی\n'' موضوع: مواعظ و حکمتها\n'
                  'تاریخ انتشار: آبان )عقرب( ۱۳۹۴شمسی،  ۱۴۳۶هجری،  ۱۴۳۷قمری\n'
                       'منبع: از سایت کتابخانۀ عقیده'
                      '\n'
                      '\n'
                      '\n'
                      '\n'
                      '\n'
                      '\n'
                      '\n'
                      '\n'

                 '\nAdı Soyadı: Saifuddin Hassani '
                  '\n'
                '\nEmail: sfdn.hassani@gmail.com ',
                style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                textAlign: TextAlign.end,

                  ),
            ),

          ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 125,
              width: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white54,
              ),

              child: Padding(
                padding: const EdgeInsets.all(8),
                child:Container(
                  child: Text(

                        '\nAdı Soyadı: Saifuddin Hassani '
                        '\n'

                        '\nEmail: sfdn.hassani@gmail.com ',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      color: Colors.black87,
                      fontSize: 18,
                    ),

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