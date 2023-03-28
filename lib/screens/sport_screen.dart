import 'package:flutter/material.dart';
import 'package:playmates_app/home.dart';
import 'package:playmates_app/screens/sport_input_screen.dart';
import 'package:playmates_app/screens/stylish_test_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SportScreen(gameMode: GameMode(
        id: 1,
        name: 'Football',
        icon: Icons.sports_soccer,
        totalPlayers: 10,
      ),),
    );
  }
}

class SportScreen extends StatefulWidget {
  final GameMode gameMode;

  SportScreen({required this.gameMode});

  @override
  _SportScreenState createState() => _SportScreenState(gameMode: gameMode);
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
            onGameModeSelected: (GameMode selectedGameMode) {
              setState(() {
                gameMode = selectedGameMode;
              });
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sport Screen'),
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: _openSettings,
        ),
        actions: [
          IconButton(
            icon: Icon(gameMode.icon),
            onPressed: _openGameModeModal,
          ),
        ],
      ),
      body: Center(
        child: SportInputScreen(gameMode: gameMode),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(child: Text('Settings Page')),
    );
  }
}

class GameModeModal extends StatefulWidget {
  final List<GameMode> gameModes;
  final Function(GameMode) onGameModeSelected;

  GameModeModal({required this.gameModes, required this.onGameModeSelected});

  @override
  _GameModeModalState createState() => _GameModeModalState();
}

class _GameModeModalState extends State<GameModeModal> {
  String searchQuery = '';

  List<GameMode> get _filteredGameModes {
    return widget.gameModes.where((gameMode) => gameMode.name.toLowerCase().contains(searchQuery.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            children: [
        Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: TextField(
        onChanged: (value) {
      setState(() {
        searchQuery = value;
      });
    },
          decoration: InputDecoration(
            labelText: "Search",
            hintText: "Search game modes",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              ),
            ),
          ),
        ),
        ),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredGameModes.length,
                  itemBuilder: (context, index) {
                    GameMode gameMode = _filteredGameModes[index];
                    return InkWell(
                      onTap: () {
                        widget.onGameModeSelected(gameMode);
                        Navigator.pop(context);
                      },
                      child: GameModeTile(gameMode: gameMode),
                    );
                  },
                ),
              ),
            ],
        ),
    );
  }
}

class GameModeTile extends StatelessWidget {
  final GameMode gameMode;

  GameModeTile({required this.gameMode});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(gameMode.icon, size: 40),
      title: Text(gameMode.name),
    );
  }
}