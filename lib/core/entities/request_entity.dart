import 'package:equatable/equatable.dart';

import 'package:aid_humanity/core/entities/item_entity.dart';

class RequestEntity extends Equatable {
  final String? id;
  final DateTime time;
  final Map<String, dynamic> address;
  final int numberOfItems;
  final List<ItemEntity>? items;
  final String userId;
  final String status;
  final String? deliveryId;
  final bool? qrScanned;

  const RequestEntity({
    this.id,
    required this.time,
    required this.address,
    required this.numberOfItems,
    this.items,
    required this.userId,
    required this.status,
    this.deliveryId,
    required this.qrScanned,
  });

  @override
  List<Object?> get props => [time, address, numberOfItems, items, userId];
}
