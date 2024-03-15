// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataModel _$UserDataModelFromJson(Map<String, dynamic> json) =>
    UserDataModel(
      displayNameGoogle: json['displayNameGoogle'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
      idToken: json['idToken'] as String?,
      accessToken: json['accessToken'] as String?,
      fullName: json['fullName'] as String?,
      fcmToken: json['fcmToken'] as String?,
      address: json['address'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$UserDataModelToJson(UserDataModel instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'address': instance.address,
      'displayNameGoogle': instance.displayNameGoogle,
      'photoUrl': instance.photoUrl,
      'idToken': instance.idToken,
      'accessToken': instance.accessToken,
      'fcmToken': instance.fcmToken,
      'userId': instance.userId,
    };
