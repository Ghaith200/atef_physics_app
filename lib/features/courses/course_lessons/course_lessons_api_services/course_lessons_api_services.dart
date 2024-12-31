import 'dart:io';

import 'package:atef_physics/core/constants/firebase_strings.dart';
import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/models/lesson_model.dart';
import 'package:atef_physics/core/network/api_error_handler.dart';
import 'package:atef_physics/core/network/api_result.dart';
import 'package:atef_physics/core/utils/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CourseLessonsApiServices {
  Future<ApiResult<List<LessonModel>>> courseLessons(CourseModel model) async {
    try {
      final lessonDoc = await FirebaseFirestore.instance
          .collection(FirebaseStrings.coures)
          .doc(model.id)
          .collection(FirebaseStrings.lessons)
          .get();

      List<LessonModel> data = List.empty(growable: true);

      for (var e in lessonDoc.docs) {
        final lessonUserData = await FirebaseFirestore.instance
            .collection(FirebaseStrings.coures)
            .doc(model.id)
            .collection(FirebaseStrings.lessons)
            .doc(e.id)
            .collection(FirebaseStrings.users)
            .doc(Storage.instance.user.uid)
            .get();

        data.add(LessonModel.fromJson(
            {"id": e.id, ...e.data(), ...lessonUserData.data() ?? {}}));
      }
      return ApiResult.success(data);
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
    String? file,
  }) async {
    try {
      String? lessonFileURL;
      if (file != null) {
        final fille = File(file);
        final lessonFile = FirebaseStorage.instance.ref(
            '${FirebaseStrings.lessonFile}/${model.title}-${model.id}/${DateTime.now().millisecondsSinceEpoch}_$name.pdf');

        await lessonFile.putFile(fille);
        lessonFileURL = await lessonFile.getDownloadURL();
      }

      final data = FirebaseFirestore.instance
          .collection(FirebaseStrings.coures)
          .doc(model.id)
          .collection(FirebaseStrings.lessons)
          .doc();

      data.set({
        FirebaseStrings.name: name,
        FirebaseStrings.video: video,
        FirebaseStrings.watchCount: watchCount,
        FirebaseStrings.file: lessonFileURL,
      });

      final LessonModel lessonModel = LessonModel(
        id: data.id,
        name: name,
        video: video,
        watchCount: watchCount,
        file: lessonFileURL,
      );
      return ApiResult.success(lessonModel);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler(
        statusCode: 00,
        statusMessage: e.toString(),
        success: false,
      ));
    }
  }

  Future<ApiResult<void>> removeLesson(
    CourseModel model,
    LessonModel lesson,
  ) async {
    try {
      if (lesson.file != null) {
        await FirebaseStorage.instance.refFromURL(lesson.file!).delete();
      }

      await FirebaseFirestore.instance
          .collection(FirebaseStrings.coures)
          .doc(model.id)
          .collection(FirebaseStrings.lessons)
          .doc(lesson.id)
          .delete();
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler(
        statusCode: 00,
        statusMessage: e.toString(),
        success: false,
      ));
    }
  }

  Future<ApiResult<LessonModel>> updateLesson(
      {required LessonModel lesson,
      required CourseModel model,
      required String? name,
      required String? video,
      required int? watchCount,
      required String? file}) async {
    try {
      if (file != null) {
        if (lesson.file != null) {
          await FirebaseStorage.instance.refFromURL(lesson.file!).delete();
        }
        final lessonFile = FirebaseStorage.instance.ref(
            '${FirebaseStrings.lessonFile}/${model.title}-${model.id}/${DateTime.now().millisecondsSinceEpoch}_$name');
        await lessonFile.putFile(File(file));
        lesson = lesson.copyWith(file: await lessonFile.getDownloadURL());
      }
      final doc = FirebaseFirestore.instance
          .collection(FirebaseStrings.coures)
          .doc(model.id)
          .collection(FirebaseStrings.lessons)
          .doc(lesson.id);
      await doc.update({
        FirebaseStrings.name: name ?? lesson.name,
        FirebaseStrings.video: video ?? lesson.video,
        FirebaseStrings.watchCount: watchCount ?? lesson.watchCount,
        FirebaseStrings.file: lesson.file,
      });

      lesson =
          lesson.copyWith(name: name, video: video, watchCount: watchCount);
      return ApiResult.success(lesson);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler(
          statusCode: 00, statusMessage: e.toString(), success: false));
    }
  }

  Future<ApiResult<LessonModel>> updateLessonUserWatchCount(
      {required LessonModel lesson,
      required CourseModel model,
      required int? userWatchCount}) async {
    try {
      final doc = FirebaseFirestore.instance
          .collection(FirebaseStrings.coures)
          .doc(model.id)
          .collection(FirebaseStrings.lessons)
          .doc(lesson.id);

      if (userWatchCount == 1) {
        await doc
            .collection(FirebaseStrings.users)
            .doc(Storage.instance.user.uid)
            .set({FirebaseStrings.userWatchCount: userWatchCount});
      } else {
        await doc
            .collection(FirebaseStrings.users)
            .doc(Storage.instance.user.uid)
            .update({FirebaseStrings.userWatchCount: userWatchCount});
      }
      lesson = lesson.copyWith(userWatchCount: userWatchCount);
      return ApiResult.success(lesson);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler(
          statusCode: 00, statusMessage: e.toString(), success: false));
    }
  }

  Future<ApiResult<LessonModel>> getLessons(LessonModel model) async {
    try {
      final data = await FirebaseFirestore.instance
          .collection(FirebaseStrings.coures)
          .doc(model.id)
          .collection(FirebaseStrings.lessons)
          .doc(model.id)
          .get();
      return ApiResult.success(LessonModel.fromJson(data.data()!));
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler(
          statusCode: 00, statusMessage: e.toString(), success: false));
    }
  }
}
