import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CustomMinuteIntervalDateTimePickerModel extends DatePickerModel {
  CustomMinuteIntervalDateTimePickerModel({
    required DateTime currentTime,
    required int interval,
  })  : _interval = interval ?? 30,
        super(currentTime: currentTime, locale: LocaleType.en);

  final int _interval;

  @override
  int get minuteDivider => _interval;

  @override
  String minutesStringAtIndex(int index) {
    int minutes = index * _interval;
    if (minutes == 0) {
      return '00';
    }
    return '$minutes';
  }
}