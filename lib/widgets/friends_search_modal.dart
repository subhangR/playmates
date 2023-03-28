import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:playmates_app/widgets/user_search_item.dart';

import '../models/user_profile.dart';


class UserSearchModal extends StatefulWidget {
  final List<UserProfile> friendUsers;

  UserSearchModal({required this.friendUsers});

  @override
  _UserSearchModalState createState() => _UserSearchModalState();
}

class _UserSearchModalState extends State<UserSearchModal> {
  TextEditingController _searchController = TextEditingController();
  List<UserProfile> _displayedUsers = [];

  @override
  void initState() {
    super.initState();
    requestPermission();
    _displayedUsers = widget.friendUsers;
  }

  Future<List<Contact>> _getPhoneContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts(withThumbnails: false);
    return contacts.toList();
  }

  void _filterSearchResults(String query) async {
    if (query.isNotEmpty) {
      await requestPermission();
      List<Contact> contacts = await _getPhoneContacts();
      List<UserProfile> filteredFriendUsers = widget.friendUsers.where((user) {
        return user.displayName?.toLowerCase().contains(query.toLowerCase()) == true ||
            user.phoneNumber.contains(query);
      }).toList();

      List<UserProfile> filteredContacts = contacts.where((contact) {
        return contact.displayName?.toLowerCase().contains(query.toLowerCase()) == true ||
            contact.phones!.any((phone) => phone.value!.contains(query));
      }).map((contact) => UserProfile(
        uid: contact.identifier!,
        phoneNumber: contact.phones!.first.value!,
        displayName: contact.displayName,
        email: contact.emails!.isNotEmpty ? contact.emails!.first.value : null,
        photoUrl: null,
      )).toList();

      setState(() {
        _displayedUsers = filteredFriendUsers + filteredContacts;
      });
    } else {
      setState(() {
        _displayedUsers = widget.friendUsers;
      });
    }
  }

  Future<void> requestPermission() async {
    PermissionStatus status = await Permission.contacts.status;
    if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      await Permission.contacts.request();
    }
    if (!status.isGranted) {
      status = await Permission.contacts.request();
      if (!status.isGranted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Contacts Access Denied'),
              content: Text('This feature requires access to your contacts.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: _filterSearchResults,
          decoration: InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: _displayedUsers.length,
        itemBuilder: (context, index) {
          UserProfile user = _displayedUsers[index];
          return UserSearchItem(user: user, isFriend: widget.friendUsers.contains(user));
        },
      ),
    );
  }
}
