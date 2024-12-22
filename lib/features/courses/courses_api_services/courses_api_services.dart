import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/models/lesson_model.dart';
import 'package:atef_physics/core/models/user_model.dart';
import 'package:atef_physics/core/network/api_result.dart';

abstract class CoursesApiServices {
  Future<ApiResult<List<CourseModel>>> coursesList();
  Future<ApiResult<CourseModel>> course(String id);
  Future<ApiResult<CourseModel>> addCourse({
    required String title,
    required String photo,
  });

  Future<ApiResult> updateCourse({
    String? title,
    String? photo,
  });

  Future<ApiResult> addUser(CourseModel model, String userId);
  Future<ApiResult> removeUser(CourseModel model, String id);
  Future<ApiResult<List<UserModel>>> userCourses(CourseModel model);
  Future<ApiResult> addLesson(CourseModel model, String lessonId);
  Future<ApiResult> removeLesson(CourseModel model, String lessonId);
  Future<ApiResult<List<LessonModel>>> lessonCourses(CourseModel model);
}
