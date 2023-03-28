import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playmates_app/home.dart';
import 'package:playmates_app/screens/home_screen.dart';
import 'package:playmates_app/screens/sport_input_screen.dart';
import 'package:playmates_app/screens/stylish_test_screen_2.dart';
import 'package:playmates_app/screens/user_management/signin_screen.dart';
import 'package:playmates_app/screens/sport_screen.dart';
import 'package:playmates_app/screens/stylish_test_screen.dart';
import 'package:playmates_app/screens/user_management/user_profile_screen.dart';
import 'widgets/team_distribution_card.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //final fcmToken = await FirebaseMessaging.instance.getToken();
  //print("fcmToken +" + fcmToken!);
  //FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body : StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            return MyInputScreen();
          } else {
            //return StylishLayout();
            return SportScreen(gameMode: GameMode(id: 1, name: 'Football', icon: Icons.sports_soccer, totalPlayers: 22));

          }
        },
      ),
        bottomNavigationBar: CustomBottomAppBar(),
      ),
      );
  }
}

class CustomBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 50,
              height: 50,
              child: IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  // Your action for the first square AppBar item
                },
              ),
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              child: IconButton(
                icon: Icon(Icons.search),
                color: Colors.white,
                onPressed: () {
                  // Your action for the circular AppBar item
                },
              ),
            ),
            Container(
              width: 50,
              height: 50,
              child: IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  // Your action for the third square AppBar item
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId} ${message.data}');
}

class _SportScreenState extends State<SportScreen> {
GameMode gameMode;
  List<GameMode> allGameModes = [
    GameMode(id: 1, name: 'Football', icon: Icons.sports_soccer, totalPlayers: 22),
    GameMode(id: 2, name: 'Basketball', icon: Icons.sports_basketball, totalPlayers: 10,),
    GameMode(id: 3, name: 'Tennis', icon: Icons.sports_tennis, totalPlayers: 4),
  ];

  _SportScreenState({required this.gameMode});

  @override
  void initState() {
    super.initState();
    gameMode = widget.gameMode;
  }

  void _openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsScreen()),
    );
  }

  void _openGameModeModal() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return GameModeModal(
            gameModes: allGameModes,
            onGameModeSelected: (GameMode gameMode) {
              setState(() {
                this.gameMode = gameMode;
              });
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playmates'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _openSettings,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            child: Stack(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: Text(
                    'Choose your sport',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 20,
                  child: Text(
                    gameMode.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: 120,
                  left: 20,
                  child: Text(
                    'Total players: ${gameMode.totalPlayers}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                Positioned(
                  top: 150,
                  left: 20,
                  child: Text(
                    'Tap to change',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: IconButton(
                    icon: Icon(
                      gameMode.icon,
                      color: Colors.white,
                      size: 100,
                    ),
                    onPressed: _openGameModeModal,
                  ),
                ),
              ],
            ),
          ),
    ]),
    );
}
}


