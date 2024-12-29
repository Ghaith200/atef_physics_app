import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/models/lesson_model.dart';
import 'package:atef_physics/core/utils/app_colors.dart';
import 'package:atef_physics/core/utils/app_snack_bar.dart';
import 'package:atef_physics/core/utils/storage.dart';
import 'package:atef_physics/core/utils/user_type_enum.dart';
import 'package:atef_physics/core/widgets/custom_appbar.dart';
import 'package:atef_physics/features/courses/course/cubit/course_cubit.dart';
import 'package:atef_physics/features/courses/course/widgets/course_details_item_info.dart';
import 'package:atef_physics/features/courses/course_lessons/presentation/screens/course_lessons_list.dart';
import 'package:atef_physics/features/courses/course_lessons/cubit/course_lessons_cubit.dart';
import 'package:atef_physics/features/courses/course_lessons/presentation/screens/course_add_lesson.dart';
import 'package:atef_physics/features/courses/course_users/cubit/course_users_cubit.dart';
import 'package:atef_physics/features/courses/course_users/screens/course_add_user.dart';
import 'package:atef_physics/features/courses/course_users/screens/enrolled_users_page_view.dart';
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
  List<LessonModel> lessons = [];
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller =
        TabController(length: Storage.instance.isAdmin ? 2 : 1, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () =>
          BlocProvider.of<CourseCubit>(context).getCourse(widget.courses),
      child: Scaffold(
        floatingActionButton: Storage.instance.isAdmin
            ? FloatingActionButton(
                onPressed: () => controller.index == 0
                    ? context.pushNamed(CourseAddLesson.id, extra: {
                        "course": widget.courses,
                        "cubit": BlocProvider.of<CourseLessonsCubit>(context)
                      })
                    : context.pushNamed(CourseAddUser.id, extra: {
                        "model": widget.courses,
                        "cubit": BlocProvider.of<CourseUsersCubit>(context)
                      }),
                child: const Icon(Icons.add),
              )
            : null,
        appBar: CustomAppBars(
          text: widget.courses.title,
          backbutton: true,
          actions: Storage.instance.isAdmin
              ? [
                  IconButton(
                    onPressed: () => remove(),
                    icon: const Icon(Icons.delete),
                    color: AppColors.red,
                  ),
                ]
              : null,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Upper container with image and overlay
              CourseDetailsItemInfo(course: widget.courses),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DefaultTabController(
                      length: Storage.instance.isAdmin ? 2 : 1,
                      child: Column(
                        children: [
                          TabBar(
                            controller: controller,
                            tabs: [
                              Text(
                                widget.courses.lessons.length == 1
                                    ? '${widget.courses.lessons.length} Lesson'
                                    : '${widget.courses.lessons.length} Lessons',
                                style: const TextStyle(color: AppColors.blue),
                              ),
                              if (Storage.instance.isAdmin)
                                Text(
                                  '${widget.courses.users.length} Enrolled Users',
                                  style: const TextStyle(color: AppColors.blue),
                                ),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: controller,
                              children: [
                                (Storage.instance.user.userType ==
                                            UserTypeEnum.admin ||
                                        widget.courses.users.contains(
                                            Storage.instance.user.uid))
                                    ? CourseLessonsList(
                                        course: widget.courses,
                                      )
                                    : const Center(
                                        child: Text(
                                          "you Aren Not Enrolled in this Course",
                                          style:
                                              TextStyle(color: AppColors.blue),
                                        ),
                                      ),
                                if (Storage.instance.isAdmin)
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
      ),
    );
  }

  void deleteCourse() async {
    await BlocProvider.of<CourseCubit>(context)
        .removeCourses(model: widget.courses);
    if (context.mounted && context.canPop()) {
      AppSnackBar.showSnackBar(
          context, "course ${widget.courses.title} \n Removed");
      context.pop();
    }
  }

  void remove() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete"),
          content: const Text("Are you sure you want to delete this Course?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child:
                  const Text("Cancel", style: TextStyle(color: AppColors.blue)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                deleteCourse();
                Navigator.pop(context);
              },
              child:
                  const Text("Delete", style: TextStyle(color: AppColors.red)),
            ),
          ],
        );
      },
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