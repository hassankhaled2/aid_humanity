import 'package:aid_humanity/Features/donation_details/domain/repository/details_repository.dart';
import 'package:aid_humanity/core/entities/item_entity.dart';
import 'package:aid_humanity/core/entities/request_entity.dart';
import 'package:aid_humanity/core/error/faliures.dart';
import 'package:dartz/dartz.dart';

class AddRequestUSeCase {
  DetailsRepository detailsRepository;
  AddRequestUSeCase({
    required this.detailsRepository,
  });

  Future<Either<Faliure, Unit>> addRequest(RequestEntity requestEntity,List<ItemEntity>items) {
    return detailsRepository.addRequest(requestEntity,items);
  }
}
