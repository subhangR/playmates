import 'package:flutter/material.dart';

class UserProfile {
  final String uid;
  final String phoneNumber;
  final String? displayName;
  final String? email;
  final String? photoUrl;
  final IconData? icon;

  UserProfile({
    required this.uid,
    required this.phoneNumber,
    this.displayName,
    this.email,
    this.photoUrl,
    this.icon
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phoneNumber': phoneNumber,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> data) {
    return UserProfile(
      uid: data['uid'],
      phoneNumber: data['phoneNumber'],
      displayName: data['displayName'],
      email: data['email'],
      photoUrl: data['photoUrl'],
    );
  }
}
