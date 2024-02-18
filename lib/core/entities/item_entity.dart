import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  final String type;
  final String size;
  final String season;
  final String gender;
  final String image;
  final int quantity;
  const ItemEntity({
    required this.type,
    required this.size,
    required this.season,
    required this.gender,
    required this.image,
    required this.quantity,
  });

  @override
  List<Object?> get props => [type, gender, image];
}
