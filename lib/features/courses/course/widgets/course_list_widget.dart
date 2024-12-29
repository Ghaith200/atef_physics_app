import 'dart:developer';

import 'package:atef_physics/core/constants/app_text_styles.dart';
import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/utils/app_snack_bar.dart';
import 'package:atef_physics/core/utils/app_utils.dart';
import 'package:atef_physics/core/utils/storage.dart';
import 'package:atef_physics/features/courses/course/cubit/course_cubit.dart';
import 'package:atef_physics/features/courses/course/widgets/course_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseListWidget extends StatefulWidget {
  const CourseListWidget({
    super.key,
    this.userCourses = false,
  });
  final bool userCourses;
  @override
  State<CourseListWidget> createState() => _CourseListWidgetState();
}

class _CourseListWidgetState extends State<CourseListWidget> {
  List<CourseModel> courses = List.empty();
  late CourseCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<CourseCubit>(context);
    cubit.getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseCubit, CourseState>(
      listener: (context, state) => state.whenOrNull<void>(
        error: (error) => error.showError(context),
        successAll: (models) => courses = List.from(widget.userCourses
            ? models
                .where((test) => test.users.contains(Storage.instance.user.uid))
            : models),
        add: (model) => courses.add(model),
        update: (model) {
          AppSnackBar.showSnackBar(context, "${model.title} Updated");
          final e = courses.indexWhere((e) => e.id == model.id);
          courses[e] = model;
        },
        remove: (model) => courses.removeWhere((test) => test.id == model.id),
      ),
      builder: (context, state) {
        log("Home Screen ${state.runtimeType} ");

        return state.maybeWhen<Widget>(
          load: () => const Center(child: CircularProgressIndicator()),
          orElse: () => courses.isEmpty
              ? Center(
                  child: Text(
                    "لا يوجد كورسات حاليا",
                    style: AppTextStyles.hevoLight20BlackWhiteW900,
                  ),
                )
              : GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: AppScreenUtils.isTablet ? 3 : 2,
                    mainAxisSpacing: 5,
                    mainAxisExtent: AppScreenUtils.isTablet ? 300 : 150,
                    crossAxisSpacing: 5,
                  ),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    return CourseWidget(course: courses[index]);
                  },
                ),
        );
      },
    );
  }
}
