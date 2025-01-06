import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/models/user_model.dart';
import 'package:atef_physics/core/utils/app_snack_bar.dart';
import 'package:atef_physics/features/courses/course_users/cubit/course_users_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseUserItem extends StatelessWidget {
  final UserModel user;
  final CourseModel courseModel;

  const CourseUserItem(
      {super.key, required this.user, required this.courseModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
      leading: const Icon(
        Icons.person,
        color: Colors.blue,
      ),
      title: Text(user.name),
      subtitle: Text(user.phoneNumber),
      trailing: IconButton(
          onPressed: () => AppSnackBar.showConfirmDialog(
                context: context,
                label: "Remove User ? \n${user.name}",
                fun: () =>
                    BlocProvider.of<CourseUsersCubit>(context).removeUser(
                  userId: user,
                  course: courseModel,
                ),
              ),
          icon: const Icon(
            Icons.delete,
            color: Colors.blue,
          )),
    );
  }
}
