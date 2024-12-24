import 'dart:io';

import 'package:atef_physics/core/constants/firebase_strings.dart';
import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/models/lesson_model.dart';
import 'package:atef_physics/core/models/user_model.dart';
import 'package:atef_physics/core/network/api_error_handler.dart';
import 'package:atef_physics/core/network/api_result.dart';
import 'package:atef_physics/core/utils/user_type_enum.dart';
import 'package:atef_physics/features/courses/courses_api_services/courses_api_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CoursesApiFirebaseImp implements CoursesApiServices {
  @override
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

  @override
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

  @override
  Future<ApiResult<Map<String, List>>> addUser(
      CourseModel model, List<String> phoneNumbers) async {
    try {
      List<UserModel> addedUsers = [];
      List<String> notfoundUSers = [], enrolledUseres = [];

      final coursedoc = FirebaseFirestore.instance
          .collection(FirebaseStrings.coures)
          .doc(model.id);
      final userInfo = await FirebaseFirestore.instance
          .collection(FirebaseStrings.users)
          .where(FirebaseStrings.phoneNumber, whereIn: phoneNumbers)
          .get();
      for (QueryDocumentSnapshot<Map<String, dynamic>> element
          in userInfo.docs) {
        final number = element.data()[FirebaseStrings.phoneNumber];
        if (!phoneNumbers.contains(number)) {
          notfoundUSers.add(number);
        } else if (model.users.contains(element.id)) {
          enrolledUseres.add(number);
        } else {
          coursedoc.update({
            FirebaseStrings.users: FieldValue.arrayUnion([element.id])
          });
          final data = await FirebaseFirestore.instance
              .collection(FirebaseStrings.users)
              .doc(element.id)
              .get();
          addedUsers.add(UserModel(
            uid: data.id,
            name: data.data()![FirebaseStrings.name],
            phoneNumber: data.data()![FirebaseStrings.phoneNumber],
            email: "",
            fcmToken: data.data()![FirebaseStrings.fcmToken],
            userType: UserTypeEnum.values
                .byName(data.data()![FirebaseStrings.userType]),
          ));
        }
      }
      return ApiResult.success({
        FirebaseStrings.addedUsers: addedUsers,
        FirebaseStrings.enrolledUsers: enrolledUseres,
        FirebaseStrings.notFoundUsers: notfoundUSers
      });
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler(
          statusCode: 00, statusMessage: e.toString(), success: false));
    }
  }

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
        price: 0,
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

  @override
  Future<ApiResult<List<LessonModel>>> courseLessons(CourseModel model) async {
    try {
      List<LessonModel> lessonsModel = [];
      for (String lesson in model.lessons) {
        final data = await FirebaseFirestore.instance
            .collection(FirebaseStrings.lessons)
            .doc(lesson)
            .get();

        lessonsModel.add(LessonModel(
          id: data.id,
          name: data.data()![FirebaseStrings.name],
          video: data.data()![FirebaseStrings.video],
          watchCount: 5,
        ));
      }
      return ApiResult.success(lessonsModel);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler(
          statusCode: 00, statusMessage: e.toString(), success: false));
    }
  }

  @override
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

  @override
  Future<ApiResult<void>> removeUser(CourseModel model, String id) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseStrings.coures)
          .doc(model.id)
          .update({
        FirebaseStrings.lessons: FieldValue.arrayRemove([id])
      });
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler(
          statusCode: 00, statusMessage: e.toString(), success: false));
    }
  }

  @override
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

  @override
  Future<ApiResult<List<UserModel>>> courseUsers(CourseModel model) async {
    try {
      List<UserModel> lessonsModel = [];
      for (var lesson in model.users) {
        final data = await FirebaseFirestore.instance
            .collection(FirebaseStrings.users)
            .doc(lesson)
            .get();
        lessonsModel.add(UserModel(
          uid: data.id,
          name: data.data()![FirebaseStrings.name],
          phoneNumber: data.data()![FirebaseStrings.phoneNumber],
          email: "",
          fcmToken: data.data()![FirebaseStrings.fcmToken],
          userType: UserTypeEnum.values
              .byName(data.data()![FirebaseStrings.userType]),
        ));
      }
      return ApiResult.success(lessonsModel);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler(
          statusCode: 00, statusMessage: e.toString(), success: false));
    }
  }

  @override
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
