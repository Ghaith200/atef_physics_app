import 'dart:io';

import 'package:atef_physics/core/constants/firebase_strings.dart';
import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/network/api_error_handler.dart';
import 'package:atef_physics/core/network/api_result.dart';
import 'package:atef_physics/features/courses/course_lessons/course_lessons_api_services/course_lessons_api_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CourseApiServices {
  Future<ApiResult<CourseModel>> addCourse({
    required String title,
    required String photo,
    required int price,
  }) async {
    try {
      // Reference to the courses' photo folder with a unique name
      final coursePhotoRef = FirebaseStorage.instance.ref(
          '${FirebaseStrings.coursesPhoto}/${DateTime.now().millisecondsSinceEpoch}_$title');

      // Uploading the file to Firebase Storage
      final uploadTask = await coursePhotoRef.putFile(File(photo));

      // Getting the photo URL
      final photoURL = await uploadTask.ref.getDownloadURL();

      // Creating a document in the courses collection
      final doc =
          FirebaseFirestore.instance.collection(FirebaseStrings.coures).doc();

      await doc.set({
        FirebaseStrings.name: title,
        FirebaseStrings.photo: photoURL,
        FirebaseStrings.price: price,
        FirebaseStrings.lessons: [],
        FirebaseStrings.users: [],
      });

      // Returning the successful result with the created model
      return ApiResult.success(CourseModel(
        id: doc.id,
        title: title,
        photo: photoURL,
        price: price,
        lessons: [],
        users: [],
      ));
    } catch (e) {
      // Handling and returning the error
      return ApiResult.failure(ApiErrorHandler(
        statusCode: 500, // Provide meaningful status codes
        statusMessage: e.toString(),
        success: false,
      ));
    }
  }

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
                price: doc.data()[FirebaseStrings.price],
                lessons: List<String>.from(doc
                    .data()[FirebaseStrings.lessons]
                    .map((e) => e.toString())),
                users: List<String>.from(
                    doc.data()[FirebaseStrings.users].map((e) => e.toString())),
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

  Future<ApiResult<CourseModel>> updateCourse(
      {required CourseModel model,
      String? title,
      String? photo,
      int? price}) async {
    try {
      final doc = FirebaseFirestore.instance
          .collection(FirebaseStrings.coures)
          .doc(model.id);
      await doc.update({
        FirebaseStrings.name: title ?? model.title,
        FirebaseStrings.photo: photo ?? model.photo,
        FirebaseStrings.price: price ?? model.price,
      });
      return ApiResult.success(
          model.copyWith(title: title, photo: photo, price: price));
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler(
          statusCode: 00, statusMessage: e.toString(), success: false));
    }
  }

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
        price: data.data()![FirebaseStrings.price],
        lessons: data.data()![FirebaseStrings.lessons],
        users: data.data()![FirebaseStrings.users],
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

  Future<ApiResult<CourseModel>> removeCourse(CourseModel model) async {
    try {
      for (var element in model.lessons) {
        final res = await CourseLessonsApiServices().removeLesson(
          model,
          element,
          l: true,
        );
        
        //  res.whenOrNull(
        //   failure: (error) {
        //     return ApiResult.failure(error);
        //   },
        // );
      }

      await FirebaseFirestore.instance
          .collection(FirebaseStrings.coures)
          .doc(model.id)
          .delete();
      await FirebaseStorage.instance.refFromURL(model.photo).delete();
      return ApiResult.success(model);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler(
        statusCode: 00,
        statusMessage: e.toString(),
        success: false,
      ));
    }
  }
}
