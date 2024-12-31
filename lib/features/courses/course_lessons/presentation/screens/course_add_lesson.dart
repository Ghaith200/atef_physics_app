import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/models/lesson_model.dart';
import 'package:atef_physics/core/utils/app_snack_bar.dart';
import 'package:atef_physics/core/utils/validator_utils.dart';
import 'package:atef_physics/core/widgets/custom_appbar.dart';
import 'package:atef_physics/core/widgets/custom_button.dart';
import 'package:atef_physics/features/courses/course_lessons/cubit/course_lessons_cubit.dart';
import 'package:atef_physics/features/courses/course_lessons/presentation/widgets/custom_file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';

class CourseAddLesson extends StatefulWidget {
  static const String id = "/CourseAddLesson";
  final CourseModel courses;
  final LessonModel? lesson;
  const CourseAddLesson({
    super.key,
    required this.courses,
    this.lesson,
  });

  @override
  State<CourseAddLesson> createState() => _CourseAddLessonState();
}

class _CourseAddLessonState extends State<CourseAddLesson> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController videoController;
  late TextEditingController watchCountController;
  late LessonModel? model = widget.lesson;
  String? photo;
  File? selectedFile; // Store selected file here
  late CourseLessonsCubit cubit;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    videoController = TextEditingController();
    watchCountController = TextEditingController();
    cubit = BlocProvider.of<CourseLessonsCubit>(context);
    if (model != null) {
      titleController.text = model!.name;
      videoController.text = model!.video;
      watchCountController.text = model!.watchCount.toString();
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    videoController.dispose();
    super.dispose();
  }

  // Callback function to handle selected file
  void _onFilePicked(File? file, String? fileName, int? fileSize) {
    setState(() {
      selectedFile = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBars(
        text: model == null ? "Add Lesson" : "Update Lesson",
        backbutton: true,
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
                      validator: (value) => Validators.videoLink(value),
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
                    const SizedBox(height: 20),
                    // Pass the callback to the CustomFilePicker widget
                    CustomFilePicker(onFilePicked: _onFilePicked),
                  ],
                ),
              ),
              const Spacer(),
              BlocConsumer<CourseLessonsCubit, CourseLessonsState>(
                builder: (context, state) {
                  return state.maybeWhen<Widget>(
                    load: () => Container(
                      width: double
                          .infinity, // Make the container take the full width
                      height: 60, // Adjust height to match the button's height
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .primaryColor, // Use button's background color
                        borderRadius: BorderRadius.circular(
                            30), // Match the button's border radius
                      ),
                      child: const Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      )), // CircularProgressIndicator inside the container
                    ),
                    orElse: () => CustomButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          String data = videoController.text;
                          if (data.endsWith("/")) {
                            data = data.substring(0, data.length - 1);
                          }
                          model == null
                              ? await cubit.addLesson(
                                  course: widget.courses,
                                  name: titleController.text,
                                  video: videoController.text,
                                  file: selectedFile,
                                  watchCount:
                                      int.parse(watchCountController.text),
                                )
                              : await cubit.updateLesson(
                                  model: widget.courses,
                                  lesson: model!,
                                  name: titleController.text,
                                  video: videoController.text,
                                  file: selectedFile,
                                  watchCount:
                                      int.parse(watchCountController.text),
                                );
                          if (context.mounted && context.canPop()) {
                            context.pop();
                          }
                        }
                      },
                      boarderRadius: 30,
                      title: model == null ? "Add Lesson" : "Update Lesson",
                    ),
                  );
                },
                listener: (context, state) => state.mapOrNull(
                  error: (value) => value.error.showError(context),
                  add: (value) => AppSnackBar.showSnackBar(
                      context, "${value.models.name} \n created Successfully"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
