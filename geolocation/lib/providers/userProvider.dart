import 'dart:convert';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User with ChangeNotifier{
  final String id;
  final String name;
  String address;
  String designation;
  double latitude;
  double longitude;
  final String email;
  final String phno;
  String imageUrl;
  DateTime lastseen;

  User(
      {
        this.lastseen,
        this.imageUrl,
      this.id,
      this.name,
      this.address,
      this.designation,
      this.email,
      this.latitude,
      this.longitude,
      this.phno});
}

class UserProvider with ChangeNotifier {
  List<User> _users = [
    // User(
    //     id: 'user1',
    //     address: 'Hyderabad',
    //     designation: 'Head4',
    //     email: 'abc@gmail.com',
    //     latitude: 17.3850,
    //     longitude: 78.4867,
    //     name: 'Meenan',
    //     phno: '12345678'),
    // User(
    //     id: 'user2',
    //     address: 'Hyderabad',
    //     designation: 'Head1',
    //     email: 'abc@gmail.com',
    //     latitude: 18.4386,
    //     longitude: 79.1288,
    //     name: 'Rakesh',
    //     phno: '12345678'),
    // User(
    //     id: 'user3',
    //     address: 'Hyderabad',
    //     designation: 'Head2',
    //     email: 'abc@gmail.com',
    //     latitude: 18.7895,
    //     longitude: 78.9120,
    //     name: 'Harsh',
    //     phno: '12345678'),
  ];
  Future<void> additem(userDetails) async {
    DateTime date=DateTime.now();
    try {
      const url="https://geolocation-89f89.firebaseio.com/user_details.json";
  final response=await http.post(url,body: json.encode(
    {
      'name':userDetails.displayName,
      'email':userDetails.email,
      'imageUrl':userDetails.photoUrl,
      'lastSeen':date.toIso8601String(),
      'phone':userDetails.phoneNumber,
    }
  ));
  print(json.decode(response.body));
      _users.add(
        User(
          name:userDetails.displayName,
      email:userDetails.email,
      imageUrl:userDetails.photoUrl,
      lastseen:date,
      phno:userDetails.phoneNumber,
        ),
      );
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchItem() async {
    var url = "https://geolocation-89f89.firebaseio.com/user_details.json";
    List<User> tempUserList = [];
    try {
      var response = await http.get(url);
      var retData = json.decode(response.body) as Map<String,dynamic>;
      print(retData);
      if(retData==null){
        return;
      }
      retData.forEach((prodId, prodData) {
        tempUserList.add(
          User(
            id: prodId,
            name: prodData['name'],
            email: prodData['email'],
            address: prodData['address'],
            designation: prodData['designation'],
            latitude: prodData['latitude'],
            longitude: prodData['longitude'],
            phno: prodData['phone'],
          )
        );
      });
      _users=tempUserList;
      print(_users);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
  List<User> get users {
    return [..._users];
  }
  User getUser(id){
    return _users.firstWhere((element) => element.id==id);
    }
}


