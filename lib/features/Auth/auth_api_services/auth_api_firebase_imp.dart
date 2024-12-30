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
    if (!data.exists) {
      // await user.delete();
      throw "User has been banned";
    }
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
    required UserModel user,
    String? mail,
    String? pass,
    String? name,
    String? phoneNumber,
    String? fcmToken,
  }) async {
    UserModel model = user;
    model = model.copyWith(
      email: mail,
      name: name,
      phoneNumber: phoneNumber,
      fcmToken: fcmToken,
    );
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseStrings.userCollection)
          .doc(model.uid)
          .update({
        FirebaseStrings.name: model.name,
        FirebaseStrings.phoneNumber: model.phoneNumber,
        FirebaseStrings.fcmToken: model.fcmToken,
        FirebaseStrings.userType: model.userType.name,
      });
      return ApiResult.success(model);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler(
          statusCode: 00, statusMessage: e.toString(), success: false));
    }
  }
}

//  @override
//   Future<ApiResult<UserModel>> regester({
//     required String mail,
//     required String pass,
//     required String name,
//     required String phoneNumber,
//     required String fcmToken,
//   }) async {
//     try {
//       // Attempt to create a new user
//       UserCredential user =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: mail.trim(),
//         password: pass.trim(),
//       );

//       // Save user data to Firestore
//       await _saveOrUpdateUserData(
//         uid: user.user!.uid,
//         name: name,
//         phoneNumber: phoneNumber,
//         fcmToken: fcmToken,
//       );

//       // Return success result
//       return ApiResult.success(UserModel(
//         uid: user.user!.uid,
//         name: name,
//         phoneNumber: phoneNumber,
//         email: mail,
//         fcmToken: fcmToken,
//         userType: UserTypeEnum.user,
//       ));
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'email-already-in-use') {
//         // Handle case where email is already in use
//         try {
//           // Attempt to log in the user
//           UserCredential user =
//               await FirebaseAuth.instance.signInWithEmailAndPassword(
//             email: mail.trim(),
//             password: pass.trim(),
//           );

//           // Update existing user's Firestore data
//           await _saveOrUpdateUserData(
//             uid: user.user!.uid,
//             name: name,
//             phoneNumber: phoneNumber,
//             fcmToken: fcmToken,
//           );

//           // Return success result for existing user
//           return ApiResult.success(UserModel(
//             uid: user.user!.uid,
//             name: name,
//             phoneNumber: phoneNumber,
//             email: mail,
//             fcmToken: fcmToken,
//             userType: UserTypeEnum.user,
//           ));
//         } catch (signInError) {
//           // Return failure if sign-in fails
//           return ApiResult.failure(ApiErrorHandler(
//             statusCode: 401,
//             statusMessage: "Email already in use, but login failed.",
//             success: false,
//           ));
//         }
//       }

//       // Return failure for other FirebaseAuthException cases
//       return ApiResult.failure(ApiErrorHandler(
//         statusCode: 400,
//         statusMessage: e.message ?? "An unknown error occurred.",
//         success: false,
//       ));
//     } catch (error) {
//       // Handle unexpected errors
//       return ApiResult.failure(ApiErrorHandler(
//         statusCode: 500,
//         statusMessage: "Unexpected error: ${error.toString()}",
//         success: false,
//       ));
//     }
//   }
