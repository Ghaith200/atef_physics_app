import 'package:atef_physics/core/models/course_model.dart';
import 'package:atef_physics/core/models/lesson_model.dart';
import 'package:atef_physics/core/network/api_error_handler.dart';
import 'package:atef_physics/features/courses/courses_api_services/courses_api_firebase_imp.dart';
import 'package:atef_physics/features/courses/courses_api_services/courses_api_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_lessons_state.dart';
part 'course_lessons_cubit.freezed.dart';

class CourseLessonsCubit extends Cubit<CourseLessonsState> {
  CourseLessonsCubit() : super(const CourseLessonsState.initial());
  final loading = const CourseLessonsState.load();
  final CoursesApiServices apiServices = CoursesApiFirebaseImp();

  Future<void> getCourseLessons(CourseModel model) async {
    emit(loading);
    final data = await apiServices.courseLessons(model);
    data.when(
        success: (data) => emit(CourseLessonsState.successAll(data)),
        failure: (e) => emit(CourseLessonsState.error(e)));
  }

  Future<void> addLesson(
      {required CourseModel course,
      required String name,
      required String video,
      required int watchCount}) async {
    emit(loading);
    final data = await apiServices.addLesson(
        model: course, name: name, video: video, watchCount: watchCount);
    data.when(
        success: (data) => emit(CourseLessonsState.add(data)),
        failure: (e) => emit(CourseLessonsState.error(e)));
  }

  Future<void> removeLesson(
      {required CourseModel course, required LessonModel lesson}) async {
    emit(loading);
    final data = await apiServices.removeLesson(course, lesson.id);
    data.when(
      success: (d) => emit(CourseLessonsState.remove(lesson)),
      failure: (e) => emit(CourseLessonsState.error(e)),
    );
  }

  Future<void> updateLesson(
      {required LessonModel lesson,
      required String? name,
      required String? video,
      required int? watchCount}) async {
    final data = await apiServices.updateLesson(
        lesson: lesson, name: name, video: video, watchCount: watchCount);
    data.when(
      success: (d) => emit(CourseLessonsState.update(d)),
      failure: (e) => emit(CourseLessonsState.error(e)),
    );
  }
}
