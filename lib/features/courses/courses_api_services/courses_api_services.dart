import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/models/lesson_model.dart';
import 'package:atef_physics/core/models/user_model.dart';
import 'package:atef_physics/core/network/api_result.dart';

abstract class CoursesApiServices {
  Future<ApiResult<List<CourseModel>>> coursesList();
  Future<ApiResult<CourseModel>> course(String id);
  Future<ApiResult<CourseModel>> addCourse(
      {required String title, required String photo, required int price});
  Future<ApiResult<CourseModel>> updateCourse(
      {required CourseModel model, String? title, String? photo, int? price});
  Future<ApiResult<void>> addUser(CourseModel model, String userId);
  Future<ApiResult<void>> removeUser(CourseModel model, String id);
  Future<ApiResult<List<UserModel>>> courseUsers(CourseModel model);
  Future<ApiResult<LessonModel>> addLesson(
      {required CourseModel model,
      required String name,
      required String video});
  Future<ApiResult<void>> removeLesson(CourseModel model, String lessonId);
  Future<ApiResult<List<LessonModel>>> courseLessons(CourseModel model);
}
