import 'package:equatable/equatable.dart';

import 'package:aid_humanity/core/entities/item_entity.dart';

class RequestEntity extends Equatable {
  final DateTime time;
  final Map<String, dynamic> address;
  final int numberOfItems;
  final List<ItemEntity>? items;
  final String userId;
  final String status;

  const RequestEntity({required this.time, required this.address, required this.numberOfItems, required this.userId,required this.status, this.items});

  @override
  List<Object?> get props => [time, address, numberOfItems, items];
}
