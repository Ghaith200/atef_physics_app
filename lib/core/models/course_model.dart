// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'course_model.g.dart';

@JsonSerializable()
class CourseModel {
  final String id;
  final String title;
  final String photo;
  final int price;
  final List<String> lessons; // List of lesson IDs
  final List<String> users; // List of user IDs

  CourseModel({
    required this.id,
    required this.title,
    required this.photo,
    required this.price,
    required this.lessons,
    required this.users,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      "photo": photo,
      "price": price,
      'lessons': lessons,
      'users': users,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      id: map['id'] as String,
      title: map['title'] as String,
      photo: map['photo'] as String,
      price: map['photo'] as int,
      lessons: List<String>.from(map['lessons'] as List<dynamic>),
      users: List<String>.from(map['users'] as List<dynamic>),
    );
  }

  CourseModel copyWith({
    String? id,
    String? title,
    String? photo,
    int? price,
    List<String>? lessons,
    List<String>? users,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      photo: photo ?? this.photo,
      price: price ?? this.price,
      lessons: lessons ?? this.lessons,
      users: users ?? this.users,
    );
  }
}
