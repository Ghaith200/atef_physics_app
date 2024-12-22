import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class CourseWidget extends StatelessWidget {
  final CourseModel course;
  const CourseWidget({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: GridTile(
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 15, vertical: 10),
            color: Colors.grey,
            alignment: Alignment.bottomCenter,
            child: Text(
              course.title,
              style: const TextStyle(
                height: 1,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
          child: Image.asset(Assets.images.icon.path),
        ),
      ),
    );
  }
}
