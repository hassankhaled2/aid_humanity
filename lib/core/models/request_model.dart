
import 'package:aid_humanity/core/entities/request_entity.dart';

class RequestModel extends RequestEntity {
  const RequestModel({ required super.time, required super.address, required super.numberOfItems});

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      time: json['time'],
      address: json['address'],
      numberOfItems: json['numberOfItems'],
    );
  }

  Map<String, dynamic> toJson(RequestModel requestModel) {
    return <String, dynamic>{
      'time':requestModel.time,
      'address':requestModel.address,
      'numberOfItems':requestModel.numberOfItems,
    };
  }
}
