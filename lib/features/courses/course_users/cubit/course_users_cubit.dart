import 'package:atef_physics/core/constants/firebase_strings.dart';
import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/models/user_model.dart';
import 'package:atef_physics/core/network/api_error_handler.dart';
import 'package:atef_physics/features/courses/course_users/course_users_api_services/course_users_api_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_users_state.dart';
part 'course_users_cubit.freezed.dart';

class CourseUsersCubit extends Cubit<CourseUsersState> {
  CourseUsersCubit() : super(const CourseUsersState.initial());
  final loading = const CourseUsersState.load();
  final CourseUsersApiServices apiServices = CourseUsersApiServices();

  Future<void> getCourseUsers(CourseModel model) async {
    emit(loading);
    final data = await apiServices.courseUsers(model);
    data.when(
        success: (data) => emit(CourseUsersState.successAll(data)),
        failure: (e) => emit(CourseUsersState.error(e)));
  }

  Future<void> removeUser(
      {required CourseModel course, required UserModel userId}) async {
    emit(loading);
    final data = await apiServices.removeUser(course, userId.uid);
    data.when(
      success: (d) => emit(CourseUsersState.remove(userId)),
      failure: (e) => emit(CourseUsersState.error(e)),
    );
  }

  Future<void> addUsers(
      {required CourseModel model, required List<String> phoneNumbers}) async {
    final data = await apiServices.addUser(model, phoneNumbers);
    data.when(
        success: (success) => emit(CourseUsersState.add(
              addedUsers:
                  success[FirebaseStrings.addedUsers]! as List<UserModel>,
              enrolled:
                  success[FirebaseStrings.enrolledUsers]! as List<UserModel>,
              notfound: success[FirebaseStrings.notFoundUsers]! as List<String>,
            )),
        failure: (e) => emit(CourseUsersState.error(e)));
  }
}
