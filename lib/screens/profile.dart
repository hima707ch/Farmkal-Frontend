import 'package:farmkal/screens/UserDetails.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'UserDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'Home.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {



  void saveData() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("done");
  }



@override
  void initState() {
    // TODO: implement initState
    super.initState();

    saveData();

    var a = json.decode('{"a":"data"}');
    print(a);

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.teal,
            body : SafeArea(
                child : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('images/him.jpeg')
                    ),
                    Text(
                        'Himanshu Chauhan',
                        style : TextStyle(
                            fontFamily: 'Pacifico',
                            fontSize: 25,
                            color: Colors.white
                        )
                    ),
                    Text(
                      'FARMKAL USER',
                      style: TextStyle(
                          color: Colors.teal[100],
                          fontFamily:'SourceSAns3',
                          fontSize: 16,
                          letterSpacing: 2.5,
                          fontWeight: FontWeight.bold

                      ),
                    ),
                    Card(
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                        child : Padding(
                          padding: EdgeInsets.symmetric(vertical: 3,horizontal: 5),
                          child: ListTile(
                            leading: Icon(Icons.phone),
                            title: Text("+91 707 3928 944",
                              style: TextStyle(
                                  color: Colors.teal
                              ),),
                          ),
                        )
                    ),
                    Container(
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        child : ListTile(

                            leading : Icon(Icons.email),
                            title : Text("chauhan1232000@gmail.com",
                              style: TextStyle(
                                  color: Colors.teal
                              ),)

                        )
                    ),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Register(uid : 'YZULl87FtAppocymfOzd');
                      }));
                    },
                      child: Text('Register',
                      style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Login();
                      }));
                    },
                      child: Text('Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                )
            )
        )
    );
  }
}