import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/network/api_error_handler.dart';
import 'package:atef_physics/features/courses/course/course_api_services/course_api_services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'course_state.dart';
part 'course_cubit.freezed.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit() : super(const CourseState.initial());
  final loading = const CourseState.load();
  final CourseApiServices apiServices = CourseApiServices();

  Future<void> getCourses() async {
    emit(loading);
    final data = await apiServices.coursesList();
    data.when(
        success: (data) => emit(CourseState.successAll(data)),
        failure: (e) => emit(CourseState.error(e)));
  }

  Future<void> getCourse(CourseModel model) async {
    emit(loading);
    final data = await apiServices.course(model.id);
    data.when(
        success: (data) => emit(CourseState.update(model = data)),
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
        success: (c) => emit(CourseState.add(c)),
        failure: (e) => emit(CourseState.error(e)));
  }

  Future<void> updateCOurse({
    required CourseModel model,
    required String title,
    required String photo,
    required int price,
  }) async {
    final data = await apiServices.updateCourse(
        model: model, title: title, price: price, photo: photo);
    data.when(
      success: (data) => emit(CourseState.update(data)),
      failure: (error) => emit(CourseState.error(error)),
    );
  }

  Future<void> removeCourses({
    required CourseModel model,
  }) async {
    final data = await apiServices.removeCourse(model);
    data.when(
      success: (_) => emit(CourseState.remove(model)),
      failure: (error) => emit(CourseState.error(error)),
    );
  }
}
