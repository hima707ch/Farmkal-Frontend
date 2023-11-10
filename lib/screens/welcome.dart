import 'package:farmkal/services/googleAuth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //handleUserChange();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF0B0019),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Welcome to Farmkal',
            style: TextStyle(fontSize: 26,fontWeight: FontWeight.w500,color: Color(
                0xFFC3C7D6)),
            ),
            Container(
                width: 200,
                height: 200,
                child: Image(image: AssetImage('images/Farmkal.gif'))),

            SizedBox(height : 15),

            AuthButton("Sign Up","/register", context,false),
            AuthButton("Log In","/login", context, false),
            AuthButton("Sign in with Google","/home", context, true)
          ],
        ),
      ),
    );
  }
}

Widget AuthButton (String text, String page, BuildContext context,icon){
 return Container(
   width: double.infinity,
   margin: EdgeInsets.symmetric(horizontal: 35),
   child: ElevatedButton(onPressed: (){

      !icon ? Navigator.pushNamed(context, page) : null;
      icon ? signInWithGoogle(context) : null;


    }, child: Row(
     mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon ? Image(image: AssetImage('images/Logo_google.png'),width: 30,) : Container(),
        icon ? SizedBox(width: 5,) : Container(),
        Text(text, style: TextStyle(color: Color(0xFF0B0019),fontSize:14,fontWeight: FontWeight.w600),),
      ],
    ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.all(18)),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if(states.contains(MaterialState.pressed)){
            return Color(0x55C3C7D6);
          }
          return Color(0xFFFFFFFF);
        }),

      ),),
 );
}

