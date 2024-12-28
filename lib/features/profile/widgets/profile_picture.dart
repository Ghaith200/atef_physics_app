import 'package:flutter/material.dart';
import 'package:atef_physics/gen/assets.gen.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: AssetImage(Assets.images.me.path), fit: BoxFit.cover),
      ),
    );
  }
}
