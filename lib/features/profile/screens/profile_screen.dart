import 'package:flutter/material.dart';
import 'package:atef_physics/core/constants/app_text_styles.dart';
import 'package:atef_physics/features/profile/widgets/custom_list_tile.dart';
import 'package:atef_physics/features/profile/widgets/dark_mode_list_tile.dart';
import 'package:atef_physics/features/profile/widgets/profile_frame.dart';
import 'package:atef_physics/features/profile/widgets/profile_picture.dart';
import 'package:atef_physics/gen/assets.gen.dart';

class ProfileScreen extends StatelessWidget {
  static const id = '/ProfileScreen';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              height: 200,
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                children: [
                  const Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ProfilePicture(),
                        ProfileFrame(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Center(
                      child: Text(
                        'Abdullah Ghaith',
                        style: AppTextStyles.hevoLight20WhitekW100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const DarkmodeListTile(),
          const SizedBox(height: 5),
          CustomListTile(
            image: Assets.images.activeStatus.path,
            title: 'Active Status',
            label: 'ON',
          ),
          const SizedBox(height: 5),
          CustomListTile(
            image: Assets.images.userName.path,
            title: 'Username',
            label: 'user.name',
          ),
          const SizedBox(height: 5),
          CustomListTile(
            image: Assets.images.notification.path,
            title: 'Notifications & Sounds',
          ),
          const SizedBox(height: 5),
          CustomListTile(
            image: Assets.images.people.path,
            title: 'People',
          ),
          const SizedBox(height: 5),
          CustomListTile(
            image: Assets.images.people.path,
            title: 'Phone Contacts',
          ),
        ],
      ),
    ));
  }
}
