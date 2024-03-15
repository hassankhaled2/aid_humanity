import 'package:hive/hive.dart';
part 'user_entity.g.dart';
@HiveType(typeId: 0)
class UserEntity
{
 @HiveField(0)
  final String ?fullName;
 @HiveField(1)
  final String ?phoneNumber;
 @HiveField(2)
  final String ?email;
 @HiveField(4)
  final String ?address;
 @HiveField(5)
 final String? displayNameGoogle;
 @HiveField(6)
 final String? photoUrl;
 final String? idToken;
 final String? accessToken;
 final String? fcmToken;

 final String? userId;


  UserEntity({this.fullName, this.phoneNumber, this.email, this.address, this.displayNameGoogle, this.photoUrl, this.idToken, this.accessToken, this.fcmToken, this.userId,

  });
}