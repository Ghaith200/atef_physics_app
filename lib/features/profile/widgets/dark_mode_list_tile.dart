import 'package:flutter/material.dart';
import 'package:atef_physics/core/utils/app_colors.dart';
import 'package:atef_physics/gen/assets.gen.dart';

class DarkmodeListTile extends StatefulWidget {
  const DarkmodeListTile({super.key});

  @override
  State<DarkmodeListTile> createState() => _DarkmodeListTileState();
}

class _DarkmodeListTileState extends State<DarkmodeListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: const Text('Dark Mode'),
        leading: Image.asset(
          AppColors.isDarkMode
              ? Assets.images.darkModeOnIcon.path
              : Assets.images.darkModeOffIcon.path,
          fit: BoxFit.cover,
          width: 40,
          height: 40,
        ),
        trailing: Switch(
          value: AppColors.isDarkMode, // Replace with your boolean state
          onChanged: (value) {
            setState(() {
              AppColors.isDarkMode = value;
            });
          },
          activeTrackColor: Colors.green, // Active track color
          activeColor: Colors.white, // Active thumb color
          inactiveTrackColor: Colors.grey, // Inactive track color
          inactiveThumbColor: Colors.white, // Inactive thumb color
        ));
  }
}
