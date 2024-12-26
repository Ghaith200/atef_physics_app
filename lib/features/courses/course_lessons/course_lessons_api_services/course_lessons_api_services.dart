import 'package:atef_physics/core/constants/firebase_strings.dart';
import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/models/lesson_model.dart';
import 'package:atef_physics/core/network/api_error_handler.dart';
import 'package:atef_physics/core/network/api_result.dart';
import 'package:atef_physics/core/utils/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseLessonsApiServices {
  Future<ApiResult<List<LessonModel>>> courseLessons(CourseModel model) async {
    try {
      List<LessonModel> lessonsModel = [];
      for (String lesson in model.lessons) {
        final lessonDoc =  FirebaseFirestore.instance
            .collection(FirebaseStrings.lessons)
            .doc(lesson);
        final data = await lessonDoc.get();
        final lessonUser = await lessonDoc
            .collection(FirebaseStrings.users)
            .doc(Storage.instance.user.uid)
            .get();

        // final userdata =data.
        lessonsModel.add(LessonModel(
          id: data.id,
          name: data.data()![FirebaseStrings.name],
          video: data.data()![FirebaseStrings.video],
          watchCount: 5,
          userWatchCount: lessonUser.exists
              ? lessonUser.data()![FirebaseStrings.watchCount]
              : 0,
        ));
      }
      return ApiResult.success(lessonsModel);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler(
          statusCode: 00, statusMessage: e.toString(), success: false));
    }
  }

  Future<ApiResult<LessonModel>> addLesson({
    required CourseModel model,
    required String name,
    required String video,
    required int watchCount,
  }) async {
    try {
      final data =
          FirebaseFirestore.instance.collection(FirebaseStrings.lessons).doc();
      data.set({
        FirebaseStrings.name: name,
        FirebaseStrings.video: video,
        FirebaseStrings.watchCount: watchCount
      });
      await FirebaseFirestore.instance
          .collection(FirebaseStrings.coures)
          .doc(model.id)
          .update({
        FirebaseStrings.lessons: FieldValue.arrayUnion([data.id])
      });
      final LessonModel lessonModel = LessonModel(
        id: data.id,
        name: name,
        video: video,
        watchCount: watchCount,
      );
      return ApiResult.success(lessonModel);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler(
          statusCode: 00, statusMessage: e.toString(), success: false));
    }
  }

  Future<ApiResult<void>> removeLesson(
      CourseModel model, String lessonId) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseStrings.coures)
          .doc(model.id)
          .update({
        FirebaseStrings.lessons: FieldValue.arrayRemove([lessonId])
      });
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler(
          statusCode: 00, statusMessage: e.toString(), success: false));
    }
  }

  Future<ApiResult<LessonModel>> updateLesson(
      {required LessonModel lesson,
      required String? name,
      required String? video,
      required int? watchCount}) async {
    try {
      final doc = FirebaseFirestore.instance
          .collection(FirebaseStrings.lessons)
          .doc(lesson.id);
      doc.update({
        FirebaseStrings.name: name ?? lesson.name,
        FirebaseStrings.video: video ?? lesson.video,
        FirebaseStrings.watchCount: watchCount ?? lesson.watchCount,
      });
      lesson =
          lesson.copyWith(name: name, video: video, watchCount: watchCount);
      return ApiResult.success(lesson);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler(
          statusCode: 00, statusMessage: e.toString(), success: false));
    }
  }
}
