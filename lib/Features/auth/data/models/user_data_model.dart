import 'package:json_annotation/json_annotation.dart';

import '../../domain/entites/user_entity.dart';
part 'user_data_model.g.dart';
@JsonSerializable()
class UserDataModel extends UserEntity
{
   UserDataModel({
     required String? displayNameGoogle,
     required String? email,
     required String? photoUrl,
     required String? idToken,
     required String? accessToken,
     String? fullName,
     String? fcmToken,
     String? address,
     String? phoneNumber,
     required String? userId,

  }) : super(fullName:fullName ,phoneNumber:phoneNumber,address:address ,email: email,photoUrl:photoUrl,accessToken:accessToken ,displayNameGoogle:displayNameGoogle ,fcmToken:fcmToken ,idToken: idToken,userId: userId );
   factory UserDataModel.fromJson(Map<String, dynamic> json) => _$UserDataModelFromJson(json);

   /// Connect the generated [_$PersonToJson] function to the `toJson` method.
   Map<String, dynamic> toJson() => _$UserDataModelToJson(this);
}