import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/utils/app_snack_bar.dart';
import 'package:atef_physics/core/widgets/custom_appbar.dart';
import 'package:atef_physics/core/widgets/custom_button.dart';
import 'package:atef_physics/core/widgets/custom_image_picker.dart';
import 'package:atef_physics/features/courses/course/cubit/course_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

class AddCourseScreen extends StatefulWidget {
  static const String id = "/AddCourseScreen";
  final CourseModel? model;
  const AddCourseScreen({super.key, this.model});

  @override
  State<AddCourseScreen> createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController priceController;
  String? photo;
  late CourseCubit cubit;
  late CourseModel? model = widget.model;
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    priceController = TextEditingController();
    cubit = BlocProvider.of<CourseCubit>(context);
    if (model != null) {
      titleController.text = model!.title;
      priceController.text = model!.price.toString();
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBars(
        text: model == null ? "Add Course" : "Update Course",
        backbutton: true,
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
                child: model == null
                    ? const Icon(Icons.add_a_photo)
                    : CachedNetworkImage(
                        imageUrl: model!.photo,
                        fit: BoxFit.cover,
                      ),
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
                      controller: priceController,
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
              BlocConsumer<CourseCubit, CourseState>(
                listener: (context, state) => state.mapOrNull(
                  update: (value) => AppSnackBar.showSnackBar(
                      context, "${value.model.title} \n Updated Successfully"),
                  error: (value) => value.error.showError(context),
                  add: (value) => AppSnackBar.showSnackBar(
                      context, "${value.model.title} \n created Successfully"),
                ),
                builder: (context, state) {
                  return state.maybeWhen<Widget>(
                      load: () => const CircularProgressIndicator(),
                      orElse: () => CustomButton(
                            onTap: () async {
                              if (photo == null && model == null) {
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
                              model == null
                                  ? await cubit.addCourse(
                                      title: titleController.text,
                                      price: int.parse(priceController.text),
                                      photo: photo!,
                                    )
                                  : await cubit.updateCOurse(
                                      model: model!,
                                      title: titleController.text,
                                      price: int.parse(priceController.text),
                                      photo: photo ?? model!.photo,
                                    );
                              if (context.mounted && context.canPop()) {
                                context.pop();
                              }
                            },
                            boarderRadius: 30,
                            title:
                                model == null ? "add course" : "update course",
                          ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
