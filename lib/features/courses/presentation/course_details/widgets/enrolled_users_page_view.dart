import 'package:atef_physics/features/courses/presentation/course_details/widgets/enrolled_users_list.dart';
import 'package:flutter/material.dart';

class EnrolledUsersPageView extends StatelessWidget {
  const EnrolledUsersPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enrolled Users',
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: 10),
          // Example user list
          EnrolledUsersList()
        ],
      ),
    );
  }
}
