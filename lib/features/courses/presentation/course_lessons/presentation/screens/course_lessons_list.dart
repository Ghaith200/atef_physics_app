import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/models/lesson_model.dart';
import 'package:atef_physics/core/utils/app_snack_bar.dart';
import 'package:atef_physics/features/courses/presentation/course_lessons/cubit/course_lessons_cubit.dart';
import 'package:atef_physics/features/courses/presentation/course_lessons/presentation/screens/course_add_lesson.dart';
import 'package:atef_physics/features/vedio/screens/vedio_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
          successAll: (models) => lesson = models,
          add: (models) => lesson.add(models),
          remove: (model) =>
              AppSnackBar.showSnackBar(context, "${model.name} \n removed"),
          update: (model) {
            AppSnackBar.showSnackBar(context, "${model.name} Updated");
            final e = lesson.indexWhere((e) => e.id == model.id);
            lesson[e] = model;
          },
        );
      },
      builder: (context, state) {
        // state.whenOrNull(
        //   successAll: (models) => lesson = models,
        //   add: (models) => lesson.add(models),
        //   remove: (model) => lesson.remove(model),
        //   update: (model) {
        //     final e = lesson.indexWhere((e) => e.id == model.id);
        //     lesson[e] = model;
        //   },
        // );
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
                      return ListTile(
                        onTap: () {
                          context.pushNamed(VedioScreen.id,
                              extra: {'lesson': lesson[index]});
                        },
                        title: Text(lesson[index].name),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () => context
                                        .pushNamed(CourseAddLesson.id, extra: {
                                      "course": widget.course,
                                      "lesson": lesson[index],
                                    }),
                                icon: Icon(Icons.edit)),
                            const Icon(Icons.play_circle_outline_rounded),
                          ],
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 5),
                      );
                    },
                  ),
            load: () => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }
}
