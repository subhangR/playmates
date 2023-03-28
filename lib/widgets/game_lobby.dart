import 'package:flutter/material.dart';

import '../models/user_profile.dart';
import '../screens/sport_input_screen.dart';

class GameLobby extends StatelessWidget {
  final GameMode gameMode;
  final List<UserProfile> lobbyPlayers;

  GameLobby({required this.gameMode, required this.lobbyPlayers});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              gameMode.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1,
                children: List.generate(
                  gameMode.totalPlayers,
                      (index) {
                    if (index < lobbyPlayers.length) {
                      final user = lobbyPlayers[index];
                      return CircleAvatar(
                        backgroundImage
                            : AssetImage('assets/images/default_avatar.png'),
                      );
                    } else {
                      return CircleAvatar(
                        child: Icon(
                          Icons.person_outline,
                          size: 40,
                        ),
                        backgroundColor: Colors.grey[300],
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}