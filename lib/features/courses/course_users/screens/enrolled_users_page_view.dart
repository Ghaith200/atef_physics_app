import 'package:atef_physics/core/constants/app_text_styles.dart';
import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/models/user_model.dart';
import 'package:atef_physics/core/utils/app_snack_bar.dart';
import 'package:atef_physics/features/courses/course/cubit/course_cubit.dart';
import 'package:atef_physics/features/courses/course_users/cubit/course_users_cubit.dart';
import 'package:atef_physics/features/courses/course_users/screens/course_users_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';

class EnrolledUsersPageView extends StatefulWidget {
  final CourseModel model;
  const EnrolledUsersPageView({
    super.key,
    required this.model,
  });

  @override
  State<EnrolledUsersPageView> createState() => _EnrolledUsersPageViewState();
}

class _EnrolledUsersPageViewState extends State<EnrolledUsersPageView> {
  List<UserModel> users = [];
  @override
  void initState() {
    super.initState();
    if (users.isEmpty) {
      BlocProvider.of<CourseUsersCubit>(context).getCourseUsers(widget.model);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseUsersCubit, CourseUsersState>(
      listener: (context, state) => state.whenOrNull<void>(
        error: (error) => error.showError(context),
        successAll: (models) => users.addAll(models),
        remove: (model) {
          AppSnackBar.showSnackBar(context, "${model.name} \n Removed");
          users.removeWhere((test) => test.uid == model.uid);
          BlocProvider.of<CourseCubit>(context).setCourse(
              widget.model.copyWith(users: users.map((e) => e.uid).toList()));
        },
        add: (addedUsers, notfound, enrolled) {
          log("brfore ${users.length}");
          for (UserModel element in addedUsers) {
            final d = users.indexWhere((test) => test.uid == element.uid);
            if (d == -1) {
              users.add(element);
              BlocProvider.of<CourseCubit>(context).setCourse(widget.model
                  .copyWith(users: users.map((e) => e.uid).toList()));
            }
          }
          log("after ${users.length}");
        },
      ),
      builder: (context, state) => state.maybeWhen<Widget>(
        load: () => const Center(child: CircularProgressIndicator()),
        orElse: () => users.isEmpty
            ? Center(
                child: Text(
                  "No Users",
                  style: AppTextStyles.hevoLight20GreyW900,
                ),
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.6, // Constrain the height
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CourseUserItem(
                      user: users[index],
                      courseModel: widget.model,
                    );
                  },
                ),
              ),
      ),
    );
  }
}
