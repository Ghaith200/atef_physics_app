import 'package:atef_physics/core/constants/firebase_strings.dart';
import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/models/lesson_model.dart';
import 'package:atef_physics/core/models/user_model.dart';
import 'package:atef_physics/core/network/api_error_handler.dart';
import 'package:atef_physics/core/network/api_result.dart';
import 'package:atef_physics/features/courses/courses_api_services/courses_api_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CoursesApiFirebaseImp implements CoursesApiServices {
  @override
  Future<ApiResult<CourseModel>> course(String id) async {
    try {
      final data = await FirebaseFirestore.instance
          .collection(FirebaseStrings.coures)
          .doc(id)
          .get();

      final CourseModel courses = CourseModel(
        id: data.id,
        title: data.data()![FirebaseStrings.name],
        photo: data.data()![FirebaseStrings.photo],
        lessons: data.data()![FirebaseStrings.lessons],
        enrolledUsers: data.data()![FirebaseStrings.users],
      );
      return ApiResult.success(courses);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler(
        statusCode: 00,
        statusMessage: e.toString(),
        success: false,
      ));
    }
  }

  @override
  Future<ApiResult<List<CourseModel>>> coursesList() async {
    try {
      final data = await FirebaseFirestore.instance
          .collection(FirebaseStrings.coures)
          .get();

      final List<CourseModel> coursesList = data.docs
          .map((doc) => CourseModel(
                id: doc.id,
                title: doc.data()[FirebaseStrings.name],
                photo: doc.data()[FirebaseStrings.photo],
                lessons: doc.data()[FirebaseStrings.lessons],
                enrolledUsers: doc.data()[FirebaseStrings.users],
              ))
          .toList();
      return ApiResult.success(coursesList);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler(
        statusCode: 00,
        statusMessage: e.toString(),
        success: false,
      ));
    }
  }

  @override
  Future<ApiResult<CourseModel>> addCourse({
    required String title,
    required String photo,
  }) async {
    try {
      final doc =
          FirebaseFirestore.instance.collection(FirebaseStrings.coures).doc();
      await doc.set({
        FirebaseStrings.name: title,
        FirebaseStrings.photo: photo,
        FirebaseStrings.lessons: [],
        FirebaseStrings.users: []
      });
      return ApiResult.success(CourseModel(
        id: doc.id,
        title: title,
        photo: photo,
        lessons: [],
        enrolledUsers: [],
      ));
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler(
        statusCode: 00,
        statusMessage: e.toString(),
        success: false,
      ));
    }
  }

  @override
  Future<ApiResult> addLesson(CourseModel model, String lessonId) {
    // TODO: implement addLesson
    throw UnimplementedError();
  }

  @override
  Future<ApiResult> addUser(CourseModel model, String userId) {
    // TODO: implement addUser
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<List<LessonModel>>> lessonCourses(CourseModel model) {
    // TODO: implement lessonCourses
    throw UnimplementedError();
  }

  @override
  Future<ApiResult> removeLesson(CourseModel model, String lessonId) {
    // TODO: implement removeLesson
    throw UnimplementedError();
  }

  @override
  Future<ApiResult> removeUser(CourseModel model, String id) {
    // TODO: implement removeUser
    throw UnimplementedError();
  }

  @override
  Future<ApiResult> updateCourse({String? title, String? photo}) {
    // TODO: implement updateCourse
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<List<UserModel>>> userCourses(CourseModel model) {
    // TODO: implement userCourses
    throw UnimplementedError();
  }
}
