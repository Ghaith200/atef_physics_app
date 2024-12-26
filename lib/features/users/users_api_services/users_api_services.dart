import 'package:atef_physics/core/constants/firebase_strings.dart';
import 'package:atef_physics/core/models/user_model.dart';
import 'package:atef_physics/core/network/api_error_handler.dart';
import 'package:atef_physics/core/network/api_result.dart';
import 'package:atef_physics/core/utils/storage.dart';
import 'package:atef_physics/core/utils/user_type_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersApiServices {
  Future<ApiResult<List<UserModel>>> getUsers() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection(FirebaseStrings.users)
          .get();
      return ApiResult.success(doc.docs.map((doc) {
        return UserModel.fromJson({"uid": doc.id, "email": "", ...doc.data()});
      }).toList());
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler(
        statusCode: 00,
        statusMessage: e.toString(),
        success: false,
      ));
    }
  }

  Future<ApiResult<UserModel>> updateUser({
    required UserModel user,
    String? name,
    String? phoneNumber,
    String? fcmToken,
    UserTypeEnum? userTypeEnum,
  }) async {
    try {
      final doc = FirebaseFirestore.instance
          .collection(FirebaseStrings.users)
          .doc(user.uid);
      await doc.update({
        FirebaseStrings.name: name ?? user.name,
        FirebaseStrings.phoneNumber: phoneNumber ?? user.phoneNumber,
        FirebaseStrings.fcmToken: fcmToken ?? user.fcmToken,
        FirebaseStrings.userType:
            userTypeEnum != null ? userTypeEnum.name : user.userType.name,
      });
      user = user.copyWith(
          name: name,
          phoneNumber: phoneNumber,
          fcmToken: fcmToken,
          userType: userTypeEnum);
      if (user.uid == Storage.instance.user.uid) {
        Storage.instance.user = user;
      }
      return ApiResult.success(user);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler(
        statusCode: 00,
        statusMessage: e.toString(),
        success: false,
      ));
    }
  }

  Future<ApiResult<UserModel>> removeUser({
    required UserModel user,
  }) async {
    try {
      // await FirebaseAuth.instance.currentUser?.delete();
      final doc = FirebaseFirestore.instance
          .collection(FirebaseStrings.users)
          .doc(user.uid);
      final cor = await FirebaseFirestore.instance
          .collection(FirebaseStrings.coures)
          .where(FirebaseStrings.users, whereIn: [user.uid]).get();
      for (var course in cor.docs) {
        //remove user form courses
        await course.reference.update({
          FirebaseStrings.users: FieldValue.arrayRemove([user.uid])
        });
      }
      await doc.delete();
      return ApiResult.success(user);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler(
        statusCode: 00,
        statusMessage: e.toString(),
        success: false,
      ));
    }
  }
}
