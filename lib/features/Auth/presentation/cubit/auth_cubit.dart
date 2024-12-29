import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:atef_physics/core/network/api_error_handler.dart';
import 'package:atef_physics/core/network/api_result.dart';
import 'package:atef_physics/core/utils/storage.dart';
import 'package:atef_physics/core/utils/user_type_enum.dart';
import 'package:atef_physics/features/Auth/auth_api_services/auth_api_firebase_imp.dart';
import 'package:atef_physics/features/Auth/auth_api_services/auth_api_services.dart';
import 'package:atef_physics/core/models/user_model.dart';
import 'package:atef_physics/features/notification/firebase_api.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState.initial());

  final AuthApiServices api = AuthApiFirebaseImp();

  static UserTypeEnum type = UserTypeEnum.unAuth;

  static AuthCubit get(BuildContext context) =>
      BlocProvider.of<AuthCubit>(context);
  final loading = const AuthState.loading();

  Future<void> login({required String email, required String pass}) async {
    emit(AuthState.loading());

    final ApiResult<UserModel> result =
        await api.login(mail: email, pass: pass);
    final String fcmToken = await FirebaseMessaging.instance.getToken() ?? "";

    result.when(
      success: (UserModel user) async {
        // Check FCM token
        if (user.fcmToken.isNotEmpty &&
            fcmToken != user.fcmToken &&
            user.userType != UserTypeEnum.admin) {
          emit(AuthState.error(ApiErrorHandler(
            statusCode: 00,
            statusMessage: "Please Use Your Phone",
            success: true,
          )));
          return;
        }

        // Update FCM token if empty
        if (user.fcmToken.isEmpty) {
          final updateResult = await api.update(user: user, fcmToken: fcmToken);
          updateResult.when(
            success: (UserModel updatedUser) {
              Storage.instance.user = updatedUser;
              emit(AuthState.success(updatedUser));
            },
            failure: (ApiErrorHandler error) {
              emit(AuthState.error(error));
            },
          );
        } else {
          // Directly store user and emit success if FCM token is valid
          Storage.instance.user = user;
          emit(AuthState.success(user));
        }
      },
      failure: (ApiErrorHandler error) {
        emit(AuthState.error(error));
      },
    );
  }

  Future<void> register({
    required String mail,
    required String pass,
    required String name,
    required String phoneNumber,
  }) async {
    emit(loading);
    final ApiResult<UserModel> user = await api.regester(
      mail: mail,
      pass: pass,
      name: name,
      phoneNumber: phoneNumber,
      fcmToken: FirebaseApi.fcmToken,
    );
    user.when(success: (UserModel user) {
      Storage.instance.user = user;
      Storage.instance.isAuth;

      emit(AuthState.success(user));
    }, failure: (ApiErrorHandler error) {
      emit(AuthState.error(error));
    });
  }

  Future<void> logout() async {
    await Storage.instance.logout();
    api.logout();
  }
}
