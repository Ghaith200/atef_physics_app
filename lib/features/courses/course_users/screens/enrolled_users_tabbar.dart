import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/models/user_model.dart';
import 'package:atef_physics/features/courses/course_users/screens/course_users_item.dart';
import 'package:flutter/material.dart';

class EnrolledUsersTabbar extends StatelessWidget {
  final List<UserModel> addedUsers, enrolledUsers;
  final List<String> notFoundUsers;
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
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            tabs: [
              Tab(text: "${addedUsers.length} Added Users"),
              Tab(text: "${enrolledUsers.length} Enrolled Users"),
              Tab(text: "${notFoundUsers.length} Not Found Users"),
            ],
          ),
          Expanded(
            // height: AppScreenUtils.h,
            child: TabBarView(
              children: [
                // Tab for Added Users
                ListView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: addedUsers.length,
                  itemBuilder: (context, index) {
                    final user = addedUsers[index];
                    return CourseUserItem(user: user, courseModel: model);
                  },
                ),
                // Tab for Enrolled Users
                ListView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: enrolledUsers.length,
                  itemBuilder: (context, index) {
                                        final user = enrolledUsers[index];

                      return CourseUserItem(user: user, courseModel: model);
                  },
                ),
                // Tab for Not Found Users
                ListView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
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
          ),
        ],
      ),
    );
  }
}
