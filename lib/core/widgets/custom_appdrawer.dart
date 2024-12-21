import 'package:atef_physics/core/constants/app_text_styles.dart';
import 'package:atef_physics/core/utils/storage.dart';
import 'package:atef_physics/features/Auth/data/model/user_model.dart';
import 'package:flutter/material.dart';

class CustomAppdrawer extends StatelessWidget {
  const CustomAppdrawer({super.key});
  @override
  Widget build(BuildContext context) {
    final UserModel user = Storage.instance.user;
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.viewPaddingOf(context).top + 20,
          ),
          Text(
            "مرحبا بك",
            style: AppTextStyles.hevoLight25BlackWhiteW900,
          ),
          const SizedBox(height: 10),
          Text(
            user.name,
            style: AppTextStyles.hevoLight25BlackWhiteW900,
          ),
          
        ],
      ),
    );
  }
}
