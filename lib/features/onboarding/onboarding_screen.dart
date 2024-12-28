import 'package:flutter/material.dart';
import 'package:atef_physics/core/constants/app_text_styles.dart';
import 'package:atef_physics/core/utils/storage.dart';
import 'package:atef_physics/core/widgets/custom_button.dart';
import 'package:atef_physics/features/Auth/presentation/screens/login_screen.dart';
import 'package:atef_physics/gen/assets.gen.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatelessWidget {
  static const String id = '/onboarding';
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Align(
                alignment: Alignment.center,
                child: Assets.images.logoPng.image(
                  width: 250,
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Text(
              'Welcome to Atef Physics',
              style: AppTextStyles.poppins24WBlackhiteW900,
            ),
            const Spacer(),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: CustomButton(
                onTap: () async {
                  Storage.instance.isFirstTime = false;
                  context.pushReplacementNamed(LoginScreen.id);
                },
                filled: true,
                boarderRadius: 25,
                title: 'Get Started',
              ),
            ),
            const SizedBox(height: 25),
            GestureDetector(
              onTap: () => context.pushNamed('/terms-and-conditions'),
              child: const Text(
                'Terms and Conditions',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
