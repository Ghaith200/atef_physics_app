import 'package:atef_physics/core/widgets/custom_appdrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:atef_physics/core/widgets/custom_appbar.dart';
import 'package:atef_physics/core/widgets/custom_textfield.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String id = "/HomeScreen";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 15.sp),
      child: Scaffold(
        drawer: const CustomAppdrawer(),
        appBar: const CustomAppBars(
          text: "Home",
        ),
        body: Column(
          children: [
            
          ],

        ),
      ),
    );
  }
}
