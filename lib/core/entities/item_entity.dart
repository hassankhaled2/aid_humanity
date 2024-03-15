import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  final String type;
  final String category;
  final String gender;
  final String image;
  final int quantity;
  const ItemEntity( {
    required this.quantity,
    required this.type,
    required this.category,
    required this.gender,
    required this.image,
  });

  @override
  List<Object?> get props => [type, gender, image];
}
