import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly'
    ]
);

Future<void> handleSignIn() async{
    try{
      await googleSignIn.signIn();
    }
    catch(error){
      print("Sign In error : " + error.toString());
    }
  }

Future<void> handleSignOut() async {
  googleSignIn.disconnect();

  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('user', "");

}

