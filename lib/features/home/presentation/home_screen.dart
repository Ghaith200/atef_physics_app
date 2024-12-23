import 'dart:developer';

import 'package:atef_physics/core/constants/app_text_styles.dart';
import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/utils/app_colors.dart';
import 'package:atef_physics/core/widgets/custom_appdrawer.dart';
import 'package:atef_physics/features/courses/presentation/course/screens/add_course_screen.dart';
import 'package:atef_physics/features/courses/presentation/course/cubit/course_cubit.dart';
import 'package:atef_physics/features/courses/presentation/widgets/course_widget.dart';
import 'package:atef_physics/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:atef_physics/core/widgets/custom_appbar.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String id = "/HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CourseCubit cubit;
  List<CourseModel> courses = [];
  @override
  initState() {
    super.initState();
    cubit = BlocProvider.of<CourseCubit>(context);
    cubit.getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      onRefresh: () async {
        await cubit.getCourses();
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.pushNamed(AddCourseScreen.id);
            },
            child: const Icon(Icons.add)),
        drawer: const CustomAppdrawer(),
        appBar: CustomAppBars(
          text: "Atef Physics",
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                backgroundImage: AssetImage(Assets.images.icon.path),
                radius: 20.sp,
              ),
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 200.sp,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'الاضافات الاخيره',
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: BlocConsumer<CourseCubit, CourseState>(
              listener: (context, state) => state.whenOrNull(
                error: (error) => error.showError(context),
                successAll: (models) => courses = models,
                success: (model) => courses.add(model),
              ),
              builder: (context, state) {
                final Widget? widge = state.whenOrNull<Widget>(
                  load: () => const Center(child: CircularProgressIndicator()),
                  successAll: (models) {
                    log("Courses Loaded");
                    courses = models;
                    return null;
                  },
                );
                if (widge != null) {
                  return widge;
                }
                return courses.isEmpty
                    ? Text(
                        "لا يوجد كورسات حاليا",
                        style: AppTextStyles.hevoLight20BlackWhiteW900,
                      )
                    : GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                        ),
                        itemCount: courses.length,
                        itemBuilder: (context, index) {
                          return CourseWidget(course: courses[index]);
                        },
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
