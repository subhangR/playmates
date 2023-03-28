import 'package:flutter/material.dart';
import 'package:playmates_app/widgets/friends_search_modal.dart';
import 'package:playmates_app/constants/users.dart';
import '../models/user_profile.dart';

class GameMode {
  final int id;
  final String name;
  final IconData icon;
  final int totalPlayers;

  GameMode({required this.id, required this.name, required this.icon, required this.totalPlayers});
}



class SportInputScreen extends StatefulWidget {
  final GameMode gameMode;

  SportInputScreen({required this.gameMode});

  @override
  _SportInputScreenState createState() => _SportInputScreenState();
}

class _SportInputScreenState extends State<SportInputScreen> {

  List<UserProfile> _invitedUsers = [];

  void _inviteUser(UserProfile user) {
    setState(() {
      if (!_invitedUsers.contains(user)) {
        _invitedUsers.add(user);
      }
    });
  }

  void _removeUser(UserProfile user) {
    setState(() {
      _invitedUsers.remove(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.blue.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LobbyCard(
                  gameMode: widget.gameMode,
                  users: getUsers(),
                  invitedUsers: _invitedUsers,
                  onInviteUser: _inviteUser,
                  onRemoveUser: _removeUser,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text('Court Settings',
                              style: TextStyle(fontSize: 20, color: Colors.white)),
                          SizedBox(width: 8),
                          Icon(Icons.settings, size:24, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
                // Add Date and Time inputs here
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    print('Players in the card: ${_invitedUsers.map((user) => user.displayName).join(', ')}');
                    // Print date and time here
                  },
                  child: Text('Find'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

    );
  }
}

class LobbyCard extends StatelessWidget {
  final GameMode gameMode;
  final List<UserProfile> users;
  final List<UserProfile> invitedUsers;
  final Function(UserProfile) onInviteUser;
  final Function(UserProfile) onRemoveUser;

  LobbyCard({
    required this.gameMode,
    required this.users,
    required this.invitedUsers,
    required this.onInviteUser,
    required this.onRemoveUser,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
    ),
    elevation: 8.0,
    child:Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Game Mode Info'),
                    content: Text('Game Mode: ${gameMode.name}\nTotal Players: ${gameMode.totalPlayers}'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Icon(gameMode.icon, size: 80),
          ),
          SizedBox(height: 10),
          Wrap(
            children: invitedUsers
                .map((user) => Chip(
              avatar: Icon(user.icon),
              label: Text(user.displayName!),
              deleteIcon: Icon(Icons.remove_circle, color: Colors.red),
              onDeleted: () => onRemoveUser(user),
            ))
                .toList(),
          ),
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return UserSearchModal(friendUsers: users);
                },
              );
            },
          ),
        ],
      ),
    ),
    );
  }
}