import 'package:farmkal/screens/otp.dart';
import 'package:farmkal/screens/home.dart';
import 'package:farmkal/screens/UserDetails.dart';
import 'package:flutter/material.dart';
import 'screens/profile.dart';
import 'package:farmkal/utilities/constants.dart';
import 'package:firebase_core/firebase_core.dart';

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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context)=>Home(),
        '/profile' : (context)=>Profile(),
        '/register' : (context)=>Register(uid : 'YZULl87FtAppocymfOzd'),
      },
    );
  }
}