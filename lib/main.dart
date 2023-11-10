import 'package:farmkal/Providers/user.dart';
import 'package:farmkal/screens/GetPhone.dart';
import 'package:farmkal/screens/Login.dart';
import 'package:farmkal/screens/home.dart';
import 'package:farmkal/screens/Register.dart';
import 'package:farmkal/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:farmkal/screens/GetAdderess.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDA56bfhPVztMtpEC8juyQrj3zbFzjoENk",
        appId: "1:303405343079:android:79e32196491302cf5f0fc2",
        messagingSenderId: "303405343079",
        projectId: "farmkal",
      )
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=>UserProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      routes: {
        '/home'     : (ctx) => Home(),
        '/welcome'  : (context)=>Welcome(),
        '/profile'  : (context)=>Profile(),
        '/register' : (context)=>Register(uid : 'YZULl87FtAppocymfOzd'),
        '/address'  : (ctx) => Adderess(),
        '/phone'    : (ctx) => Phone(),
        '/login'    :  (ctx) => Login(),
        '/test'     : (ctx) => Home()
      },
      initialRoute: '/test',


    );
  }
}