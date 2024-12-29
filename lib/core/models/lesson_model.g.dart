// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonModel _$LessonModelFromJson(Map<String, dynamic> json) => LessonModel(
      id: json['id'] as String,
      name: json['name'] as String,
      video: json['video'] as String,
      file: json['file'] as String?,
      watchCount: (json['watchCount'] as num).toInt(),
      userWatchCount: (json['userWatchCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$LessonModelToJson(LessonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'video': instance.video,
      'file': instance.file,
      'watchCount': instance.watchCount,
      'userWatchCount': instance.userWatchCount,
    };
