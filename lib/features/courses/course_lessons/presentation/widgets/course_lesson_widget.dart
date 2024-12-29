import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/models/lesson_model.dart';
import 'package:atef_physics/core/utils/app_colors.dart';
import 'package:atef_physics/core/utils/app_snack_bar.dart';
import 'package:atef_physics/core/utils/storage.dart';
import 'package:atef_physics/features/courses/course_lessons/cubit/course_lessons_cubit.dart';
import 'package:atef_physics/features/courses/course_lessons/presentation/screens/course_add_lesson.dart';
import 'package:atef_physics/features/vedio/screens/vedio_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CourseLessonWidget extends StatefulWidget {
  const CourseLessonWidget({
    super.key,
    required this.lesson,
    required this.model,
  });

  final LessonModel lesson;
  final CourseModel model;

  @override
  State<CourseLessonWidget> createState() => _CourseLessonWidgetState();
}

class _CourseLessonWidgetState extends State<CourseLessonWidget> {
  late LessonModel lesson = LessonModel.fromJson(widget.lesson.toJson());
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        if (lesson.userWatchCount >= lesson.watchCount &&
            !Storage.instance.isAdmin) {
          AppSnackBar.showSnackBar(context, "lesson Watch count ended ");
          return;
        }
        final i = lesson.watchCount + 1;
        final cubit = BlocProvider.of<CourseLessonsCubit>(context);
        await cubit.updateLesson(lesson: lesson, userWatchCount: i,model: widget.model);
        if (context.mounted) {
          cubit.state.mapOrNull(
            update: (value) {
              if (lesson.id == value.model.id) {
                lesson = value.model;
                if (value.model.userWatchCount <= value.model.watchCount) {
                  // context
                  //     .pushNamed(VedioScreen.id, extra: {'lesson': lesson.id});
                }
              }
            },
          );
        }
      },
      title: Text(widget.lesson.name),
      subtitle: Text("${lesson.userWatchCount} / ${lesson.watchCount} "),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (Storage.instance.isAdmin)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () =>
                        context.pushNamed(CourseAddLesson.id, extra: {
                          "course": widget.model,
                          "lesson": lesson,
                          "cubit": BlocProvider.of<CourseLessonsCubit>(context)
                        }),
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () =>
                        BlocProvider.of<CourseLessonsCubit>(context)
                            .removeLesson(
                          course: widget.model,
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
