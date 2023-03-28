import 'package:flutter/material.dart';

class Friend {
  final String name;
  final AssetImage avatar;

  Friend({required this.name, required this.avatar});
}

final List<Friend> users = [
  Friend(name: 'Alice', avatar: AssetImage('assets/images/football.jpeg')),
  Friend(name: 'Bob', avatar: AssetImage('assets/images/football.jpeg')),
  Friend(name: 'Carol', avatar: AssetImage('assets/images/football.jpeg')),
  // Add more users as needed
];

class TeamDistributorCard extends StatefulWidget {
  final int totalPlayers;
  TeamDistributorCard({required this.totalPlayers});

  @override
  _TeamDistributorCardState createState() => _TeamDistributorCardState();
}

class _TeamDistributorCardState extends State<TeamDistributorCard> {
  List<Friend> teamOnePlayers = [];
  List<Friend> teamTwoPlayers = [];

  void addUserToTeam(Friend user) {
    if (teamOnePlayers.length + teamTwoPlayers.length < widget.totalPlayers) {
      if (teamOnePlayers.length <= teamTwoPlayers.length) {
        setState(() {
          teamOnePlayers.add(user);
        });
      } else {
        setState(() {
          teamTwoPlayers.add(user);
        });
      }
    }
  }

  void removeUserFromTeam(Friend user, int team) {
    setState(() {
      if (team == 1) {
        teamOnePlayers.remove(user);
      } else {
        teamTwoPlayers.remove(user);
      }
    });
  }

  void showAddFriendsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) {
              final user = users[index];
              return ListTile(
                leading: CircleAvatar(backgroundImage: user.avatar),
                title: Text(user.name),
                trailing: ElevatedButton(
                  child: Text('Invite'),
                  onPressed: () {
                    addUserToTeam(user);
                    Navigator.pop(context);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildUserRow(List<Friend> users, int team) {
    return Wrap(
      children: users.map((user) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: CircleAvatar(backgroundImage: user.avatar),
            ),
            Text(user.name),
            IconButton(
              icon: Icon(Icons.remove_circle, color: Colors.red),
              onPressed: () => removeUserFromTeam(user, team),
            ),
          ],
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(child: Container(
      padding: EdgeInsets.all(8.0),
      width: 300,
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Team 1'),
                    SizedBox(height: 8),
                    buildUserRow(teamOnePlayers, 1),
                  ],
                ),
              ),
              VerticalDivider(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Team 2'),
                    SizedBox(height: 8),
                    buildUserRow(teamTwoPlayers, 2),
                  ],
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => showAddFriendsModal(context),
            child: Text(
              'Add Friends',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    ),
    );

  }
}
