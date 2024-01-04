import 'package:flutter/material.dart';
import 'package:kitchen_manager/utils/colors.dart';
import 'package:kitchen_manager/utils/styles.dart';
import 'package:sizer/sizer.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyles.background,
      width: 100.w,
      height: 100.h,
      child: const Center(
        child: CircularProgressIndicator(
          color: Appcolors.accentColor,
        ),
      ),
    );
  }
}
