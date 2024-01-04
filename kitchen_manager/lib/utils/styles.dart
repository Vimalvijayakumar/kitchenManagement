import 'package:flutter/material.dart';
import 'package:kitchen_manager/utils/colors.dart';
import 'package:sizer/sizer.dart';

class AppStyles {
  static InputDecoration getInputDecorationStyle(
      {String? hint, IconData? icon}) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(
        icon,
        color: Appcolors.accentColor,
        size: 30,
      ),
      errorStyle: TextStyle(color: Colors.red),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Appcolors.textColor, width: 1)),
      hintStyle: TextStyle(
          color: Appcolors.hintColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          textBaseline: TextBaseline.alphabetic,
          fontStyle: FontStyle.normal),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Appcolors.accentColor, width: 1)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Appcolors.accentColor, width: 1)),
    );
  }

  static const background = BoxDecoration(color: Appcolors.backgroundColor);
}
