import 'package:atef_physics/core/models/lesson_model.dart';
import 'package:flutter/material.dart';

class CourseLessonsList extends StatelessWidget {
  final List< LessonModel> lessons;
  const CourseLessonsList({
    super.key,
    required this.lessons,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Ensures the ListView takes only the required space
      physics:
          const NeverScrollableScrollPhysics(), // Disable ListView's scroll

      itemCount: lessons.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {},
          title: Text(lessons[index].name),
          trailing: const Icon(Icons.play_circle_outline_rounded),
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
        );
      },
    );
  }
}
