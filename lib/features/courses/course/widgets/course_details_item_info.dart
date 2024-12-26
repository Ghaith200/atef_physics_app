import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/widgets/custom_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseDetailsItemInfo extends StatelessWidget {
  const CourseDetailsItemInfo({
    super.key,
    required this.course,
  });

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(course.photo),
          fit: BoxFit.cover,
          opacity: .1,
        ),
      ),
      height: 200,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomButton(
            height: 160,
            width: 140,
            boarderRadius: 10,
            onTap: () => showImageFullScreen(context, course.photo),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            image: CachedNetworkImageProvider(course.photo),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    course.title,
                    maxLines: 3,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      textAlign: TextAlign.end,
                      'ريال',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' ${course.price} ',
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Enrolled: ${course.users.length}',
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showImageFullScreen(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => GestureDetector(
        onTap: () => Navigator.of(context).pop(), // Close the dialog on tap
        child: Container(
          color: Colors.white
              .withOpacity(.1), // Background color for the full-screen view
          child: Center(
            child: InteractiveViewer(
              panEnabled: true, // Enable panning
              scaleEnabled: true, // Enable scaling
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
