import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:farmkal/utilities/InputField.dart';
import 'Home.dart';
import 'package:farmkal/utilities/constants.dart';

class Adderess extends StatefulWidget {
  const Adderess({super.key});

  @override
  State<Adderess> createState() => _AdderessState();
}

class _AdderessState extends State<Adderess> {

  String status = "";
  String? state;
  String? city;
  var location;

  Future<void> getLoc() async{

    location = await getLocation();
    print(location);
    setState(() {
      if(location?['success'] == false){
        status = "Permission denied";
      }

    });
    cont1.text = location['state'];
    cont2.text = location['city'];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.microtask(getLoc);

  }

  TextEditingController cont1 = TextEditingController(text : "");
  TextEditingController cont2 = TextEditingController(text : "");


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

                    InputField(cont : cont1,hint: 'Enter State',icon: FontAwesomeIcons.user,setData: (value){ setState(() {
                      state = value;
                    });  },),
                    InputField(cont : cont2,hint: 'Enter City',icon: Icons.email,setData: (value){ setState(() {
                      city = value;
                    });  },),

                    // Sign Up with Text
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Text('Sign up with ',style :TextStyle(
                        color: Color(0x995C5C5C),
                        fontSize : 20,
                      ),),
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

                          child: Text('Next',style: TextStyle(
                            color: Colors.white,
                            fontSize : 17,
                          ),),

                          onPressed: (){
                            print({state,city});

                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                              return Home();
                            }));

                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,

                          ),)
                    ),

                    // get Location
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

                          child: Text('Get location',style: TextStyle(
                            color: Colors.white,
                            fontSize : 17,
                          ),),

                          onPressed: () async{
                            await getLoc();
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
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                              return Home();
                            }));
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
}

