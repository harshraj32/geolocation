import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/userProvider.dart';
import '../widgets/admin_listTileItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AdminScreenLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (ctx)=>UserProvider(),child: AdminScreen(),);
  }
}

class AdminScreen extends StatefulWidget {
  static const routeName='/adminscreen';
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  var _isinit=true;
  var _isLoading=false;
  void didChangeDependencies() {
    if(_isinit){
    setState(() {
        _isLoading=true;
      });
      Provider.of<UserProvider>(context).fetchItem().then((_){
        setState(() {
          _isLoading=false;
        });
      });
    }
    _isinit=false;
    super.didChangeDependencies();
  }
 
  Widget build(BuildContext context) {
    var usersList = Provider.of<UserProvider>(context);
    void logout() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.signOut();
    print('logout');
  }
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        actions: <Widget>[
          FlatButton(onPressed: (){
            logout();
          }, child: Text('LOGOUT',style: TextStyle(color: Colors.white),))
        ],
      ),
      body:_isLoading? Center(child: CircularProgressIndicator()):Container(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return UserListItem(
                userId: usersList.users[index].id,
                userName: usersList.users[index].name,
                latitude: usersList.users[index].latitude,
                longitude: usersList.users[index].longitude,
                designation: usersList.users[index].designation,
              );
            },
            itemCount: usersList.users.length,
          ),
        ),
     
      floatingActionButton: 
          FloatingActionButton.extended(
            onPressed: () {},
            icon: Icon(Icons.person_pin_circle,color: Colors.white,),
            label: Text('Locate'), 
          ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
   
  }
  }
  

//  RaisedButton(
//           child: Text("Logout"),
//           onPressed: () { 
//             logout();
         
//              }
        
//         ),