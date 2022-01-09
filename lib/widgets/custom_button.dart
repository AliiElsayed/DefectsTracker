import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String btnTitle;
  final Function onBtnPressed;

  CustomButton({this.btnTitle, this.onBtnPressed});

  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    bool _isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
      width: _isPortrait? mediaQueryWidth *0.43: mediaQueryWidth *0.43 ,
      height: _isPortrait?mediaQueryHeight *0.07:mediaQueryHeight *0.12,
      child: ElevatedButton(
        child: Text(
          btnTitle,
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: onBtnPressed,
      ),
    );
  }
}
