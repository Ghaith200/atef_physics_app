import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/features/courses/presentation/course_lessons/presentation/screens/course_lessons_list.dart';
import 'package:flutter/material.dart';

class LessonsPageView extends StatelessWidget {
  final CourseModel courses;

  const LessonsPageView({
    super.key,
    required this.courses,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            courses.lessons.length == 1
                ? '${courses.lessons.length} Lesson'
                : '${courses.lessons.length} Lessons',
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 10),
          const CourseLessonsList(),
        ],
      ),
    );
  }
}
