import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'globals.dart' as globals;

void main() {
  runApp(ApiCalling());
}

class ApiCalling extends StatefulWidget {
  @override
  _ApiCallingState createState() => _ApiCallingState();
}

class _ApiCallingState extends State<ApiCalling> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
enum TtsState { playing, stopped }

class _HomePageState extends State<HomePage> {
  bool showLoader = false;
  FlutterTts flutterTts = FlutterTts();
  TtsState ttsState = TtsState.stopped;
  double volume = globals.tts_volume; // 1.0
  double pitch  = 1.0;
  double rate   = globals.tts_rate; // 0.5

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    initSpeak();
  }

  initSpeak() {
    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
      print('Speaking End');
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  Future _speak() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(globals.tts_volume);
    await flutterTts.setSpeechRate(globals.tts_rate);
    await flutterTts.setPitch(pitch);

    if (globals.tts_word != null) {
      if (globals.tts_word.isNotEmpty) {
        var result = await flutterTts.speak(globals.tts_word);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    globals.tts_word = globals.animalList[0]; // Cat
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  _speak();
                },
                child: Card(
                  elevation: 7.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 350.0,
                          width: 350.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "images/${globals.tts_word}.png",
                                  ),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)))),
                      Container(
                        height: 70.0,
                        width: 300.0,
                        child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: AutoSizeText(
                                globals.tts_word,
                                style: TextStyle(
                                    fontFamily: 'Twiddlestix',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                minFontSize: 15,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ), // hayvan resmi ve kutucuk boyutlandırma
            Slider(
              divisions: 10,
              label: "Pace",
              min: 0.0,
              max: 1.0,
              value: globals.tts_rate,
              onChanged: (val){
              setState(() {
                globals.tts_rate = val;
                }
                );
              },
              ),
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondRoute()),
                );
              },
            ), // sonraki sayfa butonu
          ],
        ),
      ),
    );
  }
}
/*
class _SliderWidget extends StatefulWidget{
  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<_SliderWidget>{
  double _value = 1.0;

  @override
  Widget build(BuildContext context){
    return Slider(
      label: "Rate",
      min: 0.0,
      max: 1.0,
      value: _value,
      onChanged: (val){
        setState(() {
          _value = val;
          globals.tts_rate = val;
        }
        );
      },
    );
  }
}
*/


/*class FirstRoute extends StatelessWidget {
  FirstRoute({super.key});
  RangeValues values = RangeValues(1.0, 10.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              child: const Text('Open route'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondRoute()),
                );// Navigate to second route when tapped.
              },
            ),
            ApiCalling(), // burası kedi resmini getiriyor
          ],
        ),
      ),
    );
  }
}*/

class SecondRoute extends StatefulWidget{
  const SecondRoute({super.key});

  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  _HomePageState hps = _HomePageState();

  @override
  Widget build(BuildContext context) {
    globals.tts_word = globals.animalList[1];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  hps._speak();
                },
                child: Card(
                  elevation: 7.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 350.0,
                          width: 350.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'images/${globals.tts_word}.png',
                                  ),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)))),
                      Container(
                        height: 70.0,
                        width: 300.0,
                        child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: AutoSizeText(
                                globals.tts_word,
                                style: TextStyle(
                                    fontFamily: 'Twiddlestix',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                minFontSize: 15,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ), // kedi resimleri filan buradan geldi
            Slider(
              label: "Pace",
              min: 0.0,
              max: 1.0,
              divisions: 10,
              value: globals.tts_rate,
              onChanged: (val){
                setState(() {
                  globals.tts_rate = val;
                }
                );
              },
            ), // slider
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ThirdRoute()),
                ); // Navigate to second route when tapped.
              },
            ),
          ],
        ),
      ),
    );
  }
}

mixin Mix on HomePage{
  mixa(){
    HomePage();
  }
}

mixin Mixb on _HomePageState{
  mixb(){
    _HomePageState();
  }
}

class ThirdRoute extends StatefulWidget{
  const ThirdRoute({super.key});

  @override
  _ThirdRouteState createState() => _ThirdRouteState();
}

class _ThirdRouteState extends State<ThirdRoute> {
  _HomePageState hps = _HomePageState();

  @override
  Widget build(BuildContext context) {
    globals.tts_word = globals.animalList[2];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  hps._speak();
                },
                child: Card(
                  elevation: 7.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 350.0,
                          width: 350.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "images/${globals.tts_word}.png",
                                  ),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)))),
                      Container(
                        height: 70.0,
                        width: 300.0,
                        child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: AutoSizeText(
                                globals.tts_word,
                                style: TextStyle(
                                    fontFamily: 'Twiddlestix',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                minFontSize: 15,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ), // kedi resimleri filan buradan geldi
            Slider(
              label: "Pace",
              min: 0.0,
              max: 1.0,
              divisions: 10,
              value: globals.tts_rate,
              onChanged: (val){
                setState(() {
                  globals.tts_rate = val;
                }
                );
              },
            ), // slider
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const fourthRoute()),
                ); // Navigate to second route when tapped.
              },
            ), // 2. sayfaız<vnmö
          ],
        ),
      ),
    );
  }
}

class fourthRoute extends StatefulWidget{
  const fourthRoute({super.key});

  @override
  _fourthRouteState createState() => _fourthRouteState();
}

class _fourthRouteState extends State<fourthRoute> {
  _HomePageState hps = _HomePageState();

  @override
  Widget build(BuildContext context) {
    globals.tts_word = globals.animalList[3];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  hps._speak();
                },
                child: Card(
                  elevation: 7.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 350.0,
                          width: 350.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "images/${globals.tts_word}.png",
                                  ),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)))),
                      Container(
                        height: 70.0,
                        width: 300.0,
                        child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: AutoSizeText(
                                globals.tts_word,
                                style: TextStyle(
                                    fontFamily: 'Twiddlestix',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                minFontSize: 15,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ), // kedi resimleri filan buradan geldi
            Slider(
              label: "Pace",
              min: 0.0,
              max: 1.0,
              divisions: 10,
              value: globals.tts_rate,
              onChanged: (val){
                setState(() {
                  globals.tts_rate = val;
                }
                );
              },
            ), // slider
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const fifthRoute()),
                ); // Navigate to second route when tapped.
              },
            ), // 2. sayfaız<vnmö
          ],
        ),
      ),
    );
  }
}

class fifthRoute extends StatefulWidget{
  const fifthRoute({super.key});

  @override
  _fifthRouteState createState() => _fifthRouteState();
}

class _fifthRouteState extends State<fifthRoute> {
  _HomePageState hps = _HomePageState();

  @override
  Widget build(BuildContext context) {
    globals.tts_word = globals.animalList[4];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  hps._speak();
                },
                child: Card(
                  elevation: 7.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 350.0,
                          width: 350.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "images/${globals.tts_word}.png",
                                  ),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)))),
                      Container(
                        height: 70.0,
                        width: 300.0,
                        child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: AutoSizeText(
                                globals.tts_word,
                                style: TextStyle(
                                    fontFamily: 'Twiddlestix',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                minFontSize: 15,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ), // kedi resimleri filan buradan geldi
            Slider(
              label: "Pace",
              min: 0.0,
              max: 1.0,
              divisions: 10,
              value: globals.tts_rate,
              onChanged: (val){
                setState(() {
                  globals.tts_rate = val;
                }
                );
              },
            ), // slider
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const sixthRoute()),
                ); // Navigate to second route when tapped.
              },
            ), // 2. sayfaız<vnmö
          ],
        ),
      ),
    );
  }
}

class sixthRoute extends StatefulWidget{
  const sixthRoute({super.key});

  @override
  _sixthRouteState createState() => _sixthRouteState();
}

class _sixthRouteState extends State<sixthRoute> {
  _HomePageState hps = _HomePageState();

  @override
  Widget build(BuildContext context) {
    globals.tts_word = globals.animalList[5];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  hps._speak();
                },
                child: Card(
                  elevation: 7.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 350.0,
                          width: 350.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "images/${globals.tts_word}.png",
                                  ),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)))),
                      Container(
                        height: 70.0,
                        width: 300.0,
                        child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: AutoSizeText(
                                globals.tts_word,
                                style: TextStyle(
                                    fontFamily: 'Twiddlestix',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                minFontSize: 15,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ), // kedi resimleri filan buradan geldi
            Slider(
              label: "Pace",
              min: 0.0,
              max: 1.0,
              divisions: 10,
              value: globals.tts_rate,
              onChanged: (val){
                setState(() {
                  globals.tts_rate = val;
                }
                );
              },
            ), // slider
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const seventhRoute()),
                ); // Navigate to second route when tapped.
              },
            ), // 2. sayfaız<vnmö
          ],
        ),
      ),
    );
  }
}

class seventhRoute extends StatefulWidget{
  const seventhRoute({super.key});

  @override
  _seventhRouteState createState() => _seventhRouteState();
}

class _seventhRouteState extends State<seventhRoute> {
  _HomePageState hps = _HomePageState();

  @override
  Widget build(BuildContext context) {
    globals.tts_word = globals.animalList[6];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  hps._speak();
                },
                child: Card(
                  elevation: 7.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 350.0,
                          width: 350.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "images/${globals.tts_word}.png",
                                  ),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)))),
                      Container(
                        height: 70.0,
                        width: 300.0,
                        child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: AutoSizeText(
                                globals.tts_word,
                                style: TextStyle(
                                    fontFamily: 'Twiddlestix',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                minFontSize: 15,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ), // kedi resimleri filan buradan geldi
            Slider(
              label: "Pace",
              min: 0.0,
              max: 1.0,
              divisions: 10,
              value: globals.tts_rate,
              onChanged: (val){
                setState(() {
                  globals.tts_rate = val;
                }
                );
              },
            ), // slider
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const eigthRoute()),
                ); // Navigate to second route when tapped.
              },
            ), // 2. sayfaız<vnmö
          ],
        ),
      ),
    );
  }
}

class eigthRoute extends StatefulWidget{
  const eigthRoute({super.key});

  @override
  _eigthRouteState createState() => _eigthRouteState();
}

class _eigthRouteState extends State<eigthRoute> {
  _HomePageState hps = _HomePageState();

  @override
  Widget build(BuildContext context) {
    globals.tts_word = globals.animalList[7];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  hps._speak();
                },
                child: Card(
                  elevation: 7.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 350.0,
                          width: 350.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "images/${globals.tts_word}.png",
                                  ),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)))),
                      Container(
                        height: 70.0,
                        width: 300.0,
                        child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: AutoSizeText(
                                globals.tts_word,
                                style: TextStyle(
                                    fontFamily: 'Twiddlestix',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                minFontSize: 15,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ), // kedi resimleri filan buradan geldi
            Slider(
              label: "Pace",
              min: 0.0,
              max: 1.0,
              divisions: 10,
              value: globals.tts_rate,
              onChanged: (val){
                setState(() {
                  globals.tts_rate = val;
                }
                );
              },
            ), // slider
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ninthRoute()),
                ); // Navigate to second route when tapped.
              },
            ), // 2. sayfaız<vnmö
          ],
        ),
      ),
    );
  }
}

class ninthRoute extends StatefulWidget{
  const ninthRoute({super.key});

  @override
  _ninthRouteState createState() => _ninthRouteState();
}

class _ninthRouteState extends State<ninthRoute> {
  _HomePageState hps = _HomePageState();

  @override
  Widget build(BuildContext context) {
    globals.tts_word = globals.animalList[8];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  hps._speak();
                },
                child: Card(
                  elevation: 7.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 350.0,
                          width: 350.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "images/${globals.tts_word}.png",
                                  ),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)))),
                      Container(
                        height: 70.0,
                        width: 300.0,
                        child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: AutoSizeText(
                                globals.tts_word,
                                style: TextStyle(
                                    fontFamily: 'Twiddlestix',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                minFontSize: 15,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ), // kedi resimleri filan buradan geldi
            Slider(
              label: "Pace",
              min: 0.0,
              max: 1.0,
              divisions: 10,
              value: globals.tts_rate,
              onChanged: (val){
                setState(() {
                  globals.tts_rate = val;
                }
                );
              },
            ), // slider
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => tenthRoute()),
                ); // Navigate to second route when tapped.
              },
            ), // 2. sayfaız<vnmö
          ],
        ),
      ),
    );
  }
}

class tenthRoute extends StatefulWidget{
  const tenthRoute({super.key});

  @override
  _tenthRouteState createState() => _tenthRouteState();
}

class _tenthRouteState extends State<tenthRoute> {
  _HomePageState hps = _HomePageState();

  @override
  Widget build(BuildContext context) {
    globals.tts_word = globals.animalList[9];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  hps._speak();
                },
                child: Card(
                  elevation: 7.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 350.0,
                          width: 350.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "images/${globals.tts_word}.png",
                                  ),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)))),
                      Container(
                        height: 70.0,
                        width: 300.0,
                        child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: AutoSizeText(
                                globals.tts_word,
                                style: TextStyle(
                                    fontFamily: 'Twiddlestix',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                minFontSize: 15,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ), // kedi resimleri filan buradan geldi
            Slider(
              label: "Pace",
              min: 0.0,
              max: 1.0,
              divisions: 10,
              value: globals.tts_rate,
              onChanged: (val){
                setState(() {
                  globals.tts_rate = val;
                }
                );
              },
            ), // slider
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => eleventhRoute()),
                ); // Navigate to second route when tapped.
              },
            ), // 2. sayfaız<vnmö
          ],
        ),
      ),
    );
  }
}

class eleventhRoute extends StatefulWidget{
  const eleventhRoute({super.key});

  @override
  _eleventhRouteState createState() => _eleventhRouteState();
}

class _eleventhRouteState extends State<eleventhRoute> {
  _HomePageState hps = _HomePageState();

  @override
  Widget build(BuildContext context) {
    globals.tts_word = globals.animalList[10];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  hps._speak();
                },
                child: Card(
                  elevation: 7.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 350.0,
                          width: 350.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "images/${globals.tts_word}.png",
                                  ),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)))),
                      Container(
                        height: 70.0,
                        width: 300.0,
                        child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: AutoSizeText(
                                globals.tts_word,
                                style: TextStyle(
                                    fontFamily: 'Twiddlestix',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                minFontSize: 15,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ), // kedi resimleri filan buradan geldi
            Slider(
              label: "Pace",
              min: 0.0,
              max: 1.0,
              divisions: 10,
              value: globals.tts_rate,
              onChanged: (val){
                setState(() {
                  globals.tts_rate = val;
                }
                );
              },
            ), // slider
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => twelfthRoute()),
                ); // Navigate to second route when tapped.
              },
            ), // 2. sayfaız<vnmö
          ],
        ),
      ),
    );
  }
}

class twelfthRoute extends StatefulWidget{
  const twelfthRoute({super.key});

  @override
  _twelfthRouteState createState() => _twelfthRouteState();
}

class _twelfthRouteState extends State<twelfthRoute> {
  _HomePageState hps = _HomePageState();

  @override
  Widget build(BuildContext context) {
    globals.tts_word = globals.animalList[11];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  hps._speak();
                },
                child: Card(
                  elevation: 7.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 350.0,
                          width: 350.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "images/${globals.tts_word}.png",
                                  ),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)))),
                      Container(
                        height: 70.0,
                        width: 300.0,
                        child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: AutoSizeText(
                                globals.tts_word,
                                style: TextStyle(
                                    fontFamily: 'Twiddlestix',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                minFontSize: 15,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ), // kedi resimleri filan buradan geldi
            Slider(
              label: "Pace",
              min: 0.0,
              max: 1.0,
              divisions: 10,
              value: globals.tts_rate,
              onChanged: (val){
                setState(() {
                  globals.tts_rate = val;
                }
                );
              },
            ), // slider
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const thirteenthRoute()),
                ); // Navigate to second route when tapped.
              },
            ), // 2. sayfaız<vnmö
          ],
        ),
      ),
    );
  }
}

class thirteenthRoute extends StatefulWidget{
  const thirteenthRoute({super.key});

  @override
  _thirteenthRouteState createState() => _thirteenthRouteState();
}

class _thirteenthRouteState extends State<thirteenthRoute> {
  _HomePageState hps = _HomePageState();

  @override
  Widget build(BuildContext context) {
    globals.tts_word = globals.animalList[12];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  hps._speak();
                },
                child: Card(
                  elevation: 7.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 350.0,
                          width: 350.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "images/${globals.tts_word}.png",
                                  ),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)))),
                      Container(
                        height: 70.0,
                        width: 300.0,
                        child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: AutoSizeText(
                                globals.tts_word,
                                style: TextStyle(
                                    fontFamily: 'Twiddlestix',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                minFontSize: 15,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ), // kedi resimleri filan buradan geldi
            Slider(
              label: "Pace",
              min: 0.0,
              max: 1.0,
              divisions: 10,
              value: globals.tts_rate,
              onChanged: (val){
                setState(() {
                  globals.tts_rate = val;
                }
                );
              },
            ), // slider
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const fourteenthRoute()),
                ); // Navigate to second route when tapped.
              },
            ), // 2. sayfaız<vnmö
          ],
        ),
      ),
    );
  }
}


class fourteenthRoute extends StatefulWidget{
  const fourteenthRoute({super.key});

  @override
  _fourteenthRouteState createState() => _fourteenthRouteState();
}

class _fourteenthRouteState extends State<fourteenthRoute> {
  _HomePageState hps = _HomePageState();

  @override
  Widget build(BuildContext context) {
    globals.tts_word = globals.animalList[13];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  hps._speak();
                },
                child: Card(
                  elevation: 7.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 350.0,
                          width: 350.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "images/${globals.tts_word}.png",
                                  ),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)))),
                      Container(
                        height: 70.0,
                        width: 300.0,
                        child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: AutoSizeText(
                                globals.tts_word,
                                style: TextStyle(
                                    fontFamily: 'Twiddlestix',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                minFontSize: 15,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ), // kedi resimleri filan buradan geldi
            Slider(
              label: "Pace",
              min: 0.0,
              max: 1.0,
              divisions: 10,
              value: globals.tts_rate,
              onChanged: (val){
                setState(() {
                  globals.tts_rate = val;
                }
                );
              },
            ), // slider
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const fifteenthRoute()),
                ); // Navigate to second route when tapped.
              },
            ), // 2. sayfaız<vnmö
          ],
        ),
      ),
    );
  }
}

class fifteenthRoute extends StatefulWidget{
  const fifteenthRoute({super.key});

  @override
  _fifteenthRouteState createState() => _fifteenthRouteState();
}

class _fifteenthRouteState extends State<fifteenthRoute> {
  _HomePageState hps = _HomePageState();

  @override
  Widget build(BuildContext context) {
    globals.tts_word = globals.animalList[14];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  hps._speak();
                },
                child: Card(
                  elevation: 7.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 350.0,
                          width: 350.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "images/${globals.tts_word}.png",
                                  ),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)))),
                      Container(
                        height: 70.0,
                        width: 300.0,
                        child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: AutoSizeText(
                                globals.tts_word,
                                style: TextStyle(
                                    fontFamily: 'Twiddlestix',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                minFontSize: 15,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ), // kedi resimleri filan buradan geldi
            Slider(
              label: "Pace",
              min: 0.0,
              max: 1.0,
              divisions: 10,
              value: globals.tts_rate,
              onChanged: (val){
                setState(() {
                  globals.tts_rate = val;
                }
                );
              },
            ), // slider
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const sixteenthRoute()),
                ); // Navigate to second route when tapped.
              },
            ), // 2. sayfaız<vnmö
          ],
        ),
      ),
    );
  }
}

class sixteenthRoute extends StatefulWidget{
  const sixteenthRoute({super.key});

  @override
  _sixteenthRouteState createState() => _sixteenthRouteState();
}

class _sixteenthRouteState extends State<sixteenthRoute> {
  _HomePageState hps = _HomePageState();

  @override
  Widget build(BuildContext context) {
    globals.tts_word = globals.animalList[15];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  hps._speak();
                },
                child: Card(
                  elevation: 7.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 350.0,
                          width: 350.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "images/${globals.tts_word}.png",
                                  ),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)))),
                      Container(
                        height: 70.0,
                        width: 300.0,
                        child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: AutoSizeText(
                                globals.tts_word,
                                style: TextStyle(
                                    fontFamily: 'Twiddlestix',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                minFontSize: 15,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ), // kedi resimleri filan buradan geldi
            Slider(
              label: "Pace",
              min: 0.0,
              max: 1.0,
              divisions: 10,
              value: globals.tts_rate,
              onChanged: (val){
                setState(() {
                  globals.tts_rate = val;
                }
                );
              },
            ), // slider
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                ); // Navigate to second route when tapped.
              },
            ), // 2. sayfaız<vnmö
          ],
        ),
      ),
    );
  }
}