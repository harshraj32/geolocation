import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class AdminScreen extends StatefulWidget {
  static final String id = 'admin_screen';
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Text("admin screen"),
          
        ),
        RaisedButton(
          child: Text("Logout"),
          onPressed: () { 
            logout();
         
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
