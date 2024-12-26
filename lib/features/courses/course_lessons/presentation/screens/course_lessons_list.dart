import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/models/lesson_model.dart';
import 'package:atef_physics/core/utils/app_snack_bar.dart';
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
  List<LessonModel> lesson = [];
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
          successAll: (models) => lesson.addAll(models),
          add: (models) => lesson.add(models),
          remove: (model) {
            AppSnackBar.showSnackBar(context, "${model.name}\n removed");
            lesson.removeWhere((e) => e.id == model.id);
          },
          update: (model) {
            AppSnackBar.showSnackBar(context, "${model.name}\n Updated");
            final e = lesson.indexWhere((e) => e.id == model.id);
            lesson[e] = model;
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
                : ListView.builder(
                    shrinkWrap:
                        true, // Ensures the ListView takes only the required space
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable ListView's scroll

                    itemCount: lesson.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CourseLessonWidget(
                          lesson: lesson[index], model: widget.course);
                    },
                  ),
            load: () => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }
}
