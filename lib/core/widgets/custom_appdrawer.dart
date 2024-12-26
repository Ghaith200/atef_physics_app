import 'package:atef_physics/core/constants/app_text_styles.dart';
import 'package:atef_physics/core/constants/storage_keys.dart';
import 'package:atef_physics/core/utils/app_colors.dart';
import 'package:atef_physics/core/utils/storage.dart';
import 'package:atef_physics/core/models/user_model.dart';
import 'package:atef_physics/features/Auth/presentation/screens/login_screen.dart';
import 'package:atef_physics/features/courses/course/cubit/course_cubit.dart';
import 'package:atef_physics/features/courses/course/screens/my_courses_screen.dart';
import 'package:atef_physics/features/home/presentation/home_screen.dart';
import 'package:atef_physics/features/users/presentation/screens/users_screen.dart';
import 'package:atef_physics/gen/assets.gen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppdrawer extends StatelessWidget {
  const CustomAppdrawer({super.key});
  @override
  Widget build(BuildContext context) {
    final CourseCubit courseCubit = BlocProvider.of<CourseCubit>(context);

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
              "${user.name}\n${user.phoneNumber}",
              textAlign: TextAlign.center,
              style: AppTextStyles.hevoLight20BlackWhiteW900
                  .copyWith(color: AppColors.blue),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 10),
            GestureDetector(
                onTap: () => context.pushReplacementNamed(HomeScreen.id,
                    extra: {"cubit": courseCubit}),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home, color: AppColors.blue),
                    SizedBox(width: 10),
                    Text('الصفحه الرائيسيه')
                  ],
                )),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            GestureDetector(
                onTap: () => context.pushReplacementNamed(MyCoursesScreen.id,
                    extra: {"cubit": courseCubit}),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.images.icons.learning
                        .image(width: 25, color: AppColors.blue),
                    const SizedBox(width: 10),
                    const Text('كورساتى')
                  ],
                )),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            if (Storage.instance.isAdmin)
              GestureDetector(
                  onTap: () => context.pushReplacementNamed(UsersScreen.id,
                      extra: {"cubit ": courseCubit}),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.images.icons.multipleUsersSilhouette
                          .image(width: 25, color: AppColors.blue),
                      const SizedBox(width: 10),
                      const Text('المستخدمين')
                    ],
                  )),
            const SizedBox(height: 10),
            if (Storage.instance.isAdmin) const Divider(),
            const Spacer(),
            const Divider(),
            const SizedBox(height: 10),
            GestureDetector(
                onTap: () {
                  _callPhoneNumber('00971505041741');
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
                  _launchWhatsApp('+971503136836');
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
                      Icon(Icons.logout_rounded, color: AppColors.blue),
                      SizedBox(width: 10),
                      Text('تسجيل الخروج')
                    ]))
          ],
        ),
      ),
    );
  }

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
}
