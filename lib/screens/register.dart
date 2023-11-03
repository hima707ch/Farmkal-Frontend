import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String? name;
  String? email;
  String? password;
  String? phone;
  String? bio;

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

                InputField(hint: 'Enter Name',icon: FontAwesomeIcons.user,setData: (value){ setState(() {
                  name = value;
                });  },),
                  InputField(hint: 'Enter Email',icon: Icons.email,setData: (value){ setState(() {
                    email = value;
                  });  },),
                  InputField(hint: 'Enter Password',icon: Icons.password,setData: (value){ setState(() {
                    password = value;
                  });  },),
                  InputField(hint: 'Enter Phone',icon: FontAwesomeIcons.phone,setData: (value){ setState(() {
                    phone = value;
                  });  },),
                  InputField(hint: 'Enter description',icon: Icons.description,setData: (value){ setState(() {
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
                  child: Icon(FontAwesomeIcons.google,color: Colors.red,),
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
                  print({name,email,password,phone,bio});
                  sendData();
                },
                style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                
              ),)
            ),

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

class InputField extends StatelessWidget {
  InputField({
    this.hint,
    this.icon,
    super.key,
    required this.setData,
  });

  IconData? icon;
  String? hint;
  String? text;
  Function setData;

  String? getText(){
    return text;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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

      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: TextField(
        onChanged: (value){
          setData(value);
        },
        decoration: InputDecoration(
            prefixIcon: Icon(icon,size: 15,),
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(width: 0,color: Colors.transparent)
            ),
            filled: true,
          fillColor: Colors.white,

        ),
      ),
    );
  }
}
