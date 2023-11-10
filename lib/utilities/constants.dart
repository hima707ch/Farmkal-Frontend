import 'package:farmkal/Providers/user.dart';
import 'package:farmkal/services/location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';


// Get Location
var getLocation = () async{
  try{
    Location location = Location();
    await location.getLocation();
    print(location);

    if(location.isFail == false){

      http.Response res = await http.get(Uri.parse('https://geocode.xyz/${location.latitude},${location.longitude}?geoit=json&auth=504208361678632309527x107657 '));
      var respJson = jsonDecode(res.body);

      var address = {
        'success' : true,
        'state' : respJson['state'],
        'city' : respJson['city'],
        'country' : respJson['country'],
        'postal' : respJson['postal'],
        'latitude' : location.latitude,
        'longitude' : location.longitude
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

// Post API
void sendData() async {

  SharedPreferences pref = await SharedPreferences.getInstance();
  var userStr = pref.getString('user');
  var locStr = pref.getString('location');
  var userRegStr = pref.getString('userReg');

  var user;
  var location;
  var userReg;

  if (userStr != null && userStr != ""){
    user = json.decode(userStr);
  }
  if (locStr != null && locStr != ""){
    location = json.decode(locStr);
  }
  if (userRegStr != null && userRegStr != ""){
    userReg = json.decode(userRegStr);
  }

  print("from constant sendData");
  print(user);
  print(location);

  String uid = userReg['uid'];

   var data = {
     "name" : user['name'] ?? userReg['name'],
     "email" : user['email'] ?? userReg['email'],
     "password" : user['password'] ?? userReg['password'],
     "phone" : userReg['phone'],

     "city" : location['city'],
     "state" : location['state'],
     "latitude" : location['latitude'],
     "longitude" : location['longitude'],
   };

  if(uid == null || uid.length ==0) {
    var url = Uri.parse('https://v9tzvk-4000.csb.app/api/v1/register');
    var response = await http.post(url, body: jsonEncode(data), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    });
    print(response);
  }
  else{
    setUserDataInFirebase(data, uid);
  }
 /*

var data = context.watch<UserProvider>().user;
*/

  UserCredential cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: data['email'],
      password: data['password']
  );
   uid = cred.user?.uid ?? "";

setUserDataInFirebase(data, uid);

}

// Hr Line
class Hr extends StatelessWidget {
  const Hr({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        child: Divider(
          color: color ?? Color(0xFF7B7B7B),

        ),
      );
  }
}

// Save in FireBase
void setUserDataInFirebase(data,uid) async {
  CollectionReference users =
  await FirebaseFirestore.instance.collection('users');

  await users.doc(uid).set(data);
}
