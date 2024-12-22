import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/network/api_error_handler.dart';
import 'package:atef_physics/features/courses/courses_api_services/courses_api_firebase_imp.dart';
import 'package:atef_physics/features/courses/courses_api_services/courses_api_services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'course_state.dart';
part 'course_cubit.freezed.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit() : super(const CourseState.initial());
  final loading = const CourseState.load();
  final CoursesApiServices apiServices = CoursesApiFirebaseImp();
  Future<void> getCourses() async {
    emit(loading);
    final data = await apiServices.coursesList();
    data.when(
        success: (data) => emit(CourseState.successAll(data)),
        failure: (e) => emit(CourseState.error(e)));
  }

  Future<void> addCourse({
    required String title,
    required String photo,
    required int price,
  }) async {
    emit(loading);
    final data =
        await apiServices.addCourse(title: title, photo: photo, price: price);
    data.when(
        success: (c) => emit(CourseState.success(c)),
        failure: (e) => emit(CourseState.error(e)));
  }
}
