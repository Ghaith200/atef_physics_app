import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/widgets/custom_appbar.dart';
import 'package:atef_physics/gen/assets.gen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CourseDetails extends StatelessWidget {
  static const String id = '/CourseDetails';
  final CourseModel courses;
  CourseDetails({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.edit),
      ),
      appBar: AppBar(
        title: const Text('Course Details'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      clipBehavior: Clip.antiAlias,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: courses.photo,
                      )),
                  const SizedBox(width: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(courses.title),
                      Text('${courses.price} \$'),
                      Text('enrolled : 50'),
                    ],
                  ),
                ],
              ),
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
