import 'package:flutter/material.dart';
import 'package:kadojopapp/Model/projectmodel.dart';

import '../components/components.dart';

class ProlectScreen extends StatelessWidget {
  List<ProjectModel> user = [
    ProjectModel(
      ProjectName: 'German  Recording',
      Body:
          'Online German Recording Task for Native\nBorne German (not immigrant)of German,\nEurope only.',
        projectType: true
      //  iconn: Icons.mic

    ),
    ProjectModel(
      ProjectName: 'German  Transcription',
      Body:
      'German Voices Transcription Project There are\nno conditions. Enter with us.\nTake a training before starting and read\nthe rules and start.',
      //  iconn: Icons.headset
        projectType: false
    ),
    ProjectModel(
      ProjectName: 'French  Recording',
      Body:
      'Online French Recording Task for Native\nBorne French (not immigrant)of French,\nEurope only.',
      //  iconn: Icons.mic
        projectType: true
    ),
    ProjectModel(
      ProjectName: 'French  Transcription',
      Body:
      'French Voices Transcription Project There are no\nconditions. Enter with us.\nTake a training before starting and read\nthe rules and start.',
       // iconn: Icons.headset
        projectType: false
    ),
    ProjectModel(
      ProjectName: 'Arabic  Recording',
      Body:
          'Online Arabic Recording Task for Native\nBorne Arabic (not immigrant)of Arabic.',
        //iconn: Icons.mic
        projectType: true
    ),
    ProjectModel(
      ProjectName: 'Arabic  Transcription',
      Body:
      'Arabic Transcription  Jordanian dialect,\nJordanians only required, enter with us,\ntake a training before starting, read\nthe rules and start.',
       // iconn: Icons.headset
        projectType: false
    ),
    ProjectModel(
      ProjectName: 'Portugal  Recording',
      Body:
          'Online Portugal Recording Task for Native\nBorne Portugal (not immigrant)of Portugal,\nEurope only Not Brazilian.',
        projectType: true
    ),
    ProjectModel(
      ProjectName: 'Swedish  Recording',
      Body:
          'Online Swedish Recording Task for Native\nBorne Swedish (not immigrant)of Sweden.',
        projectType: true
    ),
    ProjectModel(
      ProjectName: 'Italian  Transcription',
      Body:
      'Italian Voices Transcription Project There are no\nconditions. Enter with us.\nTake a training before starting and read\nthe rules and start.',
        projectType: false
    ),
/*
, */

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Available Projects",
          style: TextStyle(
            color: Color(0xFF285681),
          ),
        ),
        titleSpacing: 25,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: TextFormField(
                  onChanged: (s) {
                    print(s);
                  },
                  decoration: InputDecoration(
                    //focusColor: Colors.yellowAccent,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none),
                    icon: const Icon(Icons.search),

                    label: const Text(
                      'Serch',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )),
            ),
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => buildProject(user[index]),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 25,
                    ),
                itemCount: user.length),
            SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }
}

Widget buildProject(ProjectModel user) {
  return ProjectScreenContainer(
      Body: '${user.Body}', Tatole: '${user.ProjectName}',projectType:user.projectType);
}
/*Widget buildProject(ProjectModel user) => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  color: Color(0xFF285681),
                  borderRadius: BorderRadius.circular(15)),

            ),
          ],
        ),
        const SizedBox(
          width: 15,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${user.ProjectName}",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            Text(
              "${user.Body}",
              style: const TextStyle(
                fontSize: 10,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            )
          ],
        )
      ],
    );*/
