import 'dart:developer';

import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/models/lesson_model.dart';
import 'package:atef_physics/core/utils/app_snack_bar.dart';
import 'package:atef_physics/features/courses/course/cubit/course_cubit.dart';
import 'package:atef_physics/features/courses/course_lessons/cubit/course_lessons_cubit.dart';
import 'package:atef_physics/features/courses/course_lessons/presentation/widgets/course_lesson_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseLessonsList extends StatefulWidget {
  final CourseModel course;
  const CourseLessonsList({
    required this.course,
    super.key,
  });

  @override
  State<CourseLessonsList> createState() => _CourseLessonsListState();
}

class _CourseLessonsListState extends State<CourseLessonsList> {
  List<LessonModel> lesson = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    if (lesson.isEmpty) {
      BlocProvider.of<CourseLessonsCubit>(context)
          .getCourseLessons(widget.course);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseLessonsCubit, CourseLessonsState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (error) => error.showError(context),
          successAll: (models) {
            lesson.addAll(models);
            BlocProvider.of<CourseCubit>(context).setCourse(
              widget.course.copyWith(
                lessons: models.map((e) => e.id).toList(),
              ),
            );
          },
          add: (models) {
            lesson.add(models);
            BlocProvider.of<CourseCubit>(context).setCourse(
              widget.course.copyWith(
                lessons: lesson.map((e) => e.id).toList(),
              ),
            );
          },
          remove: (model) {
            AppSnackBar.showSnackBar(context, "${model.name}\n removed");
            lesson.removeWhere((e) => e.id == model.id);
            BlocProvider.of<CourseCubit>(context).setCourse(
              widget.course.copyWith(
                lessons: lesson.map((e) => e.id).toList(),
              ),
            );
          },
          update: (model) {
            lesson = List.from([
              ...lesson.map<LessonModel>((e) => e.id == model.id ? model : e)
            ], growable: true);
          },
        );
      },
      builder: (context, state) {
        return state.maybeWhen<Widget>(
          orElse: () => lesson.isEmpty
              ? const Center(
                  child: Text(
                    "No lessons",
                    style: TextStyle(fontSize: 20),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: lesson.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CourseLessonWidget(
                        lesson: lesson[index],
                        model: widget.course,
                      );
                    },
                  ),
                ),
          load: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
