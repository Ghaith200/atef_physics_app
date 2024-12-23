part of 'course_users_cubit.dart';

@freezed
class CourseUsersState with _$CourseUsersState {
  const factory CourseUsersState.initial() = _Initial;
  const factory CourseUsersState.load() = CourseUsersLoading;
  const factory CourseUsersState.successAll(List<UserModel> models) =
      AllCourseUsers;
  const factory CourseUsersState.add(
      {required List<UserModel> addedUsers,
      required List<String> notfound,
      required List<String> enrolled}) = CourseAddUsers;

  const factory CourseUsersState.remove(UserModel model) = CourseUserRemoved;
  const factory CourseUsersState.error(ApiErrorHandler error) =
      CourseUsersError;
}
