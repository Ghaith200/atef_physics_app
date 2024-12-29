/*
edited by : Mohamed Waleed
edited at : 29/10/2024
edits :
Add onPressed that is optional paramter for the back button to control to where it will pop
 */
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton(
      {super.key, this.iconColor = Colors.black, this.onPressed});
  final Color iconColor;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ??
          () {
            //check first if the context can pop or not
            if (context.canPop()) {
              context.pop();
            }
          },
      icon: Icon(
        Icons.arrow_back_ios_rounded,
        color: iconColor,
        size: 24,
      ),
    );
  }
}
