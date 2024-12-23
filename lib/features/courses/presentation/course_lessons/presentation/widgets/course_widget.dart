import 'package:atef_physics/core/constants/app_text_styles.dart';
import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/utils/app_colors.dart';
import 'package:atef_physics/core/utils/storage.dart';
import 'package:atef_physics/features/courses/presentation/course/screens/add_course_screen.dart';
import 'package:atef_physics/features/courses/presentation/course/screens/course_details.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

class CourseWidget extends StatelessWidget {
  final CourseModel course;
  const CourseWidget({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(CourseDetails.id, extra: {'courses': course});
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: GridTile(
            header: Container(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 15, vertical: 10),
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => context
                    .pushNamed(AddCourseScreen.id, extra: {"course": course}),
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(.6),
                  child: const Icon(Icons.edit),
                ),
              ),
            ),
            footer: Container(
                width: double.infinity,
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 15, vertical: 10),
                color: Colors.white.withOpacity(.6),
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      course.title,
                      style: AppTextStyles.hevoLight20WhiteBlackW700,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    course.users.contains(Storage.instance.user.uid)
                        ? const Icon(Icons.lock_open_rounded,
                            color: AppColors.blue)
                        : const Icon(Icons.lock_outline, color: AppColors.red)
                  ],
                )),
            child: CachedNetworkImage(
              imageUrl: course.photo,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
