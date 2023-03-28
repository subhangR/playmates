import 'package:flutter/material.dart';

import '../widgets/team_distribution_card.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020, 1),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
      });
  }

  void findButtonPressed() {
    print('Date: $_selectedDate');
    print('Time: $_selectedTime');
    // Add logic to handle the find button press
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TeamDistributorCard(totalPlayers: 10),
        SizedBox(height: 20),
        ListTile(
          title: Text('Date: ${_selectedDate.toLocal()}'.split(' ')[0]),
          trailing: Icon(Icons.calendar_today),
          onTap: () => _selectDate(context),
        ),
        ListTile(
          title: Text('Time: ${_selectedTime.format(context)}'),
          trailing: Icon(Icons.access_time),
          onTap: () => _selectTime(context),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: findButtonPressed,
          child: Text('Find'),
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}