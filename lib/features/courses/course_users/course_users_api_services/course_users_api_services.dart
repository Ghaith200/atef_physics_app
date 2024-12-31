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
      List<UserModel> enrolledUsers = [];
      List<String> notFoundUsers = [];
      Set<String> courseUsers =
          model.users.toSet(); // Local cache of existing users

      final coursedoc = FirebaseFirestore.instance
          .collection(FirebaseStrings.coures)
          .doc(model.id);

      // Chunking phoneNumbers to handle Firestore's limit
      for (var chunk in phoneNumbers.chunked(10)) {
        final userInfo = await FirebaseFirestore.instance
            .collection(FirebaseStrings.users)
            .where(FirebaseStrings.phoneNumber, whereIn: chunk)
            .get();

        // Process found users
        for (var element in userInfo.docs) {
          final data = element.data();
          final userId = element.id;
          final number = data[FirebaseStrings.phoneNumber];

          if (courseUsers.contains(userId)|| model.users.contains(userId) ) {
            // Already enrolled
            enrolledUsers.add(UserModel(
              uid: userId,
              name: data[FirebaseStrings.name],
              phoneNumber: number,
              email: "", // Add email if available
              fcmToken: data[FirebaseStrings.fcmToken],
              userType:
                  UserTypeEnum.values.byName(data[FirebaseStrings.userType]),
            ));
          } else {
            // Add to Firestore and local cache
            await coursedoc.update({
              FirebaseStrings.users: FieldValue.arrayUnion([userId])
            });

            addedUsers.add(UserModel(
              uid: userId,
              name: data[FirebaseStrings.name],
              phoneNumber: number,
              email: "", // Add email if available
              fcmToken: data[FirebaseStrings.fcmToken],
              userType:
                  UserTypeEnum.values.byName(data[FirebaseStrings.userType]),
            ));
          }
        }

        // Determine not found users
        final foundNumbers = userInfo.docs
            .map((e) => e.data()[FirebaseStrings.phoneNumber])
            .toSet();

        notFoundUsers
            .addAll(chunk.where((number) => !foundNumbers.contains(number)));
      }

      return ApiResult.success({
        FirebaseStrings.addedUsers: addedUsers,
        FirebaseStrings.enrolledUsers: enrolledUsers,
        FirebaseStrings.notFoundUsers: notFoundUsers,
      });
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler(
          statusCode: 500, // Use a meaningful status code
          statusMessage: e.toString(),
          success: false));
    }
  }
}

extension ListChunking<E> on List<E> {
  List<List<E>> chunked(int chunkSize) {
    List<List<E>> chunks = [];
    for (var i = 0; i < length; i += chunkSize) {
      chunks.add(sublist(i, i + chunkSize > length ? length : i + chunkSize));
    }
    return chunks;
  }
}
