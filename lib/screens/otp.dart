import 'package:farmkal/screens/Register.dart';
import 'package:farmkal/utilities/InputField.dart';
import 'package:farmkal/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class Otp extends StatefulWidget {
  Otp({super.key, required this.verify, required this.phone, required this.from});

  String verify = "";
  String phone = "";
  String from = "";

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {

  _OtpState();

  String otp = "";
  String status = "";


  @override
  Widget build(BuildContext context) {
    String verify = widget.verify;
    String phone = widget.phone;

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

                    // Status
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      child: Text(status,
                        style: TextStyle( fontSize: 18,color: Colors.red,fontWeight: FontWeight.w500),
                      ),
                    ),

                    InputField(hint: 'Enter Otp',icon: Icons.password,
                        setData: (value){
                          otp = value;
                        }
                    ),

                    // Login Button
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

                          child: Text('Login',style: TextStyle(
                            color: Colors.white,
                            fontSize : 17,
                          ),),

                          onPressed: () async{
                            print({otp});

                            try {
                              PhoneAuthCredential credential = PhoneAuthProvider
                                  .credential(
                                  verificationId: verify, smsCode: otp);
                              print({"cred",credential, "verify",verify , "end"});



                              UserCredential userCred = await FirebaseAuth.instance.signInWithCredential(credential);
                              
                              bool isExist = false;
                              
                              if(userCred.additionalUserInfo!.isNewUser){
                                print(userCred);
                                isExist = true;
                              }
                              setState(() {
                                status = "valid user";
                              });

                              User? user = userCred.user;
                              String? uid = user?.uid;

                              if(uid == null){
                                setState(() {
                                  status="Wrong OTP";
                                });
                              }
                              else{

                                String route = "";

                                //ToDo Add a phone No here in DB
                                if(widget.from == "address"){
                                  sendData();
                                }

                                isExist ?
                                Navigator.pushReplacementNamed(context, '/home') :
                                widget.from == "address" ? Navigator.pushReplacementNamed(context, '/home') :
                                                           Navigator.pushReplacementNamed(context, '/address', arguments: {"phone" : phone} );
                              }

                            }
                            catch(e){
                              print(e);
                              setState(() {
                                status="Wrong OTP";
                              });
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

