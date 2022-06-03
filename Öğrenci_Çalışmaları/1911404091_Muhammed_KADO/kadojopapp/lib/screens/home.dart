
import 'package:flutter/material.dart';
import 'package:kadojopapp/Model/shar.dart';
import 'package:kadojopapp/components/components.dart';

class home extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Text(''),
          //backgroundColor: Colors.white,
          title:  const Center(
            child: Image(
              image: AssetImage('asset/img/logo2.png',),
              height: 40,
            ),
          ),
          backgroundColor: Colors.white,

        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 260,
                color: TextColors,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 10,
                    right: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  const [
                      Text(
                        'Do not miss the chance to earn extra income.This is a great opportunity for you and your friends!',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 28),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'we are extremely excited to have you join the Kado Job and participate in our Projects',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      Icon(
                        Icons.headset,color: Colors.grey,),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Old Transcription  Projcet', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: TextColors,
                      ),),
                      SizedBox(
                        width: 50,
                      ),
                      const Text('see more -> ', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                     scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [

                          ProjectContainer( Tatole:'Dutch Transcription',
                              Body: 'A previous Dutch transcription project worked with us 24 Native people '),
                          const SizedBox(
                            width: 24,
                          ),
                          ProjectContainer( Tatole:'Italian Transcription',
                              Body: 'A previous Italian transcription project worked with us 250 Native people'),
                          const SizedBox(
                            width: 24,
                          ),
                          ProjectContainer( Tatole:'Turkish Transcription',
                              Body: 'A previous Turkish transcription project worked with us 200 Native people'),
                          const SizedBox(
                            width: 24,
                          ),
                          ProjectContainer( Tatole:'Polish Transcription',
                              Body: 'A previous Polish transcription project worked with us 25 Native people'),
                          const SizedBox(
                            width: 24,
                          ),
                          ProjectContainer( Tatole:'English Transcription',
                              Body: 'A previous English transcription project worked with us 300 Native people'),
                          const SizedBox(
                            width: 24,
                          ),
                          ProjectContainer( Tatole:'French Transcription',
                              Body: 'A previous French transcription project worked with us 500 Native people'),
                          const SizedBox(
                            width: 24,
                          ),
                          ProjectContainer( Tatole:'Portuguese Transcription',
                              Body: 'A previous Portuguese transcription project worked with us 55 Native people'),
                          const SizedBox(
                            width: 24,
                          ),
                          ProjectContainer( Tatole:'Thai Transcription',
                              Body: 'A previous Thai transcription project worked with us 30 Native people'),
                          const SizedBox(
                            width: 24,
                          ),
                          ProjectContainer( Tatole:'Egypt Transcription',
                              Body: 'A previous Egypt transcription project worked with us 3000 Native people'),
                          const SizedBox(
                            width: 24,
                          ),
                          ProjectContainer( Tatole:'Swedish Transcription',
                              Body: 'A previous Swedish transcription project worked with us 50 Native people'),
                          const SizedBox(
                            width: 24,
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                      Icons.mic,color: Colors.grey,),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Old Recording  Projects', style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: TextColors,
                      ),),
                      SizedBox(
                        width: 70,
                      ),
                      const   Text('see more -> ', style:  TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          ProjectContainer( Tatole:'Spanish Recording',
                              Body: 'A previous Spanish recording  project worked with us 100 Native people',micc: true),
                          const SizedBox(
                            width: 24,
                          ),
                          ProjectContainer( Tatole:'Arabic Recording',
                              Body: 'A previous Arabic recording project worked with us 800 Native people',micc: true),
                          const SizedBox(
                            width: 24,
                          ),
                          ProjectContainer( Tatole:'Turkish Recording',
                              Body: 'A previous Turkish recording project worked with us 500 Native people',micc: true),
                          const SizedBox(
                            width: 24,
                          ),
                          ProjectContainer( Tatole:'German Recording',
                              Body: 'A previous German recording project worked with us 300 Native people',micc: true),
                          const SizedBox(
                            width: 24,
                          ),
                          ProjectContainer( Tatole:'French Recording',
                              Body: 'A previous French recording project worked with us 400 Native people',micc: true),
                          const SizedBox(
                            width: 24,
                          ),
                          ProjectContainer( Tatole:'Malaysian Recording',
                              Body: 'A previous Malaysian recording project worked with us 50 Native people',micc: true),
                          const SizedBox(
                            width: 24,
                          ),
                          ProjectContainer( Tatole:'Uzbekistan Recording',
                              Body: 'A previous Uzbekistan recording project worked with us 50 Native people',micc: true),
                          const SizedBox(
                            width: 24,
                          ),

                          ProjectContainer( Tatole:'Portuguese Recording',
                              Body: 'A previous Portuguese recording project worked with us 100 Native people',micc: true),
                          const SizedBox(
                            width: 24,
                          ),
                          ProjectContainer( Tatole:'Swedish Recording',
                              Body: 'A previous Swedish recording project worked with us 50 Native people',micc: true),
                          const SizedBox(
                            width: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
