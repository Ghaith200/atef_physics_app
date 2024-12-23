import 'package:flutter/material.dart';

class EnrolledUsersList extends StatelessWidget {
  const EnrolledUsersList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6, // Constrain the height
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
            leading: const Icon(
              Icons.person,
              color: Colors.blue,
            ),
            title: Text('User ${index + 1}'),
            trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete,
                  color: Colors.blue,
                )),
          );
        },
      ),
    );
  }
}
