import 'package:atef_physics/core/models/lesson_model.dart';
import 'package:atef_physics/core/routes/app_router.dart';
import 'package:atef_physics/features/courses/presentation/course_lessons/cubit/course_lessons_cubit.dart';
import 'package:atef_physics/features/vedio/screens/vedio_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CourseLessonsList extends StatefulWidget {
  const CourseLessonsList({
    super.key,
  });

  @override
  State<CourseLessonsList> createState() => _CourseLessonsListState();
}

class _CourseLessonsListState extends State<CourseLessonsList> {
  List<LessonModel> lesson = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseLessonsCubit, CourseLessonsState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (error) => error.showError(context),
          successAll: (models) => lesson = models,
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
                      return ListTile(
                        onTap: () {
                          context.pushNamed(VedioScreen.id,
                              extra: {'lesson': lesson[index]});
                        },
                        title: Text(lesson[index].name),
                        trailing: const Icon(Icons.play_circle_outline_rounded),
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
