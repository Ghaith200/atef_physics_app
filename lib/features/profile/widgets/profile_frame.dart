import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:atef_physics/gen/assets.gen.dart';

class ProfileFrame extends StatelessWidget {
  const ProfileFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.sp,
      width: 150.sp,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: AssetImage(Assets.images.profileFrame.path),
            fit: BoxFit.cover),
      ),
    );
  }
}
