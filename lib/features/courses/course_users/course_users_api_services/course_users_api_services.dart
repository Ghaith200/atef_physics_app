import 'package:atef_physics/core/constants/firebase_strings.dart';
import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/models/user_model.dart';
import 'package:atef_physics/core/network/api_error_handler.dart';
import 'package:atef_physics/core/network/api_result.dart';
import 'package:atef_physics/core/utils/user_type_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseUsersApiServices {
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
  
}
