part of 'course_cubit.dart';

@freezed
class CourseState with _$CourseState {
  const factory CourseState.initial() = _Initial;
  const factory CourseState.load() = CoursesLoading;
  const factory CourseState.successAll(List<CourseModel> models) = AllCourses;
  const factory CourseState.success(CourseModel model) = Courses;
  const factory CourseState.error(ApiErrorHandler error) = CoursesError;
}
