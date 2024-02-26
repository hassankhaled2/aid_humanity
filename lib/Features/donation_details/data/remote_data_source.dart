import 'package:aid_humanity/core/error/exceptions.dart';
import 'package:aid_humanity/core/models/item_model.dart';
import 'package:aid_humanity/core/models/request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:aid_humanity/core/error/faliures.dart';

abstract class DetailsRemoteDataSource {
  Future<Either<Faliure, Unit>> addRequest(RequestModel requestModel, List<ItemModel> items);
}

class DetailsRemoteDataSourceImplWithFireBase extends DetailsRemoteDataSource {
  FirebaseFirestore firestore;
  DetailsRemoteDataSourceImplWithFireBase({
    required this.firestore,
  });
  @override
  Future<Either<Faliure, Unit>> addRequest(RequestModel requestModel, List<ItemModel> items) async {
    try {
      DocumentReference requestDocumentReference = await firestore.collection('request').add(requestModel.toJson(requestModel));
      requestDocumentReference.update({"id": requestDocumentReference.id});

      for (var item in items) {
        firestore.collection('request').doc(requestDocumentReference.id).collection('items').add(item.toJson(item));
      }

      return Future.value(const Right(unit));
    } catch (error) {
      throw ServerException();
    }
  }
}
