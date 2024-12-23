import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/utils/app_colors.dart';
import 'package:atef_physics/core/utils/app_snack_bar.dart';
import 'package:atef_physics/core/widgets/custom_button.dart';
import 'package:atef_physics/core/widgets/custom_image_picker.dart';
import 'package:atef_physics/features/courses/presentation/course/cubit/course_cubit.dart';
import 'package:atef_physics/features/courses/presentation/course_lessons/cubit/course_lessons_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseAddLesson extends StatefulWidget {
  static const String id = "/CourseAddLesson";
  final CourseModel courses;

  const CourseAddLesson({super.key, required this.courses});

  @override
  State<CourseAddLesson> createState() => _CourseAddLessonState();
}

class _CourseAddLessonState extends State<CourseAddLesson> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController videoController;
  late TextEditingController watchCountController;

  String? photo;
  late CourseLessonsCubit cubit;
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    videoController = TextEditingController();
    watchCountController = TextEditingController();
    cubit = BlocProvider.of<CourseLessonsCubit>(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add Lesson'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Lesson Name',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Lesson name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: videoController,
                      decoration: const InputDecoration(
                        labelText: 'Video Link',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Video Lisnk is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: watchCountController,
                      decoration: const InputDecoration(
                        labelText: 'Watch Count',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Watch Count is required';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(),
              BlocConsumer<CourseLessonsCubit, CourseLessonsState>(
                builder: (context, state) {
                  return state.maybeWhen<Widget>(
                      load: () => CircularProgressIndicator(),
                      orElse: () => CustomButton(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                // Process form data here
                                cubit.addLesson(
                                  course: widget.courses,
                                  name: titleController.text,
                                  video: videoController.text,
                                  watchCount:
                                      int.parse(watchCountController.text),
                                );
                              }
                            },
                            boarderRadius: 30,
                            title: "add Lesson",
                          ));
                },
                listener: (context, state) => state.mapOrNull(
                  error: (value) => value.error.showError(context),
                  success: (value) => AppSnackBar.showSnackBar(
                      context, "${value.models.name} \n created Successfully"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
