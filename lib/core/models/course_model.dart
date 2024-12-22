import 'package:json_annotation/json_annotation.dart';

part 'course_model.g.dart';

@JsonSerializable()
class CourseModel {
  final String id;
  final String title;
  final String photo;
  final List<String> lessons; // List of lesson IDs
  final List<String> enrolledUsers; // List of user IDs

  CourseModel({
    required this.id,
    required this.title,
    required this.photo,
    required this.lessons,
    required this.enrolledUsers,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      "photo": photo,
      'lessons': lessons,
      'enrolledUsers': enrolledUsers,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'] as String,
      title: map['title'] as String,
      photo: map['photo'] as String,
      lessons: List<String>.from(map['lessons'] as List<dynamic>),
      enrolledUsers: List<String>.from(map['enrolledUsers'] as List<dynamic>),
    );
  }
}
