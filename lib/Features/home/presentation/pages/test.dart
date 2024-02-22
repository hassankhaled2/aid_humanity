import 'package:aid_humanity/core/models/request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
   List<RequestModel> requests = [];
  bool isLoading = true;
  getData() async {
    final CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection('request');
    QuerySnapshot querySnapshot = await collectionReference.get();
    for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {
      var json = queryDocumentSnapshot.data();
      var requestModel = RequestModel.fromJson(json as Map<String, dynamic>);
      print(requestModel);
      requests.add(requestModel);
    }

    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}