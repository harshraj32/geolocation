import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocation/models/user_data.dart';
import 'package:geolocation/screens/home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

import 'package:provider/provider.dart';


import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';
import '../providers/userProvider.dart';
// import 'ProfileScreen.dart';


class SignupScreen extends StatefulWidget {
    static final String id = 'signup_screen';
    

  @override
 _SignupScreenState createState() =>_SignupScreenState();

}

class _SignupScreenState  extends State<SignupScreen>  {

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();
  final _firestore =  Firestore.instance;

Future<FirebaseUser> _signIn(BuildContext context) async {
  
   Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text('Sign in'),
        ));
 
    final GoogleSignInAccount googleUser = await _googlSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);
    FirebaseUser userDetails = (await _firebaseAuth.signInWithCredential(credential)).user;
  if (authResult.additionalUserInfo.isNewUser) {
       _firestore.collection('/users').document(userDetails.uid).setData({
     'name': userDetails.displayName ,
     'email':userDetails.email,   
     'photoUrl':userDetails.photoUrl,
     'LastSeen': DateTime.now(),
   }
   );
  // Provider.of<UserProvider>(context).additem(userDetails); donnot remove this
  print("new user");

 Navigator.pushNamed(context, HomeScreen.id) ;
    
  }
  else {
    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);

List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(providerInfo);
     Provider.of<UserData>(context,listen: false).currentUserId = userDetails.uid;
 
 Navigator.of(context)
    .pushNamedAndRemoveUntil(HomeScreen.id, (Route<dynamic> route) => false);
    
  }
 
    



  
  //  await _firebaseAuth.signInWithCredential(credential);
  
 
 
//  if(userDetails!= null  ){
//    print("1");
//    if(_firestore.collection('/users').document(userDetails.uid) == null){
//      print("2");
//    _firestore.collection('/users').document(userDetails.uid).setData({
//      'name': userDetails.displayName ,
//      'email':userDetails.email,   
//      'photoUrl':userDetails.photoUrl,
     

//    }
//    );
 
//  }}


//  if(_firestore.collection('/users').document(userDetails.uid) == null)




    // Navigator.push(
    //   context,
    //   new MaterialPageRoute(
    //     builder: (context) => new ProfileScreen(detailsUser: details),
    //   ),
    // );
//     Navigator.push(context, new MaterialPageRoute(
//     builder: ( context) => new HomeScreen(),
// ));
    return userDetails;
  }


  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Stack(
        fit: StackFit.expand,
        children: <Widget>[
          //  Container(
          //    width: MediaQuery.of(context).size.width,
          //    height:  MediaQuery.of(context).size.height,
          //       child: Image.network(
          //          'https://images.unsplash.com/photo-1518050947974-4be8c7469f0c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'
          //          ,fit: BoxFit.fill,
          //          color: Color.fromRGBO(255, 255, 255, 0.6),
          //         colorBlendMode: BlendMode.modulate
          //       ),
          //     ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height:10.0),
             Container(
                  width: 250.0,
                    child: Align(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0)),
                    color: Color(0xffffffff),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                      Icon(FontAwesomeIcons.google,color: Color(0xffCE107C),),
                      SizedBox(width:10.0),
                      Text(
                      'Sign in with Google',
                      style: TextStyle(color: Colors.black,fontSize: 18.0),
                    ),
                    ],),
                    onPressed: () => _signIn(context)
                              .then((FirebaseUser user) => print(user))
                              .catchError((e) => print(e)),
                  ),
                )
                ),

                // Container(
                //   width: 250.0,
                //     child: Align(
                //   alignment: Alignment.center,
                //   child: RaisedButton(
                //     shape: RoundedRectangleBorder(
                //         borderRadius: new BorderRadius.circular(5.0)),
                //     color: Color(0xffffffff),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: <Widget>[
                //       Icon(FontAwesomeIcons.facebookF,color: Color(0xff4754de),),
                //       SizedBox(width:10.0),
                //       Text(
                //       'Sign in with Facebook',
                //       style: TextStyle(color: Colors.black,fontSize: 18.0),
                //     ),
                //     ],),
                //     onPressed: () {},
                //   ),
                // )
                // ),
                Container(
                  width: 250.0,
                    child: Align(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0)),
                    color: Color(0xffffffff),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                      Icon(FontAwesomeIcons.solidEnvelope,color: Color(0xff4caf50),),
                      SizedBox(width:10.0),
                      Text(
                      'Admin Login',
                      style: TextStyle(color: Colors.black,fontSize: 18.0),
                    ),
                    ],),
                    onPressed: () {
                      Navigator.pushNamed(context, '/email');
                    },
                  ),
                )
                ),
            ],
          ),
        ],
      ),),
    );
  }




}



class UserDetails {
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String longitude;
  final String latitude;
  final String userEmail;
  final String phoneNumber;
  final List<ProviderDetails> providerData;

  UserDetails(this.providerDetails,this.userName,this.longitude,this.latitude,this.phoneNumber, this.photoUrl,this.userEmail, this.providerData);
}


class ProviderDetails {
  ProviderDetails(this.providerDetails);
  final String providerDetails;
}


 
  // final GoogleSignIn googleSignIn = new GoogleSignIn();
// void sigInWithGoogle()
//   async{
//     FirebaseUser user;
//   final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
//   final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
//   user.mAuth.signInWithGoogle(idToken: googleSignInAuthentication.idToken, 
//   accessToken: googleSignInAuthentication.accessToken);

//   if(user!= null){
//     print("Signed into Google Account")
//   }

//   }
// }
  

//  body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Text("Stalker", style: TextStyle(
//               fontFamily: 'Tahu',
//               fontSize: 50.0),),
//               RaisedButton(
//                   child: Text('sign in with google'),
//                   onPressed: (){},
//               ),
//           ],
//         ),
//       ),
