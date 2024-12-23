// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
      id: json['id'] as String,
      title: json['title'] as String,
      photo: json['photo'] as String,
      price: (json['price'] as num).toInt(),
      lessons:
          (json['lessons'] as List<dynamic>).map((e) => e as String).toList(),
      users: (json['users'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'photo': instance.photo,
      'price': instance.price,
      'lessons': instance.lessons,
      'users': instance.users,
    };
