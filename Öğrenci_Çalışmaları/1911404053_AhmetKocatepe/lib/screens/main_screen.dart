import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:hava/communication.dart';
import 'package:hava/utils/weather.dart';


class MainScreen extends StatefulWidget {
  final WeatherData weatherData;
  const MainScreen({Key? key, required this.weatherData}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int temperature;
  late Icon weatherDisplayIcon;
  late AssetImage backgroundImage;
  late String city;

  void updateDisplayInfo(WeatherData weatherData){
    setState((){
      temperature = weatherData.currentTemperature.round();
      city = weatherData.city;
      WeatherDisplayData weatherDisplayData = weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
    });
  }
  @override
  void initState(){
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Forecast"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(),
              accountName: Text(
                "Ahmet KOCATEPE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                "ahmetkocatepebm@gmail.com",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: FlutterLogo(),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Home Page'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.phone_android,
              ),
              title: const Text('Communication'),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>const comminication()));
              },
            ),
            AboutListTile(
              icon: Icon(
                Icons.info,
              ),
              child: Text('About app'),
              applicationIcon: Icon(
                Icons.local_play,
              ),
              applicationName: 'Weather Forecast',
              applicationVersion: '1.0.0',
              applicationLegalese: '© 2022 Company',
              aboutBoxChildren: [
              ],
            ),
          ],
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40,),
            Container(
              child: weatherDisplayIcon,
            ),
            SizedBox(height: 15,),
            Center(
              child: Text('$temperature°',
                style: TextStyle(
                    fontFamily:'AbrilFatface' ,
                    color: Colors.white,
                    fontSize: 80.0,
                    letterSpacing: -5
                ),
              ),
            ),
            SizedBox(height: 15,),
            Center(
              child: Text(city,
                style: TextStyle(
                    fontFamily: 'AbrilFatface',
                    color: Colors.white,
                    fontSize: 60.0,
                    letterSpacing: -5
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}