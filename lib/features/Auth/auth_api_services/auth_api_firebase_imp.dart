import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:atef_physics/core/constants/firebase_strings.dart';
import 'package:atef_physics/core/network/api_error_handler.dart';
import 'package:atef_physics/core/network/api_result.dart';
import 'package:atef_physics/core/utils/user_type_enum.dart';
import 'package:atef_physics/features/Auth/auth_api_services/auth_api_services.dart';
import 'package:atef_physics/core/models/user_model.dart';

class AuthApiFirebaseImp implements AuthApiServices {
  @override
  Future<bool> isSessionValid() {
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<UserModel>> login(
      {required String mail, required String pass}) async {
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: mail.trim(),
      password: pass.trim(),
    );

    final user = userCredential.user;
    if (user == null) {
      return ApiResult.failure(ApiErrorHandler(
        statusCode: 404,
        statusMessage: "User not found",
        success: false,
      ));
    }

    final data = await FirebaseFirestore.instance
        .collection(FirebaseStrings.userCollection)
        .doc(user.uid)
        .get();

    return ApiResult.success(UserModel(
      uid: user.uid,
      name: data.data()![FirebaseStrings.name],
      phoneNumber: data.data()![FirebaseStrings.phoneNumber],
      email: user.email!,
      fcmToken: data.data()![FirebaseStrings.fcmToken],
      userType:
          UserTypeEnum.values.byName(data.data()![FirebaseStrings.userType]),
    ));
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<ApiResult<UserModel>> regester({
    required String mail, //
    required String pass, //
    required String name, //
    required String phoneNumber,
    required String fcmToken,
  }) async {
    final UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: mail.trim(), password: pass.trim());

    if (user.user == null) {
      ApiErrorHandler error = ApiErrorHandler(
          statusCode: 500, statusMessage: "NO User", success: false);
      return ApiResult.failure(error);
    }

    await FirebaseFirestore.instance
        .collection(FirebaseStrings.userCollection)
        .doc(user.user!.uid)
        .set({
      FirebaseStrings.name: name,
      FirebaseStrings.phoneNumber: phoneNumber,
      FirebaseStrings.fcmToken: fcmToken,
      FirebaseStrings.userType: UserTypeEnum.user.name,
    });

    return ApiResult.success(UserModel(
      uid: user.user!.uid,
      name: name,
      phoneNumber: phoneNumber,
      email: mail,
      fcmToken: fcmToken,
      userType: UserTypeEnum.user,
    ));
  }

  @override
  Future<ApiResult<UserModel>> update({
    String? mail,
    String? pass,
    String? name,
    String? phoneNumber,
    String? fcmToken,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        ApiErrorHandler error = ApiErrorHandler(
            statusCode: 401,
            statusMessage: "User not logged in",
            success: false);
        return ApiResult.failure(error);
      }

      // Update email if provided
      if (mail != null && mail.isNotEmpty && mail != user.email) {
        await user.updateEmail(mail.trim());
      }

      // Update password if provided
      if (pass != null && pass.isNotEmpty) {
        await user.updatePassword(pass.trim());
      }

      // Prepare data to update in Firestore
      Map<String, dynamic> updateData = {};

      if (name != null && name.isNotEmpty) {
        updateData[FirebaseStrings.name] = name;
      }
      if (phoneNumber != null && phoneNumber.isNotEmpty) {
        updateData[FirebaseStrings.phoneNumber] = phoneNumber;
      }
      if (fcmToken != null && fcmToken.isNotEmpty) {
        updateData[FirebaseStrings.fcmToken] = fcmToken;
      }

      // Update Firestore document
      if (updateData.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection(FirebaseStrings.userCollection)
            .doc(user.uid)
            .update(updateData);
      }

      // Fetch updated user data
      final updatedDoc = await FirebaseFirestore.instance
          .collection(FirebaseStrings.userCollection)
          .doc(user.uid)
          .get();

      if (!updatedDoc.exists) {
        ApiErrorHandler error = ApiErrorHandler(
            statusCode: 404,
            statusMessage: "User data not found",
            success: false);
        return ApiResult.failure(error);
      }

      // Return updated user model
      return ApiResult.success(UserModel(
        uid: user.uid,
        name: updatedDoc[FirebaseStrings.name],
        phoneNumber: updatedDoc[FirebaseStrings.phoneNumber],
        email: mail ?? user.email!,
        fcmToken: updatedDoc[FirebaseStrings.fcmToken],
        userType: UserTypeEnum.user, // Assuming userType remains the same
      ));
    } catch (e) {
      ApiErrorHandler error = ApiErrorHandler(
          statusCode: 500, statusMessage: e.toString(), success: false);
      return ApiResult.failure(error);
    }
  }
}
