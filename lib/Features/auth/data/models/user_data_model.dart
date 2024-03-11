import 'package:json_annotation/json_annotation.dart';

import '../../domain/entites/user_entity.dart';
part 'user_data_model.g.dart';
@JsonSerializable()
class UserDataModel extends UserEntity
{
   UserDataModel({
    required String fullName,
    required String email,
    required String phoneNumber,
     required String address,

  }) : super(fullName:fullName ,phoneNumber:phoneNumber,address:address ,email: email);
   factory UserDataModel.fromJson(Map<String, dynamic> json) => _$UserDataModelFromJson(json);

   /// Connect the generated [_$PersonToJson] function to the `toJson` method.
   Map<String, dynamic> toJson() => _$UserDataModelToJson(this);
}