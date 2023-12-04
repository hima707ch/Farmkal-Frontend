import 'package:farmkal/Providers/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


GoogleSignIn googleSignIn = GoogleSignIn(
  clientId: "303405343079-0rqa9i4a5ef84lkh19hggkufonjna132.apps.googleusercontent.com",
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly'
    ]
);

Future<void> saveDataInLocal(user,str) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString(str, json.encode(user));

  print("data saved in local" + pref.getString(str).toString());

}

void handleUserChange(context) async {

  googleSignIn.onCurrentUserChanged.listen((event) async{

    GoogleSignInAccount? user = event;
/*
    context.read<UserProvider>().updateUser({
      "name": user?.displayName,
      "email": user?.email,
      "photo": user?.photoUrl,
    });
*/

    await saveDataInLocal(
    {
      "name": user?.displayName,
      "email": user?.email,
      "photo": user?.photoUrl,
    },
      'user'
    );

  });

  googleSignIn.signInSilently();
}

Future<String?> handleSignIn() async{
    try{
      GoogleSignInAccount? user =  await googleSignIn.signIn();

      print({"handle signin user", user});

      return user?.email ?? null;



      print("sign In success" + user.toString());



    }
    catch(error){
      print("Sign In error : " + error.toString());
    }
  }

void signInWithGoogle(context) async{

  handleUserChange(context);

  String? email = await handleSignIn();

  print('email' + email.toString());

  if (email != null && email.length > 0) {
    print('email verified');

    // check if user come first time

    var data = {
      "email" : email
    };
    var res = await http.post(Uri.parse("https://v9tzvk-4000.csb.app/api/v1/isuser"),body : jsonEncode(data),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );
    var isExist = json.decode(res.body)['exist'];

    print(isExist);
    isExist ? Navigator.pushNamed(context, '/home') : Navigator.pushNamed(context, '/address', arguments: { "google" : email });
  }
}

Future<void> handleSignOut() async {
  googleSignIn.disconnect();

  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('user', "");
  pref.setString('userReg', "");

}

