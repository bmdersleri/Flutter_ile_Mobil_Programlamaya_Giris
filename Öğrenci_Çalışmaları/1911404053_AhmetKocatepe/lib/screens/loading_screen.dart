import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hava/screens/main_screen.dart';
import 'package:hava/utils/location.dart';
import 'package:hava/utils/weather.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LocationHelper locationData;
  Future<void> getLocationData() async{
    locationData = LocationHelper();
    await locationData.getCurrentLocation();

    if(locationData.latitude == null || locationData.longitude == null){
      print("konum bilgileri gelmiyor");
    }
    else{
      print("latitude:"+ locationData.latitude.toString());
      print("longitude"+ locationData.longitude.toString());
    }
  }

  void getWeatherData() async{
    await getLocationData();

    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();

    if(weatherData.currentTemperature == null || weatherData.currentCondition == null){
      print("API den değerler boş dönüyor !!!");
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return MainScreen(weatherData: weatherData,);
    }));
  }

  @override
  void initState(){
    super.initState();
    getWeatherData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.red,Colors.green]
          ),
        ),
        child: Center(
          child: SpinKitRipple(
            color: Colors.white,
            size: 300.0,
            duration: Duration(milliseconds: 1000),
          ),
        ),
      ),
    );
  }
}