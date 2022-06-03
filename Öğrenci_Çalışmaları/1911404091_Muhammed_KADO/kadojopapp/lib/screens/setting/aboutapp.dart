import 'package:flutter/material.dart';

import '../../Model/shar.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: TextColors,
          title: const Text('About This App'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: double.infinity,color: Colors.grey, child: Image.asset('asset/img/logo2.png'))),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,


                children:  [
                  const    Text('KadoJob V1.0.',style:  TextStyle(
                    fontSize: 20
                  ),),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'We are a company that aims to provide jobs for people who want to provide them with additional income and help individuals develop their skills and professional backgrounds We also provide applicants with training to help them facilitate their work throughout their time working with us.',
                    style: TextStyle(color: TextColors,fontSize: 20),
                  ),
                  const Text('This application has been programmed with Flutter + Firebase.',
                  style:TextStyle(
                    fontSize: 15
                  ),

                  ),const SizedBox(
                    height: 10,
                  ),
                  const Text('Programmed by Muhammed Kado',style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                      ,color: Colors.grey
                  ),),
                ],
              ),
            )
      ],
        ),
      );
  }
}
