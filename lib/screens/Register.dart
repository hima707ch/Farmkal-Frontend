import 'dart:convert';

import 'package:farmkal/Providers/user.dart';
import 'package:farmkal/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:farmkal/services/googleAuth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:http/http.dart' as http;
import 'package:farmkal/utilities/InputField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmkal/utilities/constants.dart';
import 'package:farmkal/screens/GetAdderess.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  Register({super.key, required this.uid});

  String uid;

  @override
  State<Register> createState() => _RegisterState(uid: uid);
}

class _RegisterState extends State<Register> {
  _RegisterState({required this.uid});

  String uid;
  String status = "";
  String name = "";
  String email = "";
  String password = "";
  String phone = "";
  GoogleSignInAccount? _user;
  TextEditingController contName = TextEditingController(text: "");
  TextEditingController contEmail = TextEditingController(text: "");

  // Local storage




  // get api
  void showData() async {
    CollectionReference users =
        await FirebaseFirestore.instance.collection('users');

    DocumentSnapshot doc = await users.doc("YZULl87FtAppocymfOzd").get();
    print(doc.data());

    // QuerySnapshot querySnapshot = await users.get();
    // querySnapshot.docs.forEach((doc) {print(doc.data());});
  }

  // google auth
  void handleUserChange() async {
    googleSignIn.onCurrentUserChanged.listen((event) {
      setState(() {
        _user = event!;
      });
    });

    googleSignIn.signInSilently();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Color(0xFFF0F0F0),
            body: Padding(
              padding: EdgeInsets.all(15),
              child: ListView(scrollDirection: Axis.vertical, children: [
                // Sign up Text
                Container(
                  margin: EdgeInsets.symmetric(vertical: 35),
                  alignment: Alignment.center,
                  child: Text(
                    'Sign Up',
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
                  cont: contName,
                  hint: 'Enter Name',
                  icon: FontAwesomeIcons.user,
                  setData: (value) {
                    setState(() {
                      name = value;
                    });
                  },
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
                InputField(
                  hint: 'Phone  # Optional',
                  icon: Icons.phone,
                  setData: (value) {
                    setState(() {
                      phone = value;
                    });
                  },
                ),

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

                // Sign Up with Text
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Sign up with ',
                    style: TextStyle(
                      color: Color(0x995C5C5C),
                      fontSize: 20,
                    ),
                  ),
                ),

                // Google Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(7),
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
                            Text("Contnue with mobile "),
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

                    SizedBox(
                      width: 25,
                    ),
                    TextButton(
                        onPressed: () {
                          handleSignOut();
                        },
                        child: Text('Change user'))
                  ],
                ),

                // Sign Up Button
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
                        print({name, email, password,phone});

                        var data = {
                          "name" : name,
                          "email" : email,
                          "password" : password,
                          "phone" : phone,
                          "uid" : uid
                        };

                        context.read<UserProvider>().updateUser(data);
                        //saveDataInLocal(data, 'userReg');

                        // setUserDataInFirebase(name, email, password, phone, uid);

                        if (name == "") {
                          setState(() {
                            status = "Name required";
                          });
                        } else {
                          setState(() {
                            status = "";
                          });
                          Navigator.pushReplacementNamed(context, '/address', arguments: {"register" : "yes"});
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                    )),

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
