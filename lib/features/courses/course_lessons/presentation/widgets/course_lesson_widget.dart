import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/models/lesson_model.dart';
import 'package:atef_physics/core/utils/app_colors.dart';
import 'package:atef_physics/features/courses/course_lessons/cubit/course_lessons_cubit.dart';
import 'package:atef_physics/features/courses/course_lessons/presentation/screens/course_add_lesson.dart';
import 'package:atef_physics/features/vedio/screens/vedio_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CourseLessonWidget extends StatelessWidget {
  const CourseLessonWidget({
    super.key,
    required this.lesson,
    required this.model,
  });

  final LessonModel lesson;
  final CourseModel model;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.pushNamed(VedioScreen.id, extra: {'lesson': lesson});
      },
      title: Text(lesson.name),
      subtitle: Text("${lesson.userWatchCount} / ${lesson.watchCount} "),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () =>
                      context.pushNamed(CourseAddLesson.id, extra: {
                        "course": model,
                        "lesson": lesson,
                        "cubit": BlocProvider.of<CourseLessonsCubit>(context)
                      }),
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () =>
                      BlocProvider.of<CourseLessonsCubit>(context).removeLesson(
                        course: model,
                        lesson: lesson,
                      ),
                  color: AppColors.red,
                  icon: const Icon(Icons.close)),
            ],
          ),
          const Icon(Icons.play_circle_outline_rounded),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
    );
  }
}
