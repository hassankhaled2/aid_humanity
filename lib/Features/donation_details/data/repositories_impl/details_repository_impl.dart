import 'package:aid_humanity/core/error/exceptions.dart';
import 'package:dartz/dartz.dart';

import 'package:aid_humanity/Features/donation_details/data/remote_data_source.dart';
import 'package:aid_humanity/Features/donation_details/domain/repository/details_repository.dart';
import 'package:aid_humanity/core/entities/item_entity.dart';
import 'package:aid_humanity/core/entities/request_entity.dart';
import 'package:aid_humanity/core/error/faliures.dart';
import 'package:aid_humanity/core/models/item_model.dart';
import 'package:aid_humanity/core/models/request_model.dart';
import 'package:aid_humanity/core/network/connection/network_connection.dart';

class DetailsRepositoryImpl extends DetailsRepository {
  DetailsRemoteDataSource detailsRemoteDataSource;
  ConnctionInfo connctionInfo;
  DetailsRepositoryImpl({
    required this.detailsRemoteDataSource,
    required this.connctionInfo,
  });
  @override
  Future<Either<Faliure, Unit>> addRequest(RequestEntity requestEntity, List<ItemEntity> items) async {
    RequestModel requestModel = RequestModel(time: requestEntity.time, address: requestEntity.address, numberOfItems: requestEntity.numberOfItems);
    List<ItemModel> itemsModels = items.map((itemEntity) => ItemModel(type: itemEntity.type, size: itemEntity.size, season: itemEntity.season, gender: itemEntity.gender, image: itemEntity.image, quantity: itemEntity.quantity)).toList();
    if (await connctionInfo.isConnected) {
      try {
        return await detailsRemoteDataSource.addRequest(requestModel, itemsModels);
      } on ServerException {
        return left(ServerFaliure());
      }
    } else {
      return Left(OfflineFaliure());
    }
  }
}
