// import 'dart:io';
// import 'package:atef_physics/core/constants/firebase_strings.dart';
// import 'package:atef_physics/core/models/course_model.dart';
// import 'package:atef_physics/core/models/lesson_model.dart';
// import 'package:atef_physics/core/models/user_model.dart';
// import 'package:atef_physics/core/network/api_error_handler.dart';
// import 'package:atef_physics/core/network/api_result.dart';
// import 'package:atef_physics/core/utils/user_type_enum.dart';
// import 'package:atef_physics/features/courses/courses_api_services/courses_api_services.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class CoursesApiFirebaseImp {

//   @override
//   Future<ApiResult<CourseModel>> course(String id) async {
//     try {
//       final data = await FirebaseFirestore.instance
//           .collection(FirebaseStrings.coures)
//           .doc(id)
//           .get();

//       final CourseModel courses = CourseModel(
//         id: data.id,
//         title: data.data()![FirebaseStrings.name],
//         photo: data.data()![FirebaseStrings.photo],
//         price: 0,
//         lessons: data.data()![FirebaseStrings.lessons],
//         users: data.data()![FirebaseStrings.users],
//       );
//       return ApiResult.success(courses);
//     } catch (e) {
//       return ApiResult.failure(ApiErrorHandler(
//         statusCode: 00,
//         statusMessage: e.toString(),
//         success: false,
//       ));
//     }
//   }
// }
