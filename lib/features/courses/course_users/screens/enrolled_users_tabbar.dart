import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/models/user_model.dart';
import 'package:atef_physics/features/courses/course_users/screens/course_users_item.dart';
import 'package:flutter/material.dart';

class EnrolledUsersTabbar extends StatelessWidget {
  final List<UserModel> addedUsers;
  final List<String> notFoundUsers, enrolledUsers;
  final CourseModel model;
  const EnrolledUsersTabbar({
    super.key,
    required this.model,
    required this.addedUsers,
    required this.enrolledUsers,
    required this.notFoundUsers,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: "${addedUsers.length} Added Users"),
              Tab(text: "${enrolledUsers.length} Enrolled Users"),
              Tab(text: "${notFoundUsers.length}Not Found Users"),
            ],
          ),
          TabBarView(
            children: [
              // Tab for Added Users
              ListView.builder(
                itemCount: addedUsers.length,
                itemBuilder: (context, index) {
                  final user = addedUsers[index];
                  return CourseUserItem(user: user, courseModel: model);
                },
              ),
              // Tab for Enrolled Users
              ListView.builder(
                itemCount: enrolledUsers.length,
                itemBuilder: (context, index) {
                  final user = addedUsers[index];
                  return CourseUserItem(user: user, courseModel: model);
                },
              ),
              // Tab for Not Found Users
              ListView.builder(
                itemCount: notFoundUsers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(notFoundUsers[index]),
                    leading: const Icon(Icons.error, color: Colors.red),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
