import 'package:farmkal/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var getLocation = () async{
  try{
    Location location = Location();
    await location.getLocation();
    print(location);

    if(location.isFail = false){

      http.Response res = await http.get(Uri.parse('https://geocode.xyz/${location.latitude},${location.longitude}?geoit=json&auth=504208361678632309527x107657 '));
      var respJson = jsonDecode(res.body);

      var address = {
        'success' : true,
        'state' : respJson['state'],
        'city' : respJson['city'],
        'country' : respJson['country'],
        'postal' : respJson['postal']
      };

      print({address['state'],address['city'],address['country'],address['postal']});
      return address;
    }
    else{
      var res = {
        'success' : false
      };
      return res;
    }

  }
  catch(e){
    print(e);
  }
};