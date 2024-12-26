part of 'course_cubit.dart';

@freezed
class CourseState with _$CourseState {
  
  const factory CourseState.initial() = _Initial;
  const factory CourseState.load() = CoursesLoading;
  const factory CourseState.successAll(List<CourseModel> models) = AllCourses;
  const factory CourseState.add(CourseModel model) = AddCourses;
  const factory CourseState.update(CourseModel model) = UpdateCourses;
  const factory CourseState.remove(CourseModel model) = RemoveCourses;
  const factory CourseState.error(ApiErrorHandler error) = CoursesError;
}
