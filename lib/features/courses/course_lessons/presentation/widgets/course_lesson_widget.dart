import 'package:atef_physics/core/utils/app_colors.dart';
import 'package:atef_physics/core/utils/app_snack_bar.dart';
import 'package:atef_physics/core/utils/storage.dart';
import 'package:atef_physics/core/widgets/custom_button.dart';
import 'package:atef_physics/core/widgets/custom_textfield.dart';
import 'package:atef_physics/features/courses/course_lessons/cubit/course_lessons_cubit.dart';
import 'package:atef_physics/features/courses/course_lessons/presentation/screens/course_add_lesson.dart';
import 'package:atef_physics/features/vedio/screens/vedio_screen.dart';
import 'package:flutter/material.dart';
import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/models/lesson_model.dart';
import 'package:atef_physics/core/widgets/custom_download_buutton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CourseLessonWidget extends StatefulWidget {
  const CourseLessonWidget({
    super.key,
    required this.lesson,
    required this.model,
  });

  final LessonModel lesson;
  final CourseModel model;

  @override
  State<CourseLessonWidget> createState() => _CourseLessonWidgetState();
}

class _CourseLessonWidgetState extends State<CourseLessonWidget>
    with SingleTickerProviderStateMixin {
  late LessonModel lesson = LessonModel.fromJson(widget.lesson.toJson());
  bool _isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController userNumberController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
      child: Material(
        elevation: 5, // Adds elevation to all sides
        borderRadius: BorderRadius.circular(12),
        shadowColor:
            Colors.grey.withOpacity(0.5), // Slightly transparent shadow
        child: Column(
          children: [
            GestureDetector(
              onTap: _toggleExpansion,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.vertical(
                    top: const Radius.circular(12),
                    bottom:
                        _isExpanded ? Radius.zero : const Radius.circular(12),
                  ),
                ),
                child: ListTile(
                  title: Text(
                    widget.lesson.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  subtitle: Text(
                    "${lesson.userWatchCount} / ${lesson.watchCount} ",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => context.pushNamed(
                          CourseAddLesson.id,
                          extra: {
                            "course": widget.model,
                            "lesson": lesson,
                            "cubit":
                                BlocProvider.of<CourseLessonsCubit>(context)
                          },
                        ),
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () => AppSnackBar.showConfirmDialog(
                          context: context,
                          label: "Deleter lesson \n${lesson.name}",
                          fun: () =>
                              BlocProvider.of<CourseLessonsCubit>(context)
                                  .removeLesson(
                            course: widget.model,
                            lesson: lesson,
                          ),
                        ),
                        color: AppColors.red,
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _isExpanded
                  ? Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Video section
                          ListTile(
                            onTap: () async {
                              if (lesson.userWatchCount >= lesson.watchCount &&
                                  !Storage.instance.isAdmin) {
                                AppSnackBar.showSnackBar(
                                    context, "Lesson watch count ended ");
                                return;
                              }
                              final i = lesson.userWatchCount + 1;
                              final cubit =
                                  BlocProvider.of<CourseLessonsCubit>(context);
                              await cubit.updateLessonUserWatchCount(
                                  lesson: lesson,
                                  userWatchCount: i,
                                  model: widget.model);
                              if (context.mounted) {
                                cubit.state.mapOrNull(
                                  update: (value) {
                                    if (lesson.id == value.model.id) {
                                      lesson = value.model;
                                      if (value.model.userWatchCount <=
                                              value.model.watchCount ||
                                          Storage.instance.isAdmin) {
                                        // Navigate to video screen if needed
                                        context.pushNamed(VedioScreen.id,
                                            extra: {"lesson": lesson.video});
                                      } else {
                                        AppSnackBar.showSnackBar(context,
                                            "Sorry Watch time finished");
                                      }
                                    }
                                  },
                                );
                              }
                            },
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            title: Text(
                              'Video',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.blue[800],
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.play_circle_outline_rounded,
                              ),
                            ),
                          ),

                          // Attachment section (if file exists)
                          if (lesson.file != null)
                            ListTile(
                              title: Text(
                                'Attachment',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue[800],
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              trailing: CustomDownloadBuutton(
                                downloadUrl: lesson.file!,
                                finshedDownload: (e) {},
                                subdir: widget.model.title,
                                fileName: "${lesson.name}.pdf",
                              ),
                            ),

                          // Admin-specific input field
                          if (Storage.instance.isAdmin)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 8),
                              child: CustomTextFormField(
                                textEditingController: userNumberController,
                                keyboardType: TextInputType.phone,
                                hintText: 'user number to reset watch count',
                                prefixIcon: const Icon(Icons.person),
                                label: 'User Number',
                              ),
                            ),
                          Center(
                            child: CustomButton(
                              width: 150,
                              height: 40,
                              boarderRadius: 20,
                              onTap: () {
                                final userString = userNumberController.text;
                                if (widget.model.users.contains(userString)) {
                                  BlocProvider.of<CourseLessonsCubit>(context)
                                      .updateLessonUserWatchCount(
                                          lesson: lesson,
                                          model: widget.model,
                                          // userId: userString,
                                          userWatchCount: 0);
                                }
                              },
                              child: Text("reset watch count"),
                            ),
                          )
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
