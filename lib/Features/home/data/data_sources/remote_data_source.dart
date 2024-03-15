import 'package:aid_humanity/core/error/exceptions.dart';
import 'package:aid_humanity/core/models/item_model.dart';
import 'package:aid_humanity/core/models/request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class HomeRemoteDataSource {
  Future<List<RequestModel>> getAllRequests();
}

class HomeRemoteDataSourceImplWithFireBase extends HomeRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  HomeRemoteDataSourceImplWithFireBase({required this.firebaseFirestore});
  @override
  Future<List<RequestModel>> getAllRequests() async {
    List<RequestModel> requests = [];
    try {
      CollectionReference<Map<String, dynamic>> requestsCollectionRef =
          firebaseFirestore.collection('request');
      QuerySnapshot requestSnapshot = await requestsCollectionRef.get();

      for (QueryDocumentSnapshot requestsdoc in requestSnapshot.docs) {
        var itemsSnapshot =
            await requestsdoc.reference.collection('items').get();
        print(itemsSnapshot.docs.first.data());
        List<ItemModel> itemModels = itemsSnapshot.docs
            .map((doc) => ItemModel.fromJson(doc.data()))
            .toList();
        print("-------------------------------");
        RequestModel requestModel = RequestModel.fromJson(
            requestsdoc.data() as Map<String, dynamic>, itemModels);

        requests.add(requestModel);
      }
      if (requests.isEmpty) {
        throw NoDataExecption();
      } else {
        return requests;
      }
    } on FirebaseException {
      throw ServerException();
    }
  }
}
