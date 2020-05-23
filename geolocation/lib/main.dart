import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocation/models/user_data.dart';
import 'package:geolocation/screens/admin_screen.dart';
import 'package:geolocation/screens/email_screen.dart';
import 'package:geolocation/screens/home_screen.dart';
import 'package:geolocation/screens/login_screen.dart';
import 'package:geolocation/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import './providers/userProvider.dart';
import './screens/userDetailsScreen.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());}

class MyApp extends StatelessWidget {
  
  
   Widget _getScreenId() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          Provider.of<UserData>(context).currentUserId = snapshot.data.uid;
          if(snapshot.data.uid == 'PxHRiLMbNwclDBS1grIZjaslG3C3'){
          return AdminScreen();}
          else{
          return HomeScreen();
          }
        } else {
          return SignupScreen();
        }
      },
    );
   }
 

  @override
  Widget build(BuildContext context) {
  
  return  MultiProvider(providers: 
  [
    ChangeNotifierProvider(
      create: (context) => UserData(),),
    ChangeNotifierProvider(
      create:(ctx)=>UserProvider(),),
  ],
   child: MaterialApp(
        title: 'Geolocation',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryIconTheme: Theme.of(context).primaryIconTheme.copyWith(
                color: Colors.white,
              ),
        ),
        home: _getScreenId(),
        routes: {
          UserDetailsScreen.routeName:(ctx)=>UserDetailsScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          '/email':(context) => EmailScreen(),
          AdminScreen.routeName:(context) => AdminScreen(),
        },
    ),
  
  );
  
     
  }
}
