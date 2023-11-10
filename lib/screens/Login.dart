import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:farmkal/services/googleAuth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:farmkal/utilities/InputField.dart';
import 'package:farmkal/utilities/constants.dart';


class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  _LoginState();

  String? uid;
  String status = "";
  String email = "";
  String password = "";
  String phone = "";
  GoogleSignInAccount? _user;
  TextEditingController contName = TextEditingController(text: "");
  TextEditingController contEmail = TextEditingController(text: "");


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Color(0xFFF0F0F0),
            body: Padding(
              padding: EdgeInsets.all(15),
              child: ListView(scrollDirection: Axis.vertical, children: [

                // Log In
                Container(
                  margin: EdgeInsets.symmetric(vertical: 35),
                  alignment: Alignment.center,
                  child: Text(
                    'Log In',
                    style: TextStyle(
                        fontSize: 30,
                        color: Color(0xFF10C6CE),
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Pacifico'),
                  ),
                ),

                // Status
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  child: Text(
                    status,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.w500),
                  ),
                ),


                InputField(
                  cont: contEmail,
                  hint: 'Enter Email',
                  icon: Icons.email,
                  setData: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                InputField(
                  hint: 'Enter password',
                  icon: Icons.password,
                  setData: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),

                Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: Color(0xFF10C6CE),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFFA4DDE0),
                              offset: Offset(0, 0.5),
                              blurRadius: 6,
                              spreadRadius: 0)
                        ],
                        borderRadius: BorderRadius.circular(40)),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: TextButton(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                      onPressed: () {
                        print({ email, password,phone});

                        var data = {
                          "email" : email,
                          "password" : password,
                          "phone" : phone,
                          "uid" : uid
                        };

                        saveDataInLocal(data, 'userReg');

                        // setUserDataInFirebase(name, email, password, phone, uid);


                          setState(() {
                            status = "";
                          });
                          Navigator.pushReplacementNamed(context, '/address', arguments: {"register" : "yes"});

                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                    )),

                // Or Text
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    'Or',
                    style: TextStyle(
                      color: Color(0xFF10C6CE),
                      fontSize: 20,
                    ),
                  ),
                ),

                // Log In with Text
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Log In with ',
                    style: TextStyle(
                      color: Color(0x995C5C5C),
                      fontSize: 20,
                    ),
                  ),
                ),

                // Phone Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(

                      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFF8B8B8B),
                                offset: Offset(0, 0.5),
                                blurRadius: 6,
                                spreadRadius: 0)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        child: Row(
                          children: [
                            Text("Continue with mobile   "),
                            Icon(
                              FontAwesomeIcons.mobileScreen,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        onPressed: () async {
                          Navigator.pushReplacementNamed(context, '/phone');
                        },
                      ),
                    ),
                  ],
                ),

                // Log in with Google
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFF8B8B8B),
                                offset: Offset(0, 0.5),
                                blurRadius: 6,
                                spreadRadius: 0)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                        child: Row(
                          children: [
                            Text(" Log  In  with  Google  "),
                            Image(image: AssetImage('images/Logo_google.png'),width: 30,),
                          ],
                        ),
                        onPressed: () async {
                          signInWithGoogle(context);
                        },
                      ),
                    ),
                  ],
                ),

                // Sign Up Button


                // Skip button
                /*           Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                        color: Color(0xFF10C6CE),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFFA4DDE0),
                              offset: Offset(0, 0.5),
                              blurRadius: 6,
                              spreadRadius: 0)
                        ],
                        borderRadius: BorderRadius.circular(40)),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: TextButton(
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                      onPressed: () {
                        showData();

                        if (name == "") {
                          setState(() {
                            status = "Name required";
                          });
                        } else {
                          setState(() {
                            status = "";
                          });
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return Home();
                          }));
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                    )),
*/
                // hr line
                Hr(),
                Container(
                  alignment: Alignment.center,
                  child: Text('Already have a account | Sign In'),
                )
              ]),
            )));
  }
}
