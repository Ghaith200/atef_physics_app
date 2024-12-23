import 'package:flutter/material.dart';

class CoureLessonsList extends StatelessWidget {
  const CoureLessonsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Ensures the ListView takes only the required space
      physics:
          const NeverScrollableScrollPhysics(), // Disable ListView's scroll

      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {},
          title: Text('$index'),
          trailing: const Icon(Icons.play_circle_outline_rounded),
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
        );
      },
    );
  }
}
