import 'dart:convert';

import 'package:farmkal/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:farmkal/utilities/InputField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmkal/utilities/constants.dart';
import 'package:farmkal/screens/GetAdderess.dart';
import 'package:shared_preferences/shared_preferences.dart';


GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly'
  ]
);

class Register extends StatefulWidget {
  Register({super.key,required this.uid});

  String uid;

  @override
  State<Register> createState() => _RegisterState(uid : uid);
}

class _RegisterState extends State<Register> {

  _RegisterState({required this.uid});

  String uid;
  String status = "";

  String name = "";
  String email = "";
  String bio = "";

  GoogleSignInAccount? _user;

  void saveData(user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('user', json.encode(user.toJson()));
  }


  void sendData()async {
    var url = Uri.parse('http://localhost:4000/api/v1/register');
    var response = await http.post(url,
    body : {
      'name' : "him"
    },
      headers : {
        'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    print(response);
  }
  void setUserData(String name,String email,String bio, String uid) async{
    CollectionReference users = await FirebaseFirestore.instance.collection('users');

    await users.doc(uid).set(
        {
          "name" : name,
          "email":email,
          "bio":bio
        }
    );
  }

  void showData()async{
    CollectionReference users = await FirebaseFirestore.instance.collection('users');

    DocumentSnapshot doc =await  users.doc("YZULl87FtAppocymfOzd").get();
    print(doc.data());

    // QuerySnapshot querySnapshot = await users.get();
    // querySnapshot.docs.forEach((doc) {print(doc.data());});


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getSaveData();

    handleUserChange();

  }

  void handleUserChange() async{
    _googleSignIn.onCurrentUserChanged.listen((event){
      setState(() {
        _user = event!;
      });
    });

    _googleSignIn.signInSilently();
  }

  Future<void> handleSignIn() async{
    try{
      await _googleSignIn.signIn();
    }
    catch(error){
      print("Sign In error : " + error.toString());
    }
}

Future<void> handleSignOut() async => _googleSignIn.disconnect();

  TextEditingController contName = TextEditingController(text : "");
  TextEditingController contEmail = TextEditingController(text : "");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Color(0xFFF0F0F0),

            body : Padding(
              padding: EdgeInsets.all(15),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [

                  // Sign up Text
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 35),
                    alignment: Alignment.center,
                  child: Text('Sign Up',
                  style: TextStyle( fontSize: 30,color: Color(0xFF10C6CE),fontWeight: FontWeight.w700, fontFamily: 'Pacifico'),
                  ),
                ),

                  // Status
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    child: Text(status,
                      style: TextStyle( fontSize: 18,color: Colors.red,fontWeight: FontWeight.w500),
                    ),
                  ),

                InputField(cont: contName, hint: 'Enter Name',icon: FontAwesomeIcons.user,setData: (value){ setState(() {
                  name = value;
                });  },),
                  InputField(cont:contEmail, hint: 'Enter Email',icon: Icons.email,setData: (value){ setState(() {
                    email = value;
                  });  },),

                  InputField(hint: 'Enter Bio',icon: Icons.description,setData: (value){ setState(() {
                    bio = value;
                  }); },),



            // Or Text
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 6),
              child: Text('Or',style :TextStyle(
                color: Color(0xFF10C6CE),
                fontSize : 20,
              ),),
            ),

                  // Sign Up with Text
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 15),
                    child: Text('Sign up with ',style :TextStyle(
                      color: Color(0x995C5C5C),
                      fontSize : 20,
                    ),),
                  ),

            // Google fb Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF8B8B8B),
                            offset: Offset(0,0.5),
                            blurRadius: 6,
                            spreadRadius: 0
                        )
                      ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextButton(child: Icon(FontAwesomeIcons.google,color: Colors.red,),
                  onPressed: () async{
                    handleSignIn();
                    print(_user);
                    contName.text = _user!.displayName!;
                    contEmail.text = _user!.email!;

                    setState(() {
                      name = contName.text;
                      email = contEmail.text;
                    });

                     saveData({
                       "name" : _user?.displayName,
                       "email" : _user?.email,
                       "photo" : _user?.photoUrl,
                     });

                  },
                  ),
                ),
                SizedBox(width: 25,),
                Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF8B8B8B),
                            offset: Offset(0,0.5),
                            blurRadius: 6,
                            spreadRadius: 0
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Icon(FontAwesomeIcons.facebook,color: Colors.blue,),
                ),
                SizedBox(width: 25,),
                TextButton(onPressed: (){
                  handleSignOut();
                }, child: Text('Change user'))
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
                        offset: Offset(0,0.5),
                        blurRadius: 6,
                        spreadRadius: 0
                    )
                  ],
                  borderRadius: BorderRadius.circular(40)
              ),

              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: TextButton(

                child: Text('Sign Up',style: TextStyle(
                    color: Colors.white,
                        fontSize : 17,
                ),),
                
                onPressed: (){
                  print({name,email,bio});
                  setUserData(name,email,bio,uid);
                  if(name == ""){
                    setState(() {
                      status = "Name required";
                    });
                  }
                  else{
                    setState(() {
                      status="";
                    });
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                      return Adderess();
                    }));
                  }
                },
                style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                
              ),)
            ),

                  // Skip button
            Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: Color(0xFF10C6CE),

                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFFA4DDE0),
                                offset: Offset(0,0.5),
                                blurRadius: 6,
                                spreadRadius: 0
                            )
                          ],
                          borderRadius: BorderRadius.circular(40)
                      ),

                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      child: TextButton(

                        child: Text('Skip',style: TextStyle(
                          color: Colors.white,
                          fontSize : 17,
                        ),),

                        onPressed: (){
                          showData();

                          if(name == ""){
                            setState(() {
                              status = "Name required";
                            });
                          }
                          else{
                            setState(() {
                              status="";
                            });
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                              return Home();
                            }));
                          }

                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,

                        ),)
                  ),

                  // hr line
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: Divider(
                      color: Color(0xFF7B7B7B),

                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text('Already have a account | Sign In'),
                  )

              ]
              ),
            )
        )
    );
  }

  void getSaveData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userStr = pref.getString('user');
    print("user String "+userStr.toString());
    var user;
/*
    if (userStr != null)
      user = json.decode(userStr.toString());
    if (user?.email != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Home();
      }));
    }

 */
  }

    }

