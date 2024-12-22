import 'package:atef_physics/core/constants/app_text_styles.dart';
import 'package:atef_physics/core/routes/app_router.dart';
import 'package:atef_physics/core/utils/storage.dart';
import 'package:atef_physics/core/models/user_model.dart';
import 'package:atef_physics/gen/assets.gen.dart';
import 'package:atef_physics/features/Auth/data/model/user_model.dart';
import 'package:atef_physics/features/Auth/presentation/screens/login_screen.dart';
import 'package:atef_physics/features/profile/screens/profile_screen.dart';
import 'package:atef_physics/gen/assets.gen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppdrawer extends StatelessWidget {
  const CustomAppdrawer({super.key});
  @override
  Widget build(BuildContext context) {
    final UserModel user = Storage.instance.user;
    return Drawer(

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.viewPaddingOf(context).top + 20,
            ),
            Text(
              " ${user.name} مرحبا بك",
              style: AppTextStyles.hevoLight20BlackWhiteW900,
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 10),
            GestureDetector(
                onTap: () {
                  context.pushNamed(ProfileScreen.id);
                },
                child: const Text('الوحده الاولي')),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            GestureDetector(
                onTap: () {
                  context.pushNamed(ProfileScreen.id);
                },
                child: const Text('الوحده التانيه')),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            GestureDetector(
                onTap: () {
                  context.pushNamed(ProfileScreen.id);
                },
                child: const Text('الوحده التالته')),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            GestureDetector(
                onTap: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.settings),
                    SizedBox(width: 10),
                    Text('الاعدادات')
                  ],
                )),
            const SizedBox(height: 10),
            const Divider(),
            const Spacer(),
            GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  context.pushReplacementNamed(LoginScreen.id);
                },
                child: IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      context.pushReplacementNamed(LoginScreen.id);
                    },
                    icon: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.logout_rounded),
                          const SizedBox(width: 10),
                          Text('تسجيل الخروج')
                        ])))
          ],
        ),
      ),
    );
  }
}
