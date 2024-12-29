import 'package:atef_physics/core/network/api_result.dart';
import 'package:atef_physics/core/models/user_model.dart';

abstract class AuthApiServices {
  Future<ApiResult<UserModel>> login(
      {required String mail, required String pass});

  Future<ApiResult<UserModel>> regester({
    required String mail,
    required String pass,
    required String name,
    required String phoneNumber,
    required String fcmToken,
  });
  Future<ApiResult<UserModel>> update({
    required UserModel user,
    String? mail,
    String? pass,
    String? name,
    String? phoneNumber,
    String? fcmToken,
  });
  Future<void> logout();

  Future<bool> isSessionValid();
}
