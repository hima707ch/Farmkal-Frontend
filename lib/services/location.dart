import 'package:geolocator/geolocator.dart';

class Location{
  double? latitude;
  double? longitude;
  bool isFail = false;

  Future<void> getLocation() async {
    try{
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low
      );

      this.longitude = position.longitude;
      this.latitude = position.latitude;
    }
    catch(err){
      print(err);
      isFail = true;
    }
  }

}