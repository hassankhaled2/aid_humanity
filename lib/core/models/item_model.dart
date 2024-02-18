import 'package:aid_humanity/core/entities/item_entity.dart';

class ItemModel extends ItemEntity{
const  ItemModel({required super.type, required super.size, required super.season, required super.gender, required super.image, required super.quantity});


  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      type: json['type'],
      size: json['size'],
      season: json['season'],
      gender: json['gender'],
      image: json['image'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson(ItemModel itemModel) {
    return <String, dynamic>{
      'type': itemModel.type,
      'size':itemModel.size,
      'season':itemModel.season,
      'gender':itemModel.gender,
      'image':itemModel.image,
      'quantity':itemModel.quantity,
    };
  }

}