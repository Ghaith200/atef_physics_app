import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/widgets/custom_appbar.dart';
import 'package:atef_physics/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class CourseDetails extends StatelessWidget {
  static const String id = '/CourseDetails';
  final CourseModel courses;
  CourseDetails({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Details'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage(Assets.images.icon.path))),
                    child: Image.asset(
                      Assets.images.icon.path,
                      width: 120,
                    )),
                const SizedBox(width: 25),
                Column(
                  children: [
                    Text(courses.title),
                    Text(courses.price.toString()),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: ListTile(
                      onTap: () {},
                      title: Text('$index'),
                      trailing: Icon(Icons.play_circle_outline_rounded),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
