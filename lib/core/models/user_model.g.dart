// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      uid: json['uid'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      userType: $enumDecode(_$UserTypeEnumEnumMap, json['userType']),
      fcmToken: json['fcmToken'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'fcmToken': instance.fcmToken,
      'userType': _$UserTypeEnumEnumMap[instance.userType]!,
    };

const _$UserTypeEnumEnumMap = {
  UserTypeEnum.unAuth: 'unAuth',
  UserTypeEnum.user: 'user',
  UserTypeEnum.admin: 'admin',
};
