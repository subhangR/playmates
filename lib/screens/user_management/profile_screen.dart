import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String phoneNumber;

  HomePage({required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome!"),
            SizedBox(height: 16),
            Text("Phone number: $phoneNumber"),
          ],
        ),
      ),
    );
  }
}