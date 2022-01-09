import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color fontColor;
  final double linesHeight;
  final int linesNum;

  CustomText({
    this.title,
    this.fontColor = Colors.black,
    this.fontSize,
    this.linesHeight,
    this.linesNum
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: fontColor,
        fontSize: fontSize,
        height: linesHeight,
      ),
      maxLines: linesNum,
      overflow: TextOverflow.ellipsis,
    );
  }
}
