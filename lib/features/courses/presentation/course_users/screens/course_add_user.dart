import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/utils/app_colors.dart';
import 'package:atef_physics/core/widgets/custom_appbar.dart';
import 'package:atef_physics/core/widgets/custom_button.dart';
import 'package:atef_physics/features/courses/presentation/course_users/cubit/course_users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseAddUser extends StatefulWidget {
  final CourseModel course;
  const CourseAddUser({super.key, required this.course});
  static const String id = "/CourseAddUser";

  @override
  State<CourseAddUser> createState() => _CourseAddUserState();
}

class _CourseAddUserState extends State<CourseAddUser> {
  late CourseUsersCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<CourseUsersCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBars(
        text: "Add User",
        backbutton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: CourseUserForm(course: widget.course),
      ),
    );
  }
}

class CourseUserForm extends StatefulWidget {
  final CourseModel course;
  const CourseUserForm({super.key, required this.course});

  @override
  State<CourseUserForm> createState() => _CourseUserFormState();
}

class _CourseUserFormState extends State<CourseUserForm> {
  late TextEditingController phoneController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late CourseUsersCubit cubit;
  List<String> phoneNumbers = [];

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<CourseUsersCubit>(context);
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    decoration:
                        BoxDecoration(color: AppColors.grey.withOpacity(.5)),
                    child: TextFormField(
                      maxLines: 20,
                      keyboardType: TextInputType.multiline,
                      controller: phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Phone Number is required';
                        }
                        List<int?> p = phoneController.text
                            .split("\n")
                            .map((e) => int.tryParse(e))
                            .toList();
                        if (p.contains(null)) {
                          return 'Enter a valid number';
                        } else {
                          phoneNumbers = phoneController.text.split("\n");
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        BlocConsumer<CourseUsersCubit, CourseUsersState>(
          builder: (context, state) {
            return state.maybeWhen<Widget>(
              load: () => const CircularProgressIndicator(),
              orElse: () => CustomButton(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    cubit.addUsers(
                      model: widget.course,
                      phoneNumbers: phoneNumbers,
                    );
                  }
                },
                boarderRadius: 30,
                title: "Add User",
              ),
            );
          },
          listener: (context, state) => state.mapOrNull(
            error: (value) => value.error.showError(context),
          ),
        ),
      ],
    );
  }
}
