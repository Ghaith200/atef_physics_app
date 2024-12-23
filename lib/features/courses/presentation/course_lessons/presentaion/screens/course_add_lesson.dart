import 'package:atef_physics/core/utils/app_colors.dart';
import 'package:atef_physics/core/utils/app_snack_bar.dart';
import 'package:atef_physics/core/widgets/custom_image_picker.dart';
import 'package:atef_physics/features/courses/presentation/course/cubit/course_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseAddLesson extends StatefulWidget {
  static const String id = "/CourseAddLesson";

  const CourseAddLesson({super.key});

  @override
  State<CourseAddLesson> createState() => _CourseAddLessonState();
}

class _CourseAddLessonState extends State<CourseAddLesson> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController videoController;
  late TextEditingController watchCountController;

  String? photo;
  late CourseCubit cubit;
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    videoController = TextEditingController();
    watchCountController = TextEditingController();
    cubit = BlocProvider.of<CourseCubit>(context);
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
              CustomImagePicker(
                ontap: (image) {
                  setState(() {
                    photo = image.path;
                  });
                },
                boxDecoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.add_a_photo),
              ),
              const SizedBox(height: 20),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Course Name',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Course name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: videoController,
                      decoration: const InputDecoration(
                        labelText: 'Course Price',
                        suffixText: 'EGP',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Course price is required';
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
              Container(
                width: 327,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextButton(
                  onPressed: () {
                    if (photo == null) {
                      AppSnackBar.showSnackBar(
                        context,
                        "Please add a photo",
                      );
                      return;
                    }
                    if (!formKey.currentState!.validate()) {
                      // Process form data here
                      return;
                    }

                    cubit.addCourse(
                      title: titleController.text,
                      price: int.parse(videoController.text),
                      photo: photo!,
                    );
                  },
                  child: const Text(
                    'Add Course',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
