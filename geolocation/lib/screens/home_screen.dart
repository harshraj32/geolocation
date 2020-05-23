import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/screens/login_screen.dart';
class HomeScreen extends StatefulWidget {
   static final String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Text("home 1"),
          
        ),
        RaisedButton(
           child: Text("Logout"),
          onPressed: () { 
            logout();
            // Navigator.pushNamed(context, LoginScreen.id);
             }
        
        ),
      ],
    );
  }
  static void logout() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.signOut();
  }
}