import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class MyInputData {
  final String location;
  final int count;
  final DateTime dateTime;

  MyInputData({required this.location, required this.count, required this.dateTime});

}
