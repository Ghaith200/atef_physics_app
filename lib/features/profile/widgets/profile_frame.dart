import 'package:flutter/material.dart';
import 'package:atef_physics/gen/assets.gen.dart';

class ProfileFrame extends StatelessWidget {
  const ProfileFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: AssetImage(Assets.images.profileFrame.path),
            fit: BoxFit.cover),
      ),
    );
  }
}
