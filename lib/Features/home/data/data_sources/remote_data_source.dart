import 'package:aid_humanity/core/error/exceptions.dart';
import 'package:aid_humanity/core/models/item_model.dart';
import 'package:aid_humanity/core/models/request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRemoteDataSource {
  Future<List<RequestModel>> getAllRequests();
  Future<List<RequestModel>> getLiveRequests(String userId);
  Future<List<RequestModel>> getDoneRequests(String userId);
  Future<Unit> updateRequest(String requestId, String userId, String status);
}

class HomeRemoteDataSourceImplWithFireBase extends HomeRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  HomeRemoteDataSourceImplWithFireBase({required this.firebaseFirestore});
  @override
  Future<List<RequestModel>> getAllRequests() async {
    List<RequestModel> requests = [];
    try {
      QuerySnapshot requestSnapshot = await firebaseFirestore.collection('request').where('status', isEqualTo: 'Pending').get();

      for (QueryDocumentSnapshot requestsdoc in requestSnapshot.docs) {
        var itemsSnapshot = await requestsdoc.reference.collection('items').get();

        List<ItemModel> itemModels = itemsSnapshot.docs.map((doc) => ItemModel.fromJson(doc.data())).toList();

        RequestModel requestModel = RequestModel.fromJson(requestsdoc.data() as Map<String, dynamic>, itemModels);

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

  @override
  Future<List<RequestModel>> getLiveRequests(String userId) async {
    List<RequestModel> liveRequests = [];
    try {
      QuerySnapshot requestSnapshot = await firebaseFirestore.collection('request').where('status', isEqualTo: 'inProgress').where('deliveryId', isEqualTo: userId).get();

      for (QueryDocumentSnapshot requestsdoc in requestSnapshot.docs) {
        var itemsSnapshot = await requestsdoc.reference.collection('items').get();
        List<ItemModel> itemModels = itemsSnapshot.docs.map((doc) => ItemModel.fromJson(doc.data())).toList();
        RequestModel requestModel = RequestModel.fromJson(requestsdoc.data() as Map<String, dynamic>, itemModels);

        liveRequests.add(requestModel);
      }

      if (liveRequests.isEmpty) {
        throw NoDataExecption();
      } else {
        return liveRequests;
      }
    } on FirebaseException {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateRequest(String requestId, String userId, String status) async {
    try {
      await firebaseFirestore.collection('request').doc(requestId).update({'status': status, 'deliveryId': userId});
      return Future.value(unit);
    } on FirebaseException {
      throw ServerException();
    }
  }

  @override
  Future<List<RequestModel>> getDoneRequests(String userId) async {
    List<RequestModel> doneRequests = [];
    try {
      QuerySnapshot requestSnapshot = await firebaseFirestore.collection('request').where('status', isEqualTo: 'done').where('deliveryId', isEqualTo: userId).get();

      for (QueryDocumentSnapshot requestsdoc in requestSnapshot.docs) {
        var itemsSnapshot = await requestsdoc.reference.collection('items').get();
        List<ItemModel> itemModels = itemsSnapshot.docs.map((doc) => ItemModel.fromJson(doc.data())).toList();
        RequestModel requestModel = RequestModel.fromJson(requestsdoc.data() as Map<String, dynamic>, itemModels);

        doneRequests.add(requestModel);
      }

      if (doneRequests.isEmpty) {
        throw NoDataExecption();
      } else {
        return doneRequests;
      }
    } on FirebaseException {
      throw ServerException();
    }
  }
}
