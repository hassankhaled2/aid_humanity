  import 'package:aid_humanity/core/entities/item_entity.dart';
import 'package:aid_humanity/core/entities/request_entity.dart';
import 'package:aid_humanity/core/error/faliures.dart';
import 'package:dartz/dartz.dart';

abstract class DetailsRepository{
Future<Either <Failure,Unit>> addRequest(RequestEntity requestEntity,List<ItemEntity> items);
}

