import 'package:json_annotation/json_annotation.dart';

import 'package:atef_physics/core/utils/user_type_enum.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String uid;
  final String name;
  final String phoneNumber;
  final String email;
  final String fcmToken;
  final UserTypeEnum userType;

  UserModel({
    required this.uid,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.userType,
    required this.fcmToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'fcmToken': fcmToken,
      'userType': userType.name,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      email: map['email'] as String,
      fcmToken: map['fcmToken'] as String,
      userType: UserTypeEnum.values.byName(map["userType"] as String),
    );
  }
}
