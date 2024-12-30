// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'lesson_model.g.dart';

@JsonSerializable()
class LessonModel {
  final String id;
  final String name;
  final String video;
  final String? file;
  final int watchCount;
  final int userWatchCount;

  LessonModel({
    required this.id,
    required this.name,
    required this.video,
     this.file,
    required this.watchCount,
    this.userWatchCount = 0,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) =>
      _$LessonModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonModelToJson(this);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'video': video,
      'watchCount': watchCount,
      "userWatchCount": userWatchCount
    };
  }

 


  LessonModel copyWith({
    String? id,
    String? name,
    String? video,
    String? file,
    int? watchCount,
    int? userWatchCount,
  }) {
    return LessonModel(
      id: id ?? this.id,
      name: name ?? this.name,
      video: video ?? this.video,
      file: file ?? this.file,
      watchCount: watchCount ?? this.watchCount,
      userWatchCount: userWatchCount ?? this.userWatchCount,
    );
  }
}
