import 'package:flutter/material.dart';
import 'package:with_u/utils/SharedpreferencesUtils.dart';
class CustomYearPicker extends StatefulWidget {
  @override
  _CustomYearPickerState createState() => _CustomYearPickerState();
}

class _CustomYearPickerState extends State<CustomYearPicker> {
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height:150,
      child: YearPicker(
        selectedDate: _date,
        onChanged: (date) => {
          setState(() => _date = date),
        SharedPreferencesUtils.savePreference(context, 'Year', date.toString())},
        firstDate: DateTime(1980),
        lastDate: DateTime(2100),
      ),
    );
  }
}