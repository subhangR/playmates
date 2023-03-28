import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:playmates_app/services/external_api_service.dart';

import '../models/date_picker.dart';
import '../models/my_input_data.dart';

class MyInputScreen extends StatefulWidget {
  @override
  _MyInputScreenState createState() => _MyInputScreenState();
}

class _MyInputScreenState extends State<MyInputScreen> {
  TextEditingController locationController = TextEditingController();
  ExternalApiService externalApiService = ExternalApiService();
  int counter = 0;
  DateTime selectedDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Input Screen')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: locationController,
              readOnly: true,
              decoration: InputDecoration(labelText: 'Current Location'),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      counter--;
                    });
                  },
                  icon: Icon(Icons.remove),
                ),
                Text('$counter', style: TextStyle(fontSize: 24)),
                IconButton(
                  onPressed: () {
                    setState(() {
                      counter++;
                    });
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveInputs,
              child: Text('Save Inputs'),
            ),
          ],
        ),
      ),
    );
  }

  _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);
          print(position.latitude.toString() + " " + position.longitude.toString());
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String location = '${placemark.locality}, ${placemark.country}';
        setState(() {
          locationController.text = location;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void _saveInputs() {
    externalApiService.postObjectAsJson("{\"requestId\":\"match123\",\"gameModeId\":\"mode123\",\"lobby\":{\"lobbyId\":\"lobby123\",\"lobbyLeader\":{\"userId\":\"user123\",\"userSettings\":{\"userId\":\"user123\",\"currentCity\":1,\"distanceLevel\":\"MEDIUM\",\"location\":{\"latitude\":37.7749,\"longitude\":-122.4194}}},\"lobbyPlayers\":[{\"userId\":\"user456\",\"userSettings\":{\"userId\":\"user456\",\"currentCity\":2,\"distanceLevel\":\"NEAR\",\"location\":{\"latitude\":40.7128,\"longitude\":-74.0060}}}]},\"numBots\":2}", "http://192.168.29.238:8080/find/match");
  }
}
