part of 'course_lessons_cubit.dart';

@freezed
class CourseLessonsState with _$CourseLessonsState {
  const factory CourseLessonsState.initial() = _Initial;
  const factory CourseLessonsState.load() = CourseLessonsLoading;
  const factory CourseLessonsState.successAll(List<LessonModel> models) =
      AllCourseLessons;
  const factory CourseLessonsState.success(LessonModel models) = CourseLessons;
  const factory CourseLessonsState.remove(LessonModel model) =
      CourseLessonRemoved;
  const factory CourseLessonsState.error(ApiErrorHandler error) =
      CourseLessonError;
}
