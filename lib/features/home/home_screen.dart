import 'package:atef_physics/core/utils/app_colors.dart';
import 'package:atef_physics/core/widgets/custom_appdrawer.dart';
import 'package:atef_physics/features/courses/widgets/course_widget.dart';
import 'package:atef_physics/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:atef_physics/core/widgets/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  static const String id = "/HomeScreen";
  final courses = [
    {
      "title": "1",
      "image": Assets.images.icon.path,
    },
    {
      "title": "2",
      "image": Assets.images.icon.path,
    },
    {
      "title": "3",
      "image": Assets.images.icon.path,
    },
    {
      "title": "4",
      "image": Assets.images.icon.path,
    },
    {
      "title": "5",
      "image": Assets.images.icon.path,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomAppdrawer(),
      appBar: CustomAppBars(
        text: "Atef Physics",
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(
              backgroundImage: AssetImage(Assets.images.icon.path),
              radius: 20.sp,
            ),
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 200.sp,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'الاضافات الاخيره',
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return CourseWidget(
                courses: courses,
                index: index,
              );
            },
          ),
        ),
      ),
    );
  }
}
