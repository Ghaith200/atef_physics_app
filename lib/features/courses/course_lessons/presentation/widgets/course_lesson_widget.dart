  import 'package:atef_physics/core/utils/app_colors.dart';
  import 'package:atef_physics/features/courses/course_lessons/cubit/course_lessons_cubit.dart';
  import 'package:atef_physics/features/courses/course_lessons/presentation/screens/course_add_lesson.dart';
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
                          onPressed: () =>
                              BlocProvider.of<CourseLessonsCubit>(context)
                                  .removeLesson(
                            course: widget.model,
                            lesson: lesson,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                            ListTile(
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
                                  icon: Icon(
                                    Icons.play_circle_outline_rounded,
                                  )),
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
