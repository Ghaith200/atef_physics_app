// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'header_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeaderModel _$HeaderModelFromJson(Map<String, dynamic> json) => HeaderModel(
      id: json['id'] as String,
      videoPath: json['path'] as String,
      isVideo: json['isVideo'] as bool,
    );

Map<String, dynamic> _$HeaderModelToJson(HeaderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'path': instance.videoPath,
      'isVideo': instance.isVideo,
    };
