import 'package:farmkal/Providers/user.dart';
import 'package:farmkal/screens/Register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'GetPhone.dart';
import 'package:farmkal/services/googleAuth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';



class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String name = "";
  String email = "";
  String imgUrl = "";

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetailsFromLocal();

  }

  void getDetailsFromLocal() async{

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userStr = pref.getString('user');

    if(userStr!=null && userStr.length > 0) {
      var user = json.decode(userStr);


      //var user = context.watch<UserProvider>().user;

      setState(() {
        name = user?['name'];
        email = user?['email'];
        imgUrl = user?['photo'];
      });
    }

  }

  Future<void> uploadImageToCloudinary(File imageFile) async{
    final  cloud_name = "dqblxpdgd";
    final api_key = "952545925947858";
    final api_secret = "73NQqnDXt7MMnHDQ7UOanDQfTGQ";

    final apiUrl = 'https://api.cloudinary.com/v1_1/$cloud_name/image/upload';

    print({imageFile, imageFile.path});
    // Create a multipart request
    final request = http.MultipartRequest('POST', Uri.parse(apiUrl))
      ..fields['upload_preset'] = 'mwm8l5es'; // Replace with your Cloudinary upload preset
    request.files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final decodedResponse = json.decode(responseBody);

        // Extract the Cloudinary URL from the response
        final cloudinaryUrl = decodedResponse['secure_url'];

        print('Image uploaded to Cloudinary: $cloudinaryUrl');
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
        print('Response body: ${await response.stream.bytesToString()}');
      }
    } catch (error) {
      print('Error uploading image: $error');
    }

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
                        backgroundImage: NetworkImage(imgUrl),
                    ),
                    
                    Text(
                        name,
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
                            title : Text(email,
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
                        return Phone();
                      }));
                    },
                      child: Text('Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(onPressed: () async{
                      await handleSignOut();
                      Navigator.pushReplacementNamed(context, '/welcome');
                    },
                      child: Text('Log Out',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(onPressed: () async{
                      FilePickerResult? result = await FilePicker.platform.pickFiles();

                      if (result != null) {
                        File file = File(result.files.single.path!);
                        uploadImageToCloudinary(file);
                      } else {
                        // User canceled the picker
                        print('pick fail or cancel');
                      }

                    },
                      child: Text('Upload Image',
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