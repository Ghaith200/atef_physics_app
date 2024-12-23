import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/widgets/custom_appbar.dart';
import 'package:atef_physics/features/courses/presentation/course_details/widgets/coure_lessons_list.dart';
import 'package:atef_physics/features/courses/presentation/course_details/widgets/enrolled_users_list.dart';
import 'package:atef_physics/features/courses/presentation/course_details/widgets/enrolled_users_page_view.dart';
import 'package:atef_physics/features/courses/presentation/course_details/widgets/lessons_page_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CourseDetails extends StatelessWidget {
  static const String id = '/CourseDetails';
  final CourseModel courses;

  CourseDetails({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.edit),
      ),
      appBar: CustomAppBars(
        text: courses.title,
        backbutton: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Upper container with image and overlay
            Stack(
              children: [
                // Background image
                CachedNetworkImage(
                  imageUrl: courses.photo,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                // Semi-transparent overlay
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.9),
                        Colors.white.withOpacity(0.9),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                // Course details overlaid on the image
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Row(
                    children: [
                      // Course image
                      Container(
                        clipBehavior: Clip.antiAlias,
                        height: 160,
                        width: 140,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: courses.photo,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            courses.title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${courses.price} \$',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Enrolled: 50',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PageView(
                  children: [
                    // First page with lessons
                    LessonsPageView(courses: courses),
                    // Second page with users
                    const EnrolledUsersPageView(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
