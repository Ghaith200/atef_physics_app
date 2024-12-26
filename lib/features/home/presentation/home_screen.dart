import 'package:atef_physics/core/utils/app_colors.dart';
import 'package:atef_physics/core/utils/storage.dart';
import 'package:atef_physics/core/widgets/custom_appdrawer.dart';
import 'package:atef_physics/features/courses/course/screens/add_course_screen.dart';
import 'package:atef_physics/features/courses/course/cubit/course_cubit.dart';
import 'package:atef_physics/features/courses/course/widgets/course_list_widget.dart';
import 'package:atef_physics/features/header/presentation/cubit/header_cubit.dart';
import 'package:atef_physics/features/header/presentation/widgets/header_list.dart';
import 'package:atef_physics/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:atef_physics/core/widgets/custom_appbar.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String id = "/HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CourseCubit courseCubit = BlocProvider.of<CourseCubit>(context);
  late HeaderCubit headerCubit = BlocProvider.of<HeaderCubit>(context);

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      onRefresh: () async {
        courseCubit.getCourses();
        headerCubit.getHeaders();
      },
      child: Scaffold(
        floatingActionButton: Storage.instance.isAdmin
            ? FloatingActionButton(
                onPressed: () {
                  context.pushNamed(AddCourseScreen.id,
                      extra: {"cubit": courseCubit});
                },
                child: const Icon(Icons.add))
            : null,
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
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    HeaderList(),
                    SizedBox(height: 20),
                    Text(
                      'الاضافات الاخيره',
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              SliverFillRemaining(
                child: CourseListWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
