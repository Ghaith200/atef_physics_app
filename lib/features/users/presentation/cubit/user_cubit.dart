import 'package:atef_physics/core/models/user_model.dart';
import 'package:atef_physics/core/network/api_error_handler.dart';
import 'package:atef_physics/core/utils/storage.dart';
import 'package:atef_physics/core/utils/user_type_enum.dart';
import 'package:atef_physics/features/users/users_api_services/users_api_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'user_state.dart';
part 'user_cubit.freezed.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState.initial());
  final UsersApiServices apiServices = UsersApiServices();

  Future<void> getAllUsers() async {
    emit(const UserState.load());
    final data = await apiServices.getUsers();
    data.when(
      success: (users) => emit(UserState.successAll(users)),
      failure: (error) => emit(UserState.error(error)),
    );
  }

  Future<void> updateUser({
    required UserModel user,
    required String update,
    String? name,
    String? phoneNumber,
    String? fcmToken,

    UserTypeEnum? userTypeEnum,
  }) async {
    emit(const UserState.load());
    final data = await apiServices.updateUser(
      user: user,
      name: name,
      phoneNumber: phoneNumber,
      fcmToken: fcmToken,
      userTypeEnum: userTypeEnum,
    );
    data.when(
      success: (updatedUser) => emit(UserState.update(
        update: update,
        user: updatedUser,
      )),
      failure: (error) => emit(UserState.error(error)),
    );
  }

  Future<void> removeUser(UserModel user) async {
    emit(const UserState.load());
    final data = await apiServices.removeUser(user: user);
    await FirebaseAuth.instance.signOut();
    await Storage.instance.logout();
    data.when(
      success: (_) => emit(UserState.remove(user)),
      failure: (error) => emit(UserState.error(error)),
    );
  }
}
