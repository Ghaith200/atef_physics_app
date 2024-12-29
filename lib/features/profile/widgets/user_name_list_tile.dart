import 'package:flutter/material.dart';
import 'package:atef_physics/gen/assets.gen.dart';

class UserNameListTile extends StatelessWidget {
  const UserNameListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Image.asset(
          Assets.images.userName.path,
          fit: BoxFit.cover,
          width: 40,
          height: 40,
        ),
        title: const Text('Username'),
        trailing: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'user.name',
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
            ),
          ],
        ));
  }
}
