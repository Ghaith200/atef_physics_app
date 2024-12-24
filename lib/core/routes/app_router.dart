import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/models/lesson_model.dart';
import 'package:atef_physics/features/courses/course/screens/add_course_screen.dart';
import 'package:atef_physics/features/courses/course/screens/course_details.dart';
import 'package:atef_physics/features/courses/course/cubit/course_cubit.dart';
import 'package:atef_physics/features/courses/course_lessons/cubit/course_lessons_cubit.dart';
import 'package:atef_physics/features/courses/course_lessons/presentation/screens/course_add_lesson.dart';
import 'package:atef_physics/features/courses/course_users/cubit/course_users_cubit.dart';
import 'package:atef_physics/features/courses/course_users/screens/course_add_user.dart';
import 'package:atef_physics/features/header/presentation/cubit/header_cubit.dart';
import 'package:atef_physics/features/header/presentation/widgets/add_header_screen.dart';
import 'package:atef_physics/features/onboarding/widgets/terms_and_conditions.dart';
import 'package:atef_physics/features/vedio/screens/vedio_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:atef_physics/core/utils/storage.dart';
import 'package:atef_physics/features/backdoor/Back_door_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//Screens
import 'package:atef_physics/features/Auth/presentation/screens/login_screen.dart';
import 'package:atef_physics/features/onboarding/onboarding_screen.dart';
import 'package:atef_physics/features/profile/screens/profile_screen.dart';
import 'package:atef_physics/features/Auth/presentation/screens/sign_up_screen.dart';
import 'package:atef_physics/features/home/presentation/home_screen.dart';
//cubits
import 'package:atef_physics/features/Auth/presentation/cubit/auth_cubit.dart';

abstract class AppRouter {
  static String get intialRoute {
    if (!BackDoorServices.status) {
      return HomeScreen.id;
    }

    if (Storage.instance.isFirstTime) {
      return OnboardingScreen.id;
    }

    if (Storage.instance.isAuth) {
      return HomeScreen.id;
    }
    return LoginScreen.id;
  }

  static GoRouter goRouter = GoRouter(
    initialLocation: intialRoute,
    routes: [
      GoRoute(
        path: OnboardingScreen.id,
        name: OnboardingScreen.id,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: SignUpScreen.id,
        name: SignUpScreen.id,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const SignUpScreen(),
        ),
      ),
      GoRoute(
        path: LoginScreen.id,
        name: LoginScreen.id,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: HomeScreen.id,
        name: HomeScreen.id,
        builder: (context, state) => MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => CourseCubit(),
          ),
          BlocProvider(
            create: (context) => HeaderCubit(),
          )
        ], child: const HomeScreen()),
      ),
      GoRoute(
        path: ProfileScreen.id,
        name: ProfileScreen.id,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
          path: TermsAndConditionsPage.id,
          name: TermsAndConditionsPage.id,
          builder: (context, state) => const TermsAndConditionsPage()),
      GoRoute(
          path: AddCourseScreen.id,
          name: AddCourseScreen.id,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>? ?? {};
            final CourseModel? course = extra['course'] as CourseModel?;
            final CourseCubit? cubit = extra['cubit'];
            return BlocProvider.value(
              // create: (context) => CourseCubit(),
              value: cubit ?? CourseCubit(),
              child: AddCourseScreen(
                model: course,
              ),
            );
          }),
      GoRoute(
        path: CourseDetails.id,
        name: CourseDetails.id,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final courses = extra['courses'] as CourseModel;
          final CourseCubit? cubit = extra['cubit'];

          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => CourseLessonsCubit(),
              ),
              BlocProvider(
                create: (context) => CourseUsersCubit(),
              ),
              BlocProvider.value(
                value: cubit ?? CourseCubit(),
                // create: (context) => CourseUsersCubit(),
              ),
            ],
            child: CourseDetails(
              courses: courses,
            ),
          );
        },
      ),
      GoRoute(
        path: CourseAddLesson.id,
        name: CourseAddLesson.id,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final CourseLessonsCubit? cubit = extra["cubit"];
          final course = extra['course'] as CourseModel;
          final LessonModel? lessson = extra['lesson'];
          return BlocProvider.value(
            value: cubit ?? CourseLessonsCubit(),
            child: CourseAddLesson(
              courses: course,
              lesson: lessson,
            ),
          );
        },
      ),
      GoRoute(
        path: VedioScreen.id,
        name: VedioScreen.id,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final lesson = extra['lesson'] as LessonModel;
          return VedioScreen(lesson: lesson.video);
        },
      ),
      GoRoute(
        path: CourseAddUser.id,
        name: CourseAddUser.id,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final CourseModel model = extra['model'];
          final CourseUsersCubit? cubit = extra['cubit'];

          return BlocProvider.value(
            value: cubit ?? CourseUsersCubit(),
            // create: (context) => SubjectBloc(),
            child: CourseAddUser(course: model),
          );
        },
      ),
      GoRoute(
        path: AddHeaderScreen.id,
        name: AddHeaderScreen.id,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final HeaderCubit? cubit = extra['cubit'];

          return BlocProvider.value(
            value: cubit ?? HeaderCubit(),
            // create: (context) => SubjectBloc(),
            child: AddHeaderScreen(),
          );
        },
      ),
    ],
  );
}
