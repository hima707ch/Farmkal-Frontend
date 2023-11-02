import 'package:farmkal/screens/home.dart';
import 'package:farmkal/screens/register.dart';
import 'package:flutter/material.dart';
import 'screens/profile.dart';
import 'package:farmkal/utilities/constants.dart';

void main() => runApp(MyApp());

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
        '/register' : (context)=>Register()
      },
    );
  }
}