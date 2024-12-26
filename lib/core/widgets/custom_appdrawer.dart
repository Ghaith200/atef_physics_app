import 'package:atef_physics/core/constants/app_text_styles.dart';
import 'package:atef_physics/core/utils/app_colors.dart';
import 'package:atef_physics/core/utils/app_snack_bar.dart';
import 'package:atef_physics/core/utils/storage.dart';
import 'package:atef_physics/core/models/user_model.dart';

import 'package:atef_physics/features/Auth/presentation/screens/login_screen.dart';
import 'package:atef_physics/features/profile/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppdrawer extends StatefulWidget {
  const CustomAppdrawer({super.key});

  @override
  State<CustomAppdrawer> createState() => _CustomAppdrawerState();
}

class _CustomAppdrawerState extends State<CustomAppdrawer> {
  @override
  Widget build(BuildContext context) {
    void _launchWhatsApp(String phoneNumber) async {
      final Uri whatsappUri = Uri.parse("https://wa.me/$phoneNumber");

      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch WhatsApp for $phoneNumber';
      }
    }

    void _callPhoneNumber(String phoneNumber) async {
      final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
      try {
        if (await canLaunchUrl(phoneUri)) {
          await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not launch $phoneNumber';
        }
      } catch (e) {
        debugPrint('Error: $e');
      }
    }

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
              " ${user.name}",
              style: AppTextStyles.hevoLight20BlackWhiteW900,
            ),
            const SizedBox(height: 30),
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
            const Divider(),
            const SizedBox(height: 10),
            GestureDetector(
                onTap: () {
                  _callPhoneNumber('201018964256');
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phone,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 10),
                    Text('تواصل معنا عبر الهاتف ')
                  ],
                )),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            GestureDetector(
                onTap: () {
                  _launchWhatsApp('201018964256');
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.message,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 10),
                    Text('تواصل معنا عبر الواتس ')
                  ],
                )),
            const SizedBox(height: 10),
            const Divider(),
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  await Storage.instance.logout();
                  if (context.mounted) {
                    context.pushReplacementNamed(LoginScreen.id);
                  }
                },
                icon: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout_rounded),
                      SizedBox(width: 10),
                      Text('تسجيل الخروج')
                    ]))
          ],
        ),
      ),
    );
  }

  void _launchWhatsApp(String phoneNumber) async {
    try {
      // WhatsApp URL scheme for direct chat
      final Uri whatsappUri = Uri.parse("whatsapp://send?phone=$phoneNumber");

      // Check if the WhatsApp URI can be launched
      if (await canLaunchUrl(whatsappUri)) {
        // Launch WhatsApp
        await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
        context.pop();
      } else {
        // If WhatsApp is not installed or cannot handle the URL, show a message
        context.pop();
        AppSnackBar.showSnackBar(
            context, 'WhatsApp is not installed on your device.');
      }
    } catch (e) {
      context.pop();
      AppSnackBar.showSnackBar(context, 'Error launching WhatsApp');
    }
  }

  void _callPhoneNumber(String phoneNumber) async {
    try {
      // Ensure the phone number is formatted correctly with '+'
      String formattedPhoneNumber = phoneNumber.startsWith('00')
          ? phoneNumber.replaceFirst('00', '+')
          : phoneNumber;

      // Create a URI for the tel scheme
      Uri uri = Uri(scheme: 'tel', path: formattedPhoneNumber);

      // Check if the device can handle the tel scheme
      if (await canLaunchUrl(uri)) {
        // Launch the phone dialer
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        context.pop();
      } else {
        // Notify the user if no dialer is available
        context.pop();
        AppSnackBar.showSnackBar(context, 'Failed launching phone dialer');
      }
    } catch (e) {
      // Handle any errors that occur
      context.pop();
      AppSnackBar.showSnackBar(context, 'Failed launching phone dialer');
    }
  }
}
