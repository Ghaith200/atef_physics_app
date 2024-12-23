import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/models/lesson_model.dart';
import 'package:atef_physics/core/widgets/custom_appbar.dart';
import 'package:atef_physics/features/courses/presentation/course/widgets/course_item_info.dart';
import 'package:atef_physics/features/courses/presentation/course_lessons/presentation/screens/course_lessons_list.dart';
import 'package:atef_physics/features/courses/presentation/course_lessons/cubit/course_lessons_cubit.dart';
import 'package:atef_physics/features/courses/presentation/course_lessons/presentation/screens/course_add_lesson.dart';
import 'package:atef_physics/features/courses/presentation/course_users/screens/enrolled_users_page_view.dart';
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

class _CourseDetailsState extends State<CourseDetails>
    with TickerProviderStateMixin {
  late CourseLessonsCubit courseCubit;
  List<LessonModel> lessons = [];
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);

    courseCubit = BlocProvider.of<CourseLessonsCubit>(context);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.index == 0
            ? context.pushNamed(CourseAddLesson.id,
                extra: {"course": widget.courses})
            : context.pushNamed(""),
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
            CourseItemInfo(course: widget.courses),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(
                          controller: controller,
                          tabs: [
                            Text(
                              widget.courses.lessons.length == 1
                                  ? '${widget.courses.lessons.length} Lesson'
                                  : '${widget.courses.lessons.length} Lessons',
                              style: const TextStyle(color: Colors.black),
                            ),
                            const Text(
                              'Enrolled Users',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: controller,
                            children: [
                              CourseLessonsList(
                                course: widget.courses,
                              ),
                              EnrolledUsersPageView(model: widget.courses),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
// PageView(
//                   controller: controller,
//                   children: [
//                     // First page with lessons
//                     LessonsPageView(courses: widget.courses),
//                     // Second page with users

//                     BlocProvider(
//                       create: (context) => CourseUsersCubit(),
//                       child: EnrolledUsersPageView(model: widget.courses),
//                     ),
//                   ],
//                 ),