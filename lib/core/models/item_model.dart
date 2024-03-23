import 'package:aid_humanity/core/entities/item_entity.dart';

class ItemModel extends ItemEntity {
  const ItemModel({
    required super.type,
    required super.category,
    required super.gender,
    required super.image,
    required super.quantity,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      type: json['type'],
      category: json['category'],
      gender: json['gender'],
      image: json['image'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson(ItemModel itemModel) {
    return <String, dynamic>{
      'type': itemModel.type,
      'category': itemModel.category,
      'gender': itemModel.gender,
      'image': itemModel.image,
      'quantity':itemModel.quantity,
    };
  }
}
