import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget getCustomTextBold({
  required String text,
  Color textColor = Colors.black,
  required double textSize,
  TextAlign textAlign = TextAlign.center
}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      letterSpacing: -0.5.w,
      color: textColor,
      fontSize: textSize,
      fontFamily: 'MonaSans',
      fontWeight: FontWeight.w800,
    ),
  );
}

Widget getCustomTextThin({
  required String text,
  Color textColor = Colors.black,
  required double textSize,
  TextAlign textAlign = TextAlign.center
}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      letterSpacing: 0.02.w,
      color: textColor,
      fontSize: textSize,
      fontFamily: 'MonaSans',
      fontWeight: FontWeight.w300,
    ),
  );
}

Widget getCustomTextMedium({
  required String text,
  Color textColor = Colors.black,
  required double textSize,
  TextAlign textAlign = TextAlign.center
}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      letterSpacing: 0.02.w,
      color: textColor,
      fontSize: textSize,
      fontFamily: 'MonaSans',
      fontWeight: FontWeight.w600,
    ),
  );
}

Widget getCustomTextNormal({
  required String text,
  Color textColor = Colors.black,
  required double textSize,
  TextAlign textAlign = TextAlign.center
}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      letterSpacing: 0.02.w,
      color: textColor,
      fontSize: textSize,
      fontFamily: 'MonaSans',
      fontWeight: FontWeight.w400,
    ),
  );
}