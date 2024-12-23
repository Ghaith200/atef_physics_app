import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/models/user_model.dart';
import 'package:atef_physics/features/courses/presentation/course_users/cubit/course_users_cubit.dart';
import 'package:atef_physics/features/courses/presentation/course_users/screens/course_users_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    BlocProvider.of<CourseUsersCubit>(context).getCourseUsers(widget.model);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enrolled Users',
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 10),
          // Example user list
          // EnrolledUsersList()
          BlocConsumer<CourseUsersCubit, CourseUsersState>(
            listener: (context, state) => state.whenOrNull(
              error: (error) => error.showError(context),
              successAll: (models) => users = models,
            ),
            builder: (context, state) => state.maybeWhen<Widget>(
              load: () => const Center(child: CircularProgressIndicator()),
              orElse: () => SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.6, // Constrain the height
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CourseUserItem(user: users[index]);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
