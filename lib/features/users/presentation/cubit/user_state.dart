part of 'user_cubit.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;

  const factory UserState.load() = UserLoading;

  const factory UserState.successAll(List<UserModel> models) = AllUser;

  const factory UserState.update({
    required UserModel user,
  }) = usersUpdate;

  const factory UserState.remove(UserModel model) = UserRemoved;

  const factory UserState.error(ApiErrorHandler error) = UserError;
}
