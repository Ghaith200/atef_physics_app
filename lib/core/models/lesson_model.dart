// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'lesson_model.g.dart';

@JsonSerializable()
class LessonModel {
  final String id;
  final String name;
  final String video;
  final int watchCount;

  LessonModel(
      {required this.id,
      required this.name,
      required this.video,
      required this.watchCount});

  factory LessonModel.fromJson(Map<String, dynamic> json) =>
      _$LessonModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonModelToJson(this);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'video': video,
      'watchCount': watchCount
    };
  }

  factory LessonModel.fromMap(Map<String, dynamic> map) {
    return LessonModel(
      id: map['id'] as String,
      name: map['name'] as String,
      video: map['video'] as String,
      watchCount: map['video'] as int,
    );
  }

  LessonModel copyWith({
    String? id,
    String? name,
    String? video,
    int? watchCount,
  }) {
    return LessonModel(
      id: id ?? this.id,
      name: name ?? this.name,
      video: video ?? this.video,
      watchCount: watchCount ?? this.watchCount,
    );
  }
}
