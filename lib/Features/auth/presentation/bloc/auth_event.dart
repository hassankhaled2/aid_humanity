part of 'auth_bloc.dart';

@immutable
abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpButtonPressed extends SignUpEvent {
  final String fullName;
  final String email;
  final String password;
  final String phone;
  final String street;
  final String city;
  final String region;
  final String country;
  final String flatNumber;
  final String floorNumber;
  final double latitude;
  final double longitude;

  const SignUpButtonPressed({
    required this.fullName,
    required this.email,
    required this.password,
    required this.phone,
    required this.street,
    required this.city,
    required this.region,
    required this.country,
    required this.flatNumber,
    required this.floorNumber,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [
    fullName,
    email,
    password,
    phone,
    street,
    city,
    region,
    country,
    flatNumber,
    floorNumber,
    latitude,
    longitude,
  ];
}
