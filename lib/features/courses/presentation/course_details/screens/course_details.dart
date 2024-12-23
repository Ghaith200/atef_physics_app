import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/routes/app_router.dart';
import 'package:atef_physics/core/models/lesson_model.dart';
import 'package:atef_physics/core/widgets/custom_appbar.dart';
import 'package:atef_physics/features/courses/presentation/course/cubit/course_cubit.dart';
import 'package:atef_physics/features/courses/presentation/course_users/cubit/course_users_cubit.dart';
import 'package:atef_physics/features/courses/presentation/course_users/screens/enrolled_users_page_view.dart';
import 'package:atef_physics/features/courses/presentation/course_details/widgets/lessons_page_view.dart';
import 'package:atef_physics/features/courses/presentation/course_lessons/cubit/course_lessons_cubit.dart';
import 'package:atef_physics/features/courses/presentation/course_lessons/presentaion/screens/course_add_lesson.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CourseDetails extends StatefulWidget {
  static const String id = '/CourseDetails';
  final CourseModel courses;

  const CourseDetails({
    super.key,
    required this.courses,
  });

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  late CourseLessonsCubit courseCubit;
  List<LessonModel> lessons = [];
  @override
  void initState() {
    super.initState();

    courseCubit = BlocProvider.of<CourseLessonsCubit>(context);
    courseCubit.getCourseLessons(widget.courses);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context
              .pushNamed(CourseAddLesson.id, extra: {"course": widget.courses});
        },
        child: const Icon(Icons.edit),
      ),
      appBar: CustomAppBars(
        text: widget.courses.title,
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
                  imageUrl: widget.courses.photo,
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
                          imageUrl: widget.courses.photo,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.courses.title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${widget.courses.price} \$',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Enrolled: ${widget.courses.users.length}',
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
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PageView(
                  children: [
                    // First page with lessons
                    LessonsPageView(
                      courses: widget.courses,
                      lessons: lessons,
                    ),
                    // Second page with users
                    BlocProvider(
                      create: (context) => CourseUsersCubit(),
                      child: EnrolledUsersPageView(model: widget.courses),
                    ),
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
