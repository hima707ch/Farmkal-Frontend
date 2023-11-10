import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';


class UserProvider extends ChangeNotifier{
  Map<String,dynamic> user = {
    "id" : "",
    "name" : "",
    "email" : "",
    "password" : "",
    "phone" : "",
    "photo" : "",
    "state" : "",
    "city" : "",
    "latitude" : "",
    "longitude" : "",
    "bio" : "",
    "token" : "",
    "signInWith" : "",
  };

  updateUser(newValue){
    user.addAll(newValue);
    notifyListeners();
  }
}