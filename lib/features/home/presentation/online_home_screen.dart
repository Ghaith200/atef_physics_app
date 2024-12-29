import 'dart:developer';

import 'package:atef_physics/core/constants/app_text_styles.dart';
import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/utils/app_colors.dart';
import 'package:atef_physics/core/utils/app_snack_bar.dart';
import 'package:atef_physics/core/widgets/custom_appbar.dart';
import 'package:atef_physics/core/widgets/custom_appdrawer.dart';
import 'package:atef_physics/features/courses/course/cubit/course_cubit.dart';
import 'package:atef_physics/features/courses/course/screens/add_course_screen.dart';
import 'package:atef_physics/features/courses/course/widgets/course_widget.dart';
import 'package:atef_physics/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OnlineHomeScreen extends StatefulWidget {
  const OnlineHomeScreen({super.key});

  @override
  State<OnlineHomeScreen> createState() => _OnlineHomeScreenState();
}

class _OnlineHomeScreenState extends State<OnlineHomeScreen> {
  late CourseCubit cubit;
  List<CourseModel> courses = [];
  @override
  initState() {
    cubit = BlocProvider.of<CourseCubit>(context);
    cubit.getCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.pushNamed(AddCourseScreen.id, extra: {"cubit": cubit});
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
              radius: 20,
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
                      height: 200,
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
            listener: (context, state) => state.whenOrNull<void>(
              error: (error) => error.showError(context),
              successAll: (models) => courses.addAll(models),
              add: (model) => courses.add(model),
              update: (model) {
                AppSnackBar.showSnackBar(context, "${model.title} Updated");
                final e = courses.indexWhere((e) => e.id == model.id);
                courses[e] = model;
              },
              remove: (model) =>
                  courses.removeWhere((test) => test.id == model.id),
            ),
            builder: (context, state) {
              log("Home Screen ${state.runtimeType} ");

              return state.maybeWhen<Widget>(
                load: () => const Center(child: CircularProgressIndicator()),
                orElse: () => courses.isEmpty
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
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}
