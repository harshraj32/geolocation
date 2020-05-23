import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String profileImageUrl;
  final String email;
  final String  latitude;
  final String longitude;
  final String phoneNumber;
  final String address;

  User({
    this.id,
    this.name,
    this.profileImageUrl,
    this.email,
    this.latitude,
    this.address,
    this.longitude,
    this.phoneNumber,

  });

  factory User.fromDoc(DocumentSnapshot doc) {
    return User(
      id: doc.documentID,
      name: doc['name'],
      profileImageUrl: doc['profileImageUrl'] ,
      email: doc['email'],
     latitude: doc['latitude'],
     longitude: doc['longitude'],
     address: doc['address'] ?? '',
      phoneNumber: doc['phoneNumber'],
    );
  }
}