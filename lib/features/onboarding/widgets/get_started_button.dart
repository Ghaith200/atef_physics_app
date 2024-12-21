import 'package:flutter/material.dart';
import 'package:atef_physics/core/utils/app_colors.dart';
import 'package:atef_physics/gen/assets.gen.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327,
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextButton(
        onPressed: () {},
        child: Text(
          'Get Started',
          style: TextStyle(
            fontFamily: Assets.fonts.alexandria,
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
