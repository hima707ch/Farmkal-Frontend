import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:farmkal/screens/otp.dart';
import 'package:farmkal/utilities/InputField.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String phone = "";
  String verify = "";

  void sendData()async {
    var url = Uri.parse('http://localhost:4000/api/v1/register');
  }

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
                      child: Text('Log In',
                        style: TextStyle( fontSize: 30,color: Color(0xFF10C6CE),fontWeight: FontWeight.w700, fontFamily: 'Pacifico'),
                      ),
                    ),

                    InputField(hint: 'Enter Phone',icon: FontAwesomeIcons.phone,
                        setData: (value){
                          phone = value;
                        }
                    ),

                    // Login
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

                          child: Text('Next',style: TextStyle(
                            color: Colors.white,
                            fontSize : 17,
                          ),),

                          onPressed: () async{
                            print({phone});

                            try{
                               await FirebaseAuth.instance.verifyPhoneNumber(
                                phoneNumber: '+91$phone',
                                verificationCompleted: (PhoneAuthCredential credential) {},
                                verificationFailed: (FirebaseAuthException e) {},
                                codeSent: (String verificationId, int? resendToken) {
                                  print("code send");
                                  verify = verificationId;
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return Otp(verify:verify);
                                  }));
                                  },
                                codeAutoRetrievalTimeout: (String verificationId) {},
                              );
                            }
                            catch(e){
                              print(e);
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

                    // for register
                    Container(
                      alignment: Alignment.center,
                      child: Text('Create new account | Register'),
                    )

                  ]
              ),
            )
        )
    );
  }
}
