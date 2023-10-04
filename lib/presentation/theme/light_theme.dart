import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: const Color(0xff108ED4),
  scaffoldBackgroundColor: const Color(0xffffffff),
  primaryColorLight: const Color(0xffffffff),
  textTheme: TextTheme(
      displaySmall: TextStyle(fontSize: 28.sp, color: const Color(0xff757575))),
  disabledColor: const Color(0xff757575),
  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xffBED8FB),
    shape: Border(
      top: BorderSide(
        color: Color(0xff2C2F3E),
      ),
      bottom: BorderSide(
        color: Color(0xff2C2F3E),
      ),
      left: BorderSide(
        color: Color(0xff2C2F3E),
      ),
      right: BorderSide(
        color: Color(0xff2C2F3E),
      ),
    ),
  ),
);
