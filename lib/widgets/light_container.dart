import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'custom_text.dart';

class CustomLightContainer extends StatelessWidget {
  final String title;
  final DateTime pickedDate;
  final String inspectingStatus;
  CustomLightContainer({this.title, this.pickedDate, this.inspectingStatus});

  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    bool _isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      width: title == 'Date :'
          ? _isPortrait
              ? mediaQueryWidth * 0.85
              : mediaQueryWidth * 0.45
          : _isPortrait
              ? mediaQueryWidth * 0.65
              : mediaQueryWidth * 0.40,
      height: _isPortrait ? mediaQueryHeight * 0.06 : mediaQueryHeight * 0.12,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      margin: EdgeInsets.symmetric(horizontal: 13.0, vertical: 7.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.grey.shade400, width: 2.0)),
      child: Center(
        child: CustomText(
          title: title == 'Date :'
              ? '$title ${DateFormat(' d/MM/yyyy  KK:mm a').format(pickedDate)}'
              : '$title $inspectingStatus',
          fontSize: 18.0,
        ),
      ),
    );
  }
}
