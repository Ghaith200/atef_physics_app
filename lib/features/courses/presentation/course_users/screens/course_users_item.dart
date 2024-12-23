import 'package:atef_physics/core/models/user_model.dart';
import 'package:flutter/material.dart';

class CourseUserItem extends StatelessWidget {
  final UserModel user;
  const CourseUserItem({super.key, required this.user});

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
          onPressed: () {},
          icon: const Icon(
            Icons.delete,
            color: Colors.blue,
          )),
    );
  }
}
