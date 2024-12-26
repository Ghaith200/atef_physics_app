import 'package:json_annotation/json_annotation.dart';

part 'header_model.g.dart';

@JsonSerializable()
class HeaderModel {
  final String id;
  @JsonKey(name: "path")
  final String videoPath;
  final bool isVideo;

  HeaderModel({
    required this.id,
    required this.videoPath,
    required this.isVideo,
  });

  /// Factory constructor for creating a new `HeaderModel` instance from a map.
  factory HeaderModel.fromJson(Map<String, dynamic> json) =>
      _$HeaderModelFromJson(json);

  /// Method to convert the `HeaderModel` instance into a map.
  Map<String, dynamic> toJson() => _$HeaderModelToJson(this);

  /// A copy with method to easily create modified instances.
  HeaderModel copyWith({
    String? id,
    String? videoPath,
    bool? isVideo,
  }) {
    return HeaderModel(
      id: id ?? this.id,
      videoPath: videoPath ?? this.videoPath,
      isVideo: isVideo ?? this.isVideo,
    );
  }
}
