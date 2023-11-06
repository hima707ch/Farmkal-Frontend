import 'package:geolocator/geolocator.dart';

class Location{
  double? latitude;
  double? longitude;
  bool isFail = false;

  Future<void> getLocation() async {
    try{

      LocationPermission permission = await Geolocator.checkPermission();

      if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
        permission = await Geolocator.requestPermission();

        if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
          isFail = true;
          return;
        }

      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low
      );
      this.longitude = position.longitude;
      this.latitude = position.latitude;

      print('success here');
    }
    catch(err){
      print(err);
      isFail = true;
    }
  }

}