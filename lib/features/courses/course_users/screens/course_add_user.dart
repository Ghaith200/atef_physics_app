import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/utils/app_colors.dart';
import 'package:atef_physics/core/utils/validator_utils.dart';
import 'package:atef_physics/core/widgets/custom_appbar.dart';
import 'package:atef_physics/core/widgets/custom_button.dart';
import 'package:atef_physics/features/courses/course_users/cubit/course_users_cubit.dart';
import 'package:atef_physics/features/courses/course_users/screens/enrolled_users_tabbar.dart';
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
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Form(
          key: formKey,
          child: Container(
            decoration: BoxDecoration(color: AppColors.grey.withOpacity(.5)),
            child: TextFormField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'[\d\n]')), // Allow digits and newline
              ],
              validator: (value) => Validators.multiPhoneNumber(value),
            ),
          ),
        ),
        // const SizedBox(height: 10),
        BlocConsumer<CourseUsersCubit, CourseUsersState>(
          builder: (context, state) {
            return state.maybeWhen<Widget>(
              load: () => const CircularProgressIndicator(),
              add: (addedUsers, notfound, enrolled) => Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: EnrolledUsersTabbar(
                          model: widget.course,
                          addedUsers: addedUsers,
                          enrolledUsers: enrolled,
                          notFoundUsers: notfound),
                    ),
                    CustomButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          phoneNumbers = phoneController.text.split("\n");

                          await cubit.addUsers(
                            model: widget.course,
                            phoneNumbers: phoneNumbers,
                          );
                        }
                      },
                      boarderRadius: 30,
                      title: "Add User",
                    ),
                  ],
                ),
              ),
              orElse: () => CustomButton(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    phoneNumbers = phoneController.text.split("\n");

                    await cubit.addUsers(
                      model: widget.course,
                      phoneNumbers: phoneNumbers,
                    );
                    // if (context.mounted && context.canPop()) {
                    //   context.pop();
                    // }
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
