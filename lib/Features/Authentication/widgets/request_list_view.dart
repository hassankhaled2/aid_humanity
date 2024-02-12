import 'package:aid_humanity/Features/Authentication/widgets/request_part.dart';
import 'package:aid_humanity/Features/authentication/models/request_list_model.dart';

import 'package:flutter/material.dart';

class RequestListView extends StatelessWidget {
  const RequestListView({super.key});

  final List<RequestModel> requests = const [
    RequestModel(name: 'Mohammed Ali', location: 'Cairo'),
    RequestModel(name: 'Mosaa Mohamed', location: 'Giza'),
    RequestModel(name: 'Lotfy Mahmoud', location: 'Alex'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        return RequestPart(
          request: requests[index],
        );
      },
    );
  }
}
