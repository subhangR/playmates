import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:playmates_app/screens/user_management/user_profile_screen.dart';

import '../../auth_service.dart';
import '../../models/user_profile.dart' hide UserProfile;
import '../../models/user_profile.dart';

class UserRegistrationScreen extends StatefulWidget {
  final User user;

  UserRegistrationScreen({required this.user});

  @override
  _UserRegistrationScreenState createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Registration")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: "First Name"),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: "Last Name"),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: "Email Address"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final userProfile = UserProfile(
                  uid: widget.user.uid,
                  phoneNumber: widget.user.phoneNumber!,
                  displayName:
                  "${_firstNameController.text} ${_lastNameController.text}",
                  email: _emailController.text,
                );

                await _authService.saveUserProfile(userProfile);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfileScreen(user: widget.user),
                  ),
                );
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
