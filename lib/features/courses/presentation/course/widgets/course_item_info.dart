import 'package:atef_physics/core/models/course_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CourseItemInfo extends StatelessWidget {
  const CourseItemInfo({
    super.key,
    required this.course,
  });

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        CachedNetworkImage(
          imageUrl: course.photo,
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
                  imageUrl: course.photo,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text(
                        'ريال',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight
                              .bold, // Example of adding additional styling
                        ),
                      ),
                      Text(
                        ' ${course.price} ',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight
                              .bold, // Example of adding additional styling
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Enrolled: ${course.users.length}',
                    style: const TextStyle(
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
    );
  }
}
