import 'package:location/location.dart';


class LocationHelper{
  late double latitude;
  late double longitude;

  Future<void> getCurrentLocation() async{
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionsGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if(!_serviceEnabled){
      _serviceEnabled = await location.requestService();
      if(!_serviceEnabled){
        return;
      }
    }
    _permissionsGranted = await location.hasPermission();
    if(_permissionsGranted == PermissionStatus.denied) {
      _permissionsGranted = await location.requestPermission();

      if(_permissionsGranted!=PermissionStatus.granted){
        return;
      }
    }
    _locationData = await location.getLocation();
    latitude = _locationData.latitude!;
    longitude = _locationData.longitude!;

  }
}
