import 'package:flutter/material.dart';

import '../models/user_profile.dart';

class UserSearchItem extends StatefulWidget {
  final UserProfile user;
  final bool isFriend;

  UserSearchItem({required this.user, required this.isFriend});

  @override
  _UserSearchItemState createState() => _UserSearchItemState();
}

class _UserSearchItemState extends State<UserSearchItem> {
  bool? _userExists;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.user.displayName ?? widget.user.phoneNumber),
      leading: CircleAvatar(
        backgroundImage:
            AssetImage('assets/images/default_avatar.png'),
      ),
      onTap: () async {
        if (!widget.isFriend) {
          if (_userExists == null) {
            _userExists = await _checkUserExists(widget.user);
            setState(() {});
          }
          if (_userExists == true) {
            // Handle invite action
          } else {
            // Share link to WhatsApp
          }
        }
      },
      trailing: widget.isFriend
          ? ElevatedButton(
        onPressed: () {
          // Handle invite action
        },
        child: Text('Invite'),
        style: ElevatedButton.styleFrom(primary: Colors.green),
      )
          : _userExists == null
          ? null
          : _userExists == true
          ? ElevatedButton(
        onPressed: () {
          // Handle invite action
        },
        child: Text('Invite'),
        style: ElevatedButton.styleFrom(primary: Colors.green),
      )
          : TextButton(
        onPressed: () {
          // Share link to WhatsApp
        },
        child: Text('Share Link'),
      ),
    );
  }

  Future<bool> _checkUserExists(UserProfile user) async {
    // Replace with your actual Firestore check implementation
    bool userExists = false;
    // Check if user exists in Firestore

    return userExists;
  }
}