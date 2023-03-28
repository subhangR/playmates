import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:playmates_app/screens/home_screen.dart';
import 'package:playmates_app/screens/user_management/user_profile_screen.dart';
import 'package:playmates_app/screens/user_management/user_registration_screen.dart';
import '../../models/user_profile.dart';
import '../../auth_service.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;

  OtpScreen({required this.verificationId});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _smsCodeController = TextEditingController();

  @override
  void dispose() {
    _smsCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("OTP")),
    body: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    TextFormField(
    controller: _smsCodeController,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(labelText: "Verification code"),
    ),
    SizedBox(height: 16),
    ElevatedButton(
    onPressed: () async {
    final phoneAuthCredential = PhoneAuthProvider.credential(
    verificationId: widget.verificationId,
    smsCode: _smsCodeController.text,
    );
    final userCredential = await _authService
        .signInWithPhoneAuthCredential(phoneAuthCredential);

    if (userCredential != null) {
    print("Phone sign-in successful!");

    // Check if the user exists in Firestore
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .get();

    if (userDoc.exists) {
    // User exists, navigate to UserProfileScreen
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => MyInputScreen(
    ),
    ),
    );
    } else {
      // User does not exist, navigate to UserRegistrationScreen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserRegistrationScreen(
            user: userCredential.user!,
          ),
        ),
      );
    }
    } else {
      print("Phone sign-in failed!");
    }
    },
      child: Text("Submit OTP"),
    ),
    ],
    ),
    ),
    );
  }
}
